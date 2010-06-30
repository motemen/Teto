use strict;
use warnings;
use Test::More;
use Teto::Server::Queue;

use_ok 'Teto::Feeder';

my $q = Teto::Server::Queue->new;
my $feeder = new_ok 'Teto::Feeder', [ queue => $q ];

if ($ENV{TEST_HTTP}) {
    $feeder->feed('http://b.hatena.ne.jp/motemen/video.rss');
    ok scalar @{$q->queue};

    $q->queue([]);

    $feeder->feed('http://www.nicovideo.jp/tag/サンドキャニオン?sort=v');
    ok scalar @{$q->queue};
    note explain $q->queue;
}

done_testing;
