use strict;
use Test::More tests => 3;
use Test::Deep;
use Teto::Track;
use Coro;

use_ok 'Teto::Playlist';

subtest basic => sub {
    my $playlist = new_ok 'Teto::Playlist', [ track_fh => do { my $s = ''; open my $fh, '>', \$s; $fh } ];

    cmp_deeply $playlist->playlist, [];

    $playlist->add_track(Teto::Track->from_url('http://www.nicovideo.jp/watch/sm12441199'));
    cmp_deeply $playlist->playlist, [ isa('Teto::Track') & methods(video_id => 'sm12441199') ];
    is $playlist->index, -1;

    my $track = $playlist->next_track;
    isa_ok $track, 'Teto::Track';
    is $playlist->index, 0;
};

subtest signal => sub {
    my $playlist = Teto::Playlist->new(track_fh => do { my $s = ''; open my $fh, '>', \$s; $fh });

    my @coros;
    my ($waiting, $track);
    push @coros, async {
        $waiting++;
        $track = $playlist->next_track;
        cmp_deeply $track, isa('Teto::Track') & methods(video_id => 'sm9'), 'got added track';
    };

    cede;

    ok $playlist->waiting_track_signal, 'playing coro awaits';
    ok !$track,  'track not got';

    push @coros, async {
        $playlist->add_track(Teto::Track->from_url('http://www.nicovideo.jp/watch/sm9'));
    };

    $_->join for @coros;

    done_testing(3);
};
