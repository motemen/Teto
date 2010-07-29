#!/usr/bin/env perl
use strict;
use warnings;
use lib 'lib';

use Coro;
use Coro::LWP;

use Teto::Server;
use Teto::Logger qw($logger);

$logger->add_logger(screen => { min_level => 'debug' });

my $server = Teto::Server->new;
$server->setup_callbacks;

my @urls;
my @components;

foreach (@ARGV) {
    if (/^\+(.+)/) {
        my $module = $1;
        eval qq{ require $module } or do {
            $logger->log(warn => $@);
            next;
        };
        push @components, my $c = $module->new(server => $server);
    } else {
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

if (eval { require AnyEvent::Monitor::CPU }) {
    AnyEvent::Monitor::CPU->new(
        cb => sub {
            my $self = shift;
            $logger->log(debug => "high CPU usage");
        }
    );
}

AE::cv->wait;
