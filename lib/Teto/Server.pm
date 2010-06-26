package Teto::Server;
use Any::Moose;

use AnyEvent::HTTPD;
use Text::MicroTemplate::File;
use POSIX;
use Encode;

use Teto::Server::Queue;
use Teto::Logger qw($logger);
use Teto::Feeder;

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

has 'server', (
    is  => 'rw',
    isa => 'AnyEvent::HTTPD',
    lazy_build => 1,
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

sub update_status {
    my ($self, %status) = @_;
    no warnings 'uninitialized';
    Encode::_utf8_off $status{title} if Encode::is_utf8 $status{title};
    if ($self->status->{title} ne $status{title}) {
        $logger->log(info => "status title: $self->{status}->{title} -> $status{title}");
    }
    $self->status(+{ %status });
}

sub _build_queue {
    my $self = shift;
    return Teto::Server::Queue->new(server => $self);
}

sub _build_server {
    my $self = shift;
    return AnyEvent::HTTPD->new(port => 9090); # TODO config
}

sub setup_callbacks {
    my $self = shift;

    $self->server->reg_cb(
        '/stream' => $self->stream_handler,
        '/add'    => sub {
            my ($server, $req) = @_;
            $server->stop_request;
            $self->enqueue(
                map { split /\n/, $_ } @{ $req->{parm}->{url}->[0] || [] }
            );
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

        my $eat_buffer_chunk = sub {
            my $data = substr $self->{buffer}, 0, 256 * 1024, '';
        };

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

                if ($self->buffer_length >= 1 * 1024 * 1024) {
                    $data_cb->($eat_buffer_chunk->());
                    return;
                }

                $logger->log(debug => 'buffer underrun');
                # TODO guard で外から叩くようにする
                my $w; $w = AE::timer 0, 1, sub {
                    $self->queue->start;
                    return unless $self->buffer_length;
                    $logger->log(debug => 'timer; write');
                    $data_cb->($eat_buffer_chunk->());
                    undef $w;
                };
            }
        ]);
    }
}

sub buffer_length {
    length(shift->buffer);
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

sub enqueue {
    my $self = shift;
    $self->feeder->feed($_) for @_;
}

sub _build_feeder {
    my $self = shift;
    return Teto::Feeder->new(queue => $self->queue);
}

1;
