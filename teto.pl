#!/usr/bin/env perl
use strict;
use warnings;
use lib 'lib';

use Coro;
use Coro::LWP;

use Teto::Server;
use Teto::Logger qw($logger);

use Getopt::Long qw(:config pass_through);

$logger->add_logger(screen => { min_level => 'debug' });

my $server = Teto::Server->new_with_options;
$server->setup_callbacks;

my @urls;
my @components;

# TODO server で
foreach (@{$server->extra_argv}) {
    if (/^\+(.+)/) {
        my $module = $1;
        eval qq{ require $module } or do {
            $logger->log(warn => $@);
            next;
        };
        push @components, my $c = $module->new(server => $server);
    } elsif (/^http:/) {
        push @urls, $_;
    }
}

$server->enqueue(@urls) if @urls;

async {
    $server->queue->start;
};

my $w; $w = AE::io *STDIN, 0, sub {
    chomp (my $url = <STDIN>);
    $server->enqueue($url) if $url;
    if (eval { require Module::Refresh }) {
        Module::Refresh->refresh;
    }
};

AE::cv->wait;

__END__

./teto.pl --port=9090 --cache-dir=.cache --readonly
