use strict;
use warnings;
use lib 'lib';
use Teto;
use Coro;
use Coro::Debug;
use Twiggy::Server;

Teto->playlist->write_cb(sub { Teto->buffer->write($_[0]) });
Teto->playlist->enqueue_url($_) for @ARGV;

my $debug = Coro::Debug->new_unix_server('teto.debug.sock');

async {
    $Coro::current->desc('stdin coro');
    while (1) {
        Coro::AnyEvent::readable *STDIN;
        my $line = <STDIN>;
        next unless defined $line;
        chomp $line;
        Teto->playlist->enqueue_url($line);
    }
};

async {
    $Coro::current->desc('player coro');
    Teto->playlist->play_next while 1;
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
                my $bytes = Teto->buffer->read(1024);
                $writer->write($bytes);
            });
        };
    };
});
