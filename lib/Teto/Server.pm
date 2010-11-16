package Teto::Server;
use Any::Moose;

use Teto::Logger qw($logger);
use Teto::Feeder;
use Teto::FileCache;
use Teto::Server::Queue;
use Teto::Server::Buffer;

use Coro;
use Coro::Timer;
use Text::MicroTemplate::File;

use Plack::Request;
use Plack::Builder;

use POSIX qw(ceil);

has queue => (
    is  => 'rw',
    isa => 'Teto::Server::Queue',
    lazy_build => 1,
);

sub _build_queue {
    my $self = shift;
    return Teto::Server::Queue->new(server => $self);
}

has feeder => (
    is  => 'rw',
    isa => 'Teto::Feeder',
    lazy_build => 1,
);

sub _build_feeder {
    my $self = shift;
    return Teto::Feeder->new(queue => $self->queue);
}

has file_cache => (
    is  => 'rw',
    isa => 'Teto::FileCache',
    default => sub { Teto::FileCache->new },
);

has mt => (
    is  => 'rw',
    isa => 'Text::MicroTemplate',
    default => sub { Text::MicroTemplate::File->new },
);

has status => (
    is  => 'rw',
    isa => 'HashRef',
    default => sub { +{} },
);

has bytes_sent => (
    is  => 'rw',
    isa => 'Int',
    default => sub { 0 },
    traits  => [ 'Number' ],
    handles => {
        incremenet_bytes_sent => 'add',
    },
);

has bytes_timeline => (
    is  => 'rw',
    isa => 'ArrayRef[Int]',
    default => sub { +[] },

);

has buffer => (
    is  => 'rw',
    isa => 'Teto::Server::Buffer',
    default => sub { Teto::Server::Buffer->new },
    handles => {
        push_buffer => 'write',
    },
);

has client_writer => (
    is  => 'rw',
);

__PACKAGE__->meta->make_immutable;

no Any::Moose;

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

sub to_psgi_app {
    my $self = shift;

    my $app = sub {
        my $env = shift;
        my $req = Plack::Request->new($env);
        my $res = $req->new_response(200);

        if ($req->path eq '/') {
            my $content = $self->mt->render_file('root/index.mt', server => $self)->as_string;
            utf8::encode $content if utf8::is_utf8 $content;
            $res->content_type('text/html; charset=utf-8');
            $res->content($content);
            return $res->finalize;
        }

        if ($req->path eq '/stream') {
            if ($self->client_writer) {
                # 他のクライアントが聴いてる
                $res->code(503);
                return $res->finalize;
            }

            $self->buffer->do_interleave($req->header('Icy-Metadata') ? 1 : 0);

            return $self->make_stream_writer($req);
        }

        $res->code(302);
        $res->headers([ Location => '/' ]);

        if ($req->path eq '/add') {
            $self->enqueue(split /\n/, $req->param('url') || '');
        }
        elsif ($req->path eq '/set_next') {
            $self->queue->next_index(int $req->param('i'));
        }
        elsif ($req->path eq '/remove') {
            $self->queue->delete_queue(int $req->param('i'));
        }
        else {
            $res->code(404);
        }

        return $res->finalize;
    };

    builder {
        enable 'Static', path => qr(^/static/), root => '.';
        $app;
    };
}

sub make_stream_writer {
    my ($self, $req) = @_;

    return sub {
        my $respond = shift;
        my $writer = $respond->([
            200, [
                'Content-Type' => 'audio/mpeg',
                'Icy-Metaint'  => $self->buffer->META_INTERVAL,
                'Icy-Name'     => 'tetocast',
                'Icy-Url'      => $req->request_uri,
            ]
        ]);

        $writer->can('poll_cb') or die 'this server does not implement $writer->poll_cb($cb)';

        $self->client_writer($writer);

        $writer->poll_cb(unblock_sub {
            my $writer = shift;
            if ($writer) {
                Coro::Timer::sleep 1 while $self->buffer->is_empty;

                my $data = $self->buffer->read(256 * 1024);
                $writer->write($data);
                $self->incremenet_bytes_sent(length $data);
            } else {
                $logger->log(error => "$_[0]");

                # meta_interval の整合性を保ったまま残りのバイト列を破棄
                substr $self->buffer->{buffer}, 0, $self->buffer->length - ($self->buffer->META_INTERVAL - $self->buffer->meta_interval), '';
                $self->client_writer(undef);
            }
        });
    };
}

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
    return scalar @{ $self->bytes_timeline } - $self->current_track_number;
}

sub bytes_remaining {
    my $self = shift;
    for (0 .. $#{ $self->bytes_timeline }) {
        if ($self->bytes_sent < $self->bytes_timeline->[$_]) {
            return $self->bytes_timeline->[$_] - $self->bytes_sent;
        }
    }
    return undef;
}

sub enqueue {
    my ($self, @args) = @_;
    $self->feeder->feed_async(@args);
}

# XXX ちょっと PSGI の仕様を拡張している (on_error)

sub Twiggy::Writer::poll_cb {
    my ($self, $cb) = @_;
    $self->{handle}->on_drain($cb && sub { $cb->($self) });
    $self->{handle}->on_error($cb && sub { $cb->(undef, $_[2]) });
}

1;
