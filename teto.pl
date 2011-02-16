use strict;
use warnings;
use lib 'lib';
use Teto;
use Coro;
use Coro::Debug;
use Twiggy::Server;

our $app = Teto->new;
$app->queue->write_cb(sub { $app->buffer->write($_[0]) });

my $debug = Coro::Debug->new_unix_server('teto.debug.sock');

$app->queue->enqueue_url($_) for @ARGV;

async {
    $Coro::current->desc('stdin coro');
    while (1) {
        Coro::AnyEvent::readable *STDIN;
        my $line = <STDIN>;
        next unless defined $line;
        chomp $line;
        $app->queue->enqueue_url($line);
    }
};

async {
    $Coro::current->desc('player coro');
    $app->queue->play_next while 1;
};

# TODO make configurable
Twiggy::Server->new(port => 9090)->run(sub {
    my $env = shift;
    return sub {
        my $respond = shift;
        async {
            $Coro::current->desc('streamer coro');
            my $writer = $respond->([ 200, [ 'Content-Type' => 'audio/mp3' ] ]);
            $writer->{handle}->on_drain(sub {
                my $bytes = $app->buffer->read(1024);
                $writer->write($bytes);
            });
        };
    };
});
