package Teto::Server;
use Mouse;
use Coro;
use Router::Simple;
use Text::MicroTemplate::File;
use Teto;

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
    $router->connect('/stream' => { action => 'stream' });
    $router->connect('/'       => { action => 'index' });
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
    return [ 200, [ 'Content-Type' => 'text/html' ], [ $html ] ];
}

sub index {
    my ($self, $env) = @_;
    return $self->render_html('index.mt');
}

sub stream {
    my ($self, $env) = @_;

    return sub {
        my $respond = shift;
        async {
            $Coro::current->desc('streamer coro');
            my $writer = $respond->([ 200, [ 'Content-Type' => 'audio/mp3' ] ]);
            my $bytes_sent = 0;
            $writer->{handle}->on_drain(unblock_sub {
                my $bytes = Teto->buffer->read(8 * 1024);
                $writer->write($bytes);
                $bytes_sent += length $bytes;
            });
        };
    };
}

1;
