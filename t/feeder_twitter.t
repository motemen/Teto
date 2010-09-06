use strict;
use warnings;
use Test::More;

use Teto::Server;
use Teto::Server::Queue;

plan tests => 3;

use_ok 'Teto::Feeder::Twitter';

my $server  = Teto::Server->new;
my $twitter = new_ok 'Teto::Feeder::Twitter', [ queue => Teto::Server::Queue->new(server => $server) ];
isa_ok $twitter->guard, 'Guard';
