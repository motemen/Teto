package Teto::Server;
use Mouse;
use Coro;
use Router::Simple;
use Text::MicroTemplate::File;
use Encode;
use Teto;
use Plack::Request;

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
        async {
            $Coro::current->desc('streamer coro');
            my $writer = $respond->([ 200, [ 'Content-Type' => 'audio/mp3' ] ]);
            $writer->{handle}->on_drain(unblock_sub {
                $self->log(debug => 'on_drain');
                Coro::Debug::trace();
                my $bytes = Teto->queue->read_buffer;
                $writer->write($bytes);
                $self->log(debug => 'sent', length $bytes, 'bytes');
            });
            $writer->{handle}->on_error(sub {
                my ($handle, $fatal, $msg) = @_;
                $self->log($fatal ? 'error' : 'warn', $msg);
                $writer->close;
            });
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

1;
