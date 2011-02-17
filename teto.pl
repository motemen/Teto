use strict;
use warnings;
use lib 'lib';
use Teto;
use Teto::Role::Log;
use Coro;
use Coro::LWP;
use Coro::Debug;
use Plack::Runner;

my $debug = Coro::Debug->new_unix_server('teto.debug.sock');

async {
    $Coro::current->desc('stdin coro');
    while (1) {
        Coro::AnyEvent::readable *STDIN;
        my $line = <STDIN>;
        next unless defined $line;
        chomp $line;
        Teto->feeder->feed_by_url($line);
    }
};

async {
    $Coro::current->desc('player coro');
    # Coro::Debug::trace;
    Teto->playlist->play_next while 1;
};

my $app = sub {
    my $env = shift;
    return sub {
        my $respond = shift;
        async {
            $Coro::current->desc('streamer coro');
            my $writer = $respond->([ 200, [ 'Content-Type' => 'audio/mp3' ] ]);
            my $bytes_sent = 0;
            $writer->{handle}->on_drain(unblock_sub {
                # Coro::Debug::trace;
                my $bytes = Teto->buffer->read(8 * 1024);
                $writer->write($bytes);
                $bytes_sent += length $bytes;
            });
        };
    };
};

my $runner = Plack::Runner->new(server => 'Twiggy', env => 'production');
$runner->parse_options(@ARGV);
$runner->set_options(
    server_ready => sub {
        my $args = shift;
        Teto::Role::Log->log(notice => "Streaming at http://$args->{host}:$args->{port}/");
        Teto::Role::Log->log(debug  => "Connect to debug coro by 'socat readline teto.debug.sock'");
    }
);

async {
    Teto->feeder->feed_by_url($_) for @{ $runner->{argv} };
};

$runner->run($app);
