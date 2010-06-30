package Teto::Server;
use Any::Moose;

use AnyEvent::HTTPD;
use Text::MicroTemplate::File;
use POSIX;
use Encode;

use Teto::Server::Queue;
use Teto::Logger qw($logger);
use Teto::Feeder;
use Teto::Playlist;

use constant META_INTERVAL => 16_000;

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
);

has 'bytes_timeline', (
    is  => 'rw',
    isa => 'ArrayRef[Int]',
    default => sub { +[] },

);

sub buffer : lvalue {
    shift->{buffer};
}

sub interval : lvalue {
    my $self = shift;
    $self->{interval} ||= META_INTERVAL;
    $self->{interval};
}

sub BUILD {
    my $self = shift;
    $self->buffer = '';
    $self->setup_callbacks;
}

__PACKAGE__->meta->make_immutable;

sub _build_queue {
    my $self = shift;
    return Teto::Server::Queue->new(server => $self);
}

sub _build_httpd {
    my $self = shift;
    return AnyEvent::HTTPD->new(port => 9090); # TODO config
}

sub _build_feeder {
    my $self = shift;
    return Teto::Feeder->new(queue => $self->queue);
}

sub update_status {
    my ($self, %status) = @_;
    no warnings 'uninitialized';
    Encode::_utf8_off $status{title} if Encode::is_utf8 $status{title};
    if ($self->status->{title} ne $status{title}) {
        $logger->log(info => "status title: $self->{status}->{title} -> $status{title}");
    }
    $self->status(+{ %status });
}

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
        '/' => sub {
            my ($server, $req) = @_;
            $req->respond([
                200, 'OK', { 'Content-Type' => 'text/html' }, 
                $self->mt->render_file('root/index.mt', server => $self)->as_string,
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
                'Icy-Metaint'  => META_INTERVAL,
                'Icy-Name'     => 'tetocast',
                'Icy-Url'      => $req->url,
            }, sub {
                my ($data_cb) = @_;
                unless ($data_cb) {
                    $logger->log(info => 'client disconnected');
                    return;
                }

                my $send = sub {
                    my $data = substr $self->{buffer}, 0, 256 * 1024, '';
                    $data_cb->($data);
                    $self->incremenet_bytes_sent(length $data);
                };

                unless ($self->buffer_underrun) {
                    $send->();
                    return;
                }

                $logger->log(debug => 'buffer underrun');
                # TODO guard で外から叩くようにする
                my $w; $w = AE::timer 0, 1, sub {
                    $self->queue->start;
                    return unless $self->buffer_length;
                    $logger->log(debug => 'timer; write');
                    $send->();
                    undef $w;
                };
            }
        ]);
    }
}

sub buffer_length {
    length(shift->buffer);
}

sub buffer_is_full {
    shift->buffer_length > 4 * 1024 * 1024;
}

sub buffer_underrun {
    shift->buffer_length < 1 * 1024 * 1024
}

sub push_buffer {
    my $self = shift;
    my $data = join '', @_;

    while (length($data) >= $self->interval) {
        $self->buffer .= substr $data, 0, $self->interval, '';
        my $meta = qq(StreamTitle='$self->{status}->{title}';);
        my $len = ceil(length($meta) / 16);
        $self->buffer .= chr($len) . $meta . ("\x00" x (16 * $len - length $meta));
        $self->interval = META_INTERVAL;
    }
    $self->buffer .= $data;
    $self->interval -= length($data);
}

sub incremenet_bytes_sent {
    my ($self, $delta) = @_;
    $self->bytes_sent($self->bytes_sent + $delta);
}

sub wrote_one_track {
    my $self = shift;
    push @{ $self->bytes_timeline }, $self->bytes_sent + $self->buffer_length;
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

sub enqueue {
    my $self = shift;
    $self->feeder->feed($_) for @_;
}

1;
