use strict;
use warnings;
use lib 'lib';
use Teto;
use Coro;
use Coro::Debug;
use Plack::Runner;
use Plack::Builder;
use Plack::App::File;

my $runner = Plack::Runner->new(server => 'Twiggy', env => 'production');
$runner->parse_options(@ARGV);

if ({ @{ $runner->{options} } }->{daap}) {
    require Teto::DAAP;
    Teto::DAAP->import;
} else {
    # load as fast as possible
    require Coro::LWP;
}

async {
    $Coro::current->desc('stdin coro');
    while (1) {
        Coro::AnyEvent::readable *STDIN;
        my $line = <STDIN>;
        next unless defined $line;
        chomp $line;
        next unless $line;
        Teto->feed_url($line);
    }
};

my $app    = Teto->server->as_psgi;
my $debug  = Coro::Debug->new_unix_server('teto.debug.sock');
$runner->set_options(
    server_ready => sub {
        my $args = shift;
        Teto->server->log(notice => "Streaming at http://$args->{host}:$args->{port}/stream");
        Teto->server->log(debug  => "Connect to debug coro by 'socat readline teto.debug.sock'");
    }
);

Teto->feed_url($_) for @{ $runner->{argv} };

my $url_map = builder {
    mount '/css' => builder {
        enable 'File::Sass', syntax => 'scss';
        Plack::App::File->new(root => './root/css');
    };
    mount '/image' => builder {
        Plack::App::File->new(root => './root/image');
    };
    mount '/' => $app;
};

$runner->run($url_map->to_app);
