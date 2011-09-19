package Teto::Server;
use Mouse;
use Teto;
use Teto::Control;
use Coro;
use Encode;
use Router::Simple;
use Plack::Request;
use Text::MicroTemplate::File;
use Data::Interleave::IcecastMetadata;

with 'Teto::Role::Log';

has router => (
    is  => 'rw',
    isa => 'Router::Simple',
    lazy_build => 1,
);

has mt => (
    is  => 'rw',
    isa => 'Text::MicroTemplate::File',
    default => sub {
        Text::MicroTemplate::File->new(include_path => 'root');
    },
);

has controls => (
    is  => 'rw',
    isa => 'HashRef[Teto::Control]', # REMOTE_ADDR => Teto::Control,
    default => sub { +{ } },
);

__PACKAGE__->meta->make_immutable;

no Mouse;

sub _build_router {
    my $self = shift;
    my $router = Router::Simple->new;
    $router->connect('/stream'     => { action => 'stream' });
    $router->connect('/mock'       => { action => 'mock' });
    $router->connect('/api/feeder' => { action => 'api_feeder' });
    $router->connect('/api/track'  => { action => 'api_track' });
    $router->connect('/api/skip'   => { action => 'api_skip' });
    $router->connect('/api/delete_track' => { action => 'api_delete_track' });
    $router->connect('/'           => { action => 'index' });
    return $router;
}

sub build_control_for_remote_addr {
    my ($self, $remote_host) = @_;
    return $self->controls->{$remote_host} ||= Teto::Control->new;
}

sub as_psgi {
    my $self = shift;

    return sub {
        my $env = shift;
        my $p = $self->router->match($env);
        my $action = $p->{action} || 'index';
        return $self->$action($env);
    };
}

sub render_html {
    my ($self, $file, @args) = @_;
    my $html = $self->mt->render_file($file, @args);
    $html = Encode::encode_utf8 $html;
    return [ 200, [ 'Content-Type' => 'text/html; charset=utf-8' ], [ $html ] ];
}

sub index {
    my ($self, $env) = @_;
    my $control = $self->build_control_for_remote_addr($env->{REMOTE_ADDR});
    return $self->render_html('index.mt', control => $control);
}

sub mock {
    my ($self, $env) = @_;
    return $self->render_html('mock.mt');
}

sub stream {
    my ($self, $env) = @_;
    my $req = Plack::Request->new($env);

    my $control = $self->build_control_for_remote_addr($env->{REMOTE_ADDR});
    return sub {
        my $respond = shift;
        unless ($env->{HTTP_ICY_METADATA}) {
            $control->queue->icemeta(undef);
        }

        require Teto::Worker::ReadBuffer;
        my $read_buffer = Teto::Worker::ReadBuffer->spawn(
            queue => $control->queue,
            ( !$env->{HTTP_ICY_METADATA} ? ( icemeta => undef ) : () ),
        );

        my $writer = $respond->([
            200, [
                'Content-Type' => 'audio/mp3',
                $control->queue->icemeta ? ( 'Icy-Metaint'  => $control->queue->icemeta->interval ) : (),
                'Icy-Name'       => 'tetocast',
                'Icy-Url'        => $req->uri,
                'Ice-Audio-Info' => 'ice-samplerate=44100;ice-bitrate=192000;ice-channels=2',
            ]
        ]);

        async {
            $Coro::current->desc('streamer coro');

            if (ref $writer eq 'Twiggy::Writer') {
                $writer->{handle}->on_drain(unblock_sub {
                    $self->log(debug => 'on_drain');
                    my $bytes = $read_buffer->channel->get;
                    $self->log(debug => 'read ' . length($bytes) . ' bytes');
                    $writer->write($bytes);
                });
                $writer->{handle}->on_error(sub {
                    my ($handle, $fatal, $msg) = @_;
                    $self->log($fatal ? 'error' : 'warn', $msg);
                    $writer->close;
                    $control->reset;
                });
            } else {
                # XXX not sure this works
                while (1) {
                    my $bytes = $control->queue->read_buffer;
                    while (length (my $chunk = substr $bytes, 0, 1024, '')) {
                        $writer->write($bytes);
                        cede;
                    }
                }
            }
        };
    };
}

sub api_feeder {
    my ($self, $env) = @_;

    my $control = $self->build_control_for_remote_addr($env->{REMOTE_ADDR});
    my $req = Plack::Request->new($env);
    my $url = $req->param('url') || '';
    my $feeder = Teto->feeders->{$url};
    if ($req->method eq 'POST') {
        $feeder ||= Teto->feed_url($url);
        if ($feeder) {
            $control->set_feeder($feeder);
            $control->update;
        }
    }

    return $self->render_html('_feeder.mt', $feeder || $control->feeder, $control);
}

sub api_track {
    my ($self, $env) = @_;
    my $control = $self->build_control_for_remote_addr($env->{REMOTE_ADDR});
    my $req = Plack::Request->new($env);

    if ($req->method eq 'POST') {
        my $index = $req->param('index');
        my $url = $req->param('feeder');
        if ($url && (my $feeder = Teto->feeders->{$url})) {
            $control->set_feeder($feeder);
        }
        $control->index($index);
        async { $control->update };
    }

    return $self->render_html('_feeder.mt', $control->feeder, $control);
}

sub api_skip {
    my ($self, $env) = @_;
    my $control = $self->build_control_for_remote_addr($env->{REMOTE_ADDR});
    my $req = Plack::Request->new($env);

    if ($req->method eq 'POST') {
        my $url = $req->param('url');
        if ($url && (my $track = Teto::Track->of_url($url))) {
            $track->done;
            $track->buffer_signal->broadcast;
        }
    }

    return $self->render_html('_feeder.mt', $control->feeder, $control);
}

sub api_delete_track {
    my ($self, $env) = @_;
    my $control = $self->build_control_for_remote_addr($env->{REMOTE_ADDR});
    my $req = Plack::Request->new($env);

    if ($req->method eq 'POST') {
        my $i = $req->param('i');
        if ($i > 0) {
            splice @{ $control->queue->queue }, $i, 1;
        }
    }

    return [ 204, [], [] ];
}

1;
