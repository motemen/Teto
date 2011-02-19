use strict;
use warnings;
use lib 'lib';
use Teto;
use Teto::Role::Log;
use Teto::Server;
use Coro;
use Coro::LWP;
use Coro::Debug;
use Plack::Runner;
use Plack::Builder;
use Plack::App::File;

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

my $debug = Coro::Debug->new_unix_server('teto.debug.sock');

my $runner = Plack::Runner->new(server => 'Twiggy', env => 'production');
$runner->parse_options(@ARGV);
$runner->set_options(
    server_ready => sub {
        my $args = shift;
        Teto::Role::Log->log(notice => "Streaming at http://$args->{host}:$args->{port}/stream");
        Teto::Role::Log->log(debug  => "Connect to debug coro by 'socat readline teto.debug.sock'");
    }
);

async {
    Teto->feeder->feed_by_url($_) for @{ $runner->{argv} };
};


my $url_map = builder {
    mount '/css' => builder {
        enable 'File::Sass', syntax => 'scss';
        Plack::App::File->new(root => './root/css');
    };
    mount '/' => Teto::Server->new->as_psgi;
};

$runner->run($url_map->to_app);
