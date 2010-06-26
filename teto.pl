#!/usr/bin/env perl
use strict;
use warnings;
use lib 'lib';

use Teto::Server;

my @urls = @ARGV;

my $server = Teto::Server->new;
$server->queue->push(@urls) if @urls;
$server->queue->start_async;

my $w; $w = AE::io *STDIN, 0, sub {
    chomp (my $url = <STDIN>);
    $server->queue->push($url);
};

AE::cv->wait;
