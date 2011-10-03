use strict;
use lib 'lib';
use Test::More;

use_ok 'Data::Interleave::IcecastMetadata';

my $i = new_ok 'Data::Interleave::IcecastMetadata', [ interval => 16 ];
is $i->pos, 16, '$i->pos';

$i->metadata->{title} = 'foobar';

is $i->interleave('x' x 20), ('x' x 16) . "\x02" . q(StreamTitle='foobar';) . ("\0" x 11) . ('x' x 4), 'interleave';
is $i->interleave('x' x 20), ('x' x 12) . "\x02" . q(StreamTitle='foobar';) . ("\0" x 11) . ('x' x 8), 'interleave';

done_testing;
