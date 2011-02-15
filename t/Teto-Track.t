use strict;
use Test::More tests => 5;

use_ok 'Teto::Track';

my $track = new_ok 'Teto::Track', [ url => '' ];

my $wrote;
$track->write_cb(sub { $wrote = $_[0] });
$track->write('xxx');
is $wrote, 'xxx';

subtest nicovideo => sub {
    my $track = Teto::Track->from_url('http://www.nicovideo.jp/watch/sm11809611');
    isa_ok $track, 'Teto::Track::NicoVideo';
};

subtest 'none handles' => sub {
    my $track = Teto::Track->from_url('http://www.example.com/');
    ok not $track;
};
