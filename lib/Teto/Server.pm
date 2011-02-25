package Teto::Server;
use Mouse;
use Coro;
use Router::Simple;
use Text::MicroTemplate::File;
use Encode;
use Teto;
use Plack::Request;
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

sub _build_router {
    my $self = shift;
    my $router = Router::Simple->new;
    $router->connect('/stream'     => { action => 'stream' });
    $router->connect('/mock'       => { action => 'mock' });
    $router->connect('/api/feeder' => { action => 'api_feeder' });
    $router->connect('/api/track'  => { action => 'api_track' });
    $router->connect('/api/skip'   => { action => 'api_skip' });
    $router->connect('/'           => { action => 'index' });
    return $router;
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
    return $self->render_html('index.mt');
}

sub mock {
    my ($self, $env) = @_;
    return $self->render_html('mock.mt');
}

sub stream {
    my ($self, $env) = @_;

    return sub {
        my $respond = shift;
        my $icemeta = $env->{HTTP_ICY_METADATA} ? Data::Interleave::IcecastMetadata->new : undef;
        async {
            $Coro::current->desc('streamer coro');
            my $writer = $respond->([
                200, [
                    'Content-Type' => 'audio/mp3',
                    $icemeta ? ( 'Icy-Metaint'  => $icemeta->interval ) : (),
                    'Icy-Name'       => 'tetocast',
                    'Icy-Url'        => $env->{REQUEST_URI},
                    'Ice-Audio-Info' => 'ice-samplerate=44100;ice-bitrate=192000;ice-channels=2',
                ]
            ]);
            if (ref $writer eq 'Twiggy::Writer') {
                $writer->{handle}->on_drain(unblock_sub {
                    $self->log(debug => 'on_drain');
                    Coro::Debug::trace();
                    my $bytes = Teto->queue->read_buffer;
                    if ($icemeta) {
                        $icemeta->metadata->{title} = Teto->queue->current_track->title;
                        $bytes = $icemeta->interleave($bytes); # FIXME bytes and track may differ
                    }
                    $writer->write($bytes);
                    $self->log(debug => 'sent', length $bytes, 'bytes');
                });
                $writer->{handle}->on_error(sub {
                    my ($handle, $fatal, $msg) = @_;
                    $self->log($fatal ? 'error' : 'warn', $msg);
                    $writer->close;
                });
            } else {
                # XXX not sure this works
                while (1) {
                    my $bytes = Teto->queue->read_buffer;
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
    my $req = Plack::Request->new($env);

    my $url = $req->param('url') || '';
    my $feeder = Teto->feeders->{$url};
    if ($req->method eq 'POST') {
        if ($feeder) {
            Teto->control->set_feeder($feeder);
            Teto->control->update;
        }
    }

    return $self->render_html('_feeder.mt', $feeder || Teto->control->feeder);
}

sub api_track {
    my ($self, $env) = @_;
    my $req = Plack::Request->new($env);

    if ($req->method eq 'POST') {
        my $index = $req->param('index');
        my $url = $req->param('feeder');
        if ($url && (my $feeder = Teto->feeders->{$url})) {
            Teto->control->set_feeder($feeder);
        }
        Teto->control->index($index);
        async { Teto->control->update };
    }

    return $self->render_html('_feeder.mt', Teto->control->feeder);
}

sub api_skip {
    my ($self, $env) = @_;
    my $req = Plack::Request->new($env);

    if ($req->method eq 'POST') {
        my $url = $req->param('url');
        if ($url && (my $track = Teto::Track->of_url($url))) {
            $track->done;
            $track->buffer_signal->broadcast;
        }
    }

    return $self->render_html('_feeder.mt', Teto->control->feeder);
}

1;
