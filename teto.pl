#!/usr/bin/env perl
use strict;
use warnings;
use Coro::LWP; # load as fast as possible
use Coro::Debug;
use Plack::Runner;

use File::Spec;
use FindBin;
use lib File::Spec->catdir( $FindBin::RealBin, 'lib' );
use Teto;
use Teto::Playlist;
use Teto::Tatsumaki::Application;

my $runner = Plack::Runner->new(server => 'Twiggy', env => 'production');
$runner->parse_options(-port => 1925, @ARGV);

my $app    = Teto::Tatsumaki::Application->new;
my $debug  = Coro::Debug->new_unix_server('teto.debug.sock');

if ({ @{ $runner->{options} } }->{daap}) {
    require Teto::DAAP;
    Teto->context->{daap} = Teto::DAAP->new;
}

Teto::Playlist->feed_async($_) for @{ $runner->{argv} };

$runner->set_options(
    server_ready => sub {
        my $args = shift;
        Teto->server->log(notice => "Streaming at http://$args->{host}:$args->{port}/stream");
        Teto->server->log(debug  => "Connect to debug coro by 'socat readline teto.debug.sock'");
    }
);

$runner->run($app->psgi_app);
