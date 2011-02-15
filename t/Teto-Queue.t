use strict;
use Test::More tests => 3;
use Test::Deep;
use Coro;

use_ok 'Teto::Queue';

subtest basic => sub {
    my $queue = new_ok 'Teto::Queue';

    cmp_deeply $queue->queue, [];

    $queue->enqueue_url('http://www.nicovideo.jp/watch/sm12441199');
    cmp_deeply $queue->queue, [ isa('Teto::Track') & methods(video_id => 'sm12441199') ];

    is $queue->queue_semaphore->count, 1, 'queue_semaphore->count';
    my $track = $queue->dequeue_track;
    isa_ok $track, 'Teto::Track';
    cmp_deeply $queue->queue, [];
};

subtest semaphore => sub {
    my $queue = Teto::Queue->new;

    my @coros;
    my ($waiting, $track);
    push @coros, async {
        $waiting++;
        $track = $queue->dequeue_track;
        cmp_deeply $track, isa('Teto::Track') & methods(video_id => 'sm9'), 'got queued track';
    };

    cede;

    ok $waiting, 'dequeuing coro awaits';
    ok !$track,  'track not got';

    push @coros, async {
        $queue->enqueue_url('http://www.nicovideo.jp/watch/sm9');
    };

    $_->join for @coros;

    done_testing(3);
};
