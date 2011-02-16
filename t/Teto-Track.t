use strict;
use Test::More tests => 6;
use Test::Deep;

use_ok 'Teto::Track';

my $track = new_ok 'Teto::Track', [ url => '' ];

my $wrote;
$track->write_cb(sub { $wrote = $_[0] });
$track->write('xxx');
is $wrote, 'xxx';

cmp_set [ Teto::Track->subclasses ], [
    qw(Teto::Track::NicoVideo Teto::Track::NicoVideo::nm Teto::Track::YouTube)
], 'subclasses';

subtest nicovideo => sub {
    my $track = Teto::Track->from_url('http://www.nicovideo.jp/watch/sm11809611');
    isa_ok $track, 'Teto::Track::NicoVideo';
};

subtest 'none handles' => sub {
    my $track = Teto::Track->from_url('http://www.example.com/');
    ok not $track;
};
