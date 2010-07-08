#!/usr/bin/env perl
use strict;
use warnings;
use lib 'lib';

use Teto::Server;
use Teto::Logger qw($logger);

my @urls = @ARGV;

$logger->add_logger(screen => { min_level => 'debug' });

my $server = Teto::Server->new;
$server->setup_callbacks;
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
