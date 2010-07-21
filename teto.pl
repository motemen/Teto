#!/usr/bin/env perl
use strict;
use warnings;
use lib 'lib';

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
        push @components, $module->new(server => $server);
    } else {
        push @urls, $_;
    }
}

$server->enqueue(@urls) if @urls;
$server->queue->start_async;

my $w; $w = AE::io *STDIN, 0, sub {
    chomp (my $url = <STDIN>);
    $server->enqueue($url) if $url;
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
