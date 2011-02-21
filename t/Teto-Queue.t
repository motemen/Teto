use strict;
use Test::More tests => 3;
use Test::Deep;
use Teto::Track;
use Coro;

use_ok 'Teto::Queue';

subtest basic => sub {
    my $queue = new_ok 'Teto::Queue', [ track_fh => do { my $s = ''; open my $fh, '>', \$s; $fh } ];

    cmp_deeply $queue->queue, [];

    $queue->add_track(Teto::Track->from_url('http://www.nicovideo.jp/watch/sm12441199'));
    cmp_deeply $queue->queue, [ isa('Teto::Track') & methods(video_id => 'sm12441199') ];

    async {
        my $track = $queue->next_track;
        isa_ok $track, 'Teto::Track';
    };
    cede;
};

subtest signal => sub {
    my $queue = Teto::Queue->new(track_fh => do { my $s = ''; open my $fh, '>', \$s; $fh });

    my @coros;
    my ($waiting, $track);
    push @coros, async {
        $waiting++;
        $track = $queue->next_track;
        cmp_deeply $track, isa('Teto::Track') & methods(video_id => 'sm9'), 'got added track';
    };

    cede;

    ok !$track,  'track not got';

    push @coros, async {
        $queue->add_track(Teto::Track->from_url('http://www.nicovideo.jp/watch/sm9'));
    };

    $_->join for @coros;

    done_testing(2);
};
