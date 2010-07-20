use strict;
use warnings;
use Test::More;

plan tests => 4;

use_ok 'Teto::Feeder::Twitter';
use_ok 'Teto::Server';

my $twitter = new_ok 'Teto::Feeder::Twitter', [ server => Teto::Server->new ];
isa_ok $twitter->guard, 'Guard';
