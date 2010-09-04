package Teto::Server;
use Any::Moose;

with any_moose('X::Getopt::Strict');

use Teto::Server::Queue;
use Teto::Logger qw($logger);
use Teto::Feeder;
use Teto::Playlist;
use Teto::FileCache;

use AnyEvent::HTTPD;
use Text::MicroTemplate::File;

use POSIX qw(ceil);

has 'port', (
    is  => 'rw',
    isa => 'Int',
    default => 9090,
    metaclass => 'Getopt',
);

has 'queue', (
    is  => 'rw',
    isa => 'Teto::Server::Queue',
    lazy_build => 1,
);

has 'feeder', (
    is  => 'rw',
    isa => 'Teto::Feeder',
    lazy_build => 1,
);

has 'httpd', (
    is  => 'rw',
    isa => 'AnyEvent::HTTPD',
    lazy_build => 1,
);

has 'playlist', (
    is  => 'rw',
    isa => 'Teto::Playlist',
    default => sub { Teto::Playlist->new },
);

has 'file_cache', (
    is  => 'rw',
    isa => 'Teto::FileCache',
    default => sub { Teto::FileCache->new },
);

has 'mt', (
    is  => 'rw',
    isa => 'Text::MicroTemplate',
    default => sub { Text::MicroTemplate::File->new },
);

has 'status', (
    is  => 'rw',
    isa => 'HashRef',
    default => sub { +{} },
);

has 'bytes_sent', (
    is  => 'rw',
    isa => 'Int',
    default => sub { 0 },
    traits  => [ 'Number' ],
    handles => {
        incremenet_bytes_sent => 'add',
    },
);

has 'bytes_timeline', (
    is  => 'rw',
    isa => 'ArrayRef[Int]',
    default => sub { +[] },

);

has 'buffer', (
    is  => 'rw',
    isa => 'Teto::Server::Buffer',
    default => sub { require Teto::Server::Buffer; Teto::Server::Buffer->new },
    # handles => {
    #     push_buffer => 'write',
    # },
);

__PACKAGE__->meta->make_immutable;

# ------ Builder ------

sub _build_queue {
    my $self = shift;
    return Teto::Server::Queue->new(server => $self);
}

sub _build_httpd {
    my $self = shift;
    return AnyEvent::HTTPD->new(port => $self->port);
}

sub _build_feeder {
    my $self = shift;
    return Teto::Feeder->new(queue => $self->queue);
}

# ------ Status ------

sub update_status {
    my ($self, %status) = @_;
    no warnings 'uninitialized';
    utf8::downgrade $status{title}, 1 if utf8::is_utf8 $status{title};
    if ($self->status->{title} ne $status{title}) {
        $logger->log(notice => "status title: $self->{status}->{title} -> $status{title}");
    }
    $self->status(+{ %status });
    $self->buffer->meta_data(+{ %status });
}

# ------ HTTPD ------

sub setup_callbacks {
    my $self = shift;

    $self->httpd->reg_cb(
        '/stream' => $self->stream_handler,
        '/add' => sub {
            my ($server, $req) = @_;
            $server->stop_request;
            $self->enqueue(
                map { split /\n/, $_ } @{ $req->{parm}->{url}->[0] || [] }
            );
            $req->respond({ redirect => '/' });
        },
        '/remove' => sub {
            my ($server, $req) = @_;
            $server->stop_request;
            $self->queue->remove(int $req->parm('i'));
            $req->respond({ redirect => '/' });
        },
        '/static' => sub {
            my ($server, $req) = @_;
            $server->stop_request;

            my $path = $req->url->path;
            $path =~ s<^/+><>;
            open my $fh, '<', $path or do {
                warn "$path: $!";
                $req->respond([
                    404, 'Not Found', { 'Content-Type' => 'text/html' }, '404 Not Found'
                ]);
                return;
            };
            $req->respond({
                content => [ 'image/gif', do { local $/; <$fh> } ]
            })
        },
        '/' => sub {
            my ($server, $req) = @_;
            my $content = $self->mt->render_file('root/index.mt', server => $self)->as_string;
            utf8::encode $content if utf8::is_utf8 $content;
            $req->respond([
                200, 'OK', { 'Content-Type' => 'text/html' }, $content
            ]);
        },
    );
}

sub stream_handler {
    my $self = shift;

    return sub {
        my ($server, $req) = @_;

        $server->stop_request;

        $req->respond([
            200, 'OK', {
                'Content-Type' => 'audio/mpeg',
                'Icy-Metaint'  => $self->buffer->meta_interval,
                'Icy-Name'     => 'tetocast',
                'Icy-Url'      => $req->url,
            }, sub {
                my ($data_cb) = @_;
                unless ($data_cb) {
                    $logger->log(info => 'client disconnected');
                    return;
                }

                my $send = sub {
                    my $data = $self->buffer->read(256 * 1024);
                    $data_cb->($data);
                    $self->incremenet_bytes_sent(length $data);
                };

                unless ($self->buffer->underruns) {
                    $send->();
                    return;
                }

                $logger->log(debug => 'buffer underrun');
                # TODO guard で外から叩くようにする
                my $w; $w = AE::timer 0, 1, sub {
                    $self->queue->start;
                    return unless $self->buffer->length;
                    $logger->log(debug => 'timer; write');
                    $send->();
                    undef $w;
                };
            }
        ]);
    }
}

# ------ Buffer ------
sub push_buffer {
    shift->buffer->write(@_);
}

# sub incremenet_bytes_sent {
#     my ($self, $delta) = @_;
#     $self->bytes_sent($self->bytes_sent + $delta);
# }

# ------ Track ------

sub wrote_one_track {
    my $self = shift;
    push @{ $self->bytes_timeline }, $self->bytes_sent + $self->buffer->length;
}

sub current_track_number {
    my $self = shift;
    for (0 .. $#{ $self->bytes_timeline }) {
        if ($self->bytes_sent < $self->bytes_timeline->[$_]) {
            return $_ + 1;
        }
    }
    return scalar @{ $self->bytes_timeline } + 1;
}

sub remaining_tracks {
    my $self = shift;
    scalar @{ $self->bytes_timeline } - $self->current_track_number;
}

# ------ Queuing ------

sub enqueue {
    my $self = shift;
    $self->feeder->feed($_) for @_;
}

1;
