use strict;
use Test::More;

use_ok 'Teto::Feeder';

my $feeder = new_ok 'Teto::Feeder';

if ($ENV{TEST_LIVE}) {
    $feeder->feed_by_url('http://soundcloud.com/kkshow');
}

done_testing;
