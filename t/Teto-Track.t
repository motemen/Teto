use strict;
use Test::More tests => 10;
use Test::Deep;

use_ok 'Teto::Track';

my $track = new_ok 'Teto::Track', [ url => '' ];

cmp_set [ Teto::Track->subclasses ], [
    qw(Teto::Track::NicoVideo::sm Teto::Track::NicoVideo::nm Teto::Track::YouTube Teto::Track::SoundCloud Teto::Track::System)
], 'subclasses';

subtest nicovideo_sm => sub {
    my $track = Teto::Track->from_url('http://www.nicovideo.jp/watch/sm11809611');
    isa_ok $track, 'Teto::Track::NicoVideo::sm';
};

subtest nicovideo_nm => sub {
    my $track = Teto::Track->from_url('http://www.nicovideo.jp/watch/nm3254039');
    isa_ok $track, 'Teto::Track::NicoVideo::nm';
};

subtest soundcloud => sub {
    my $track = Teto::Track->from_url('http://soundcloud.com/takuma-hosokawa/darksidenadeko-electro-mix');
    isa_ok $track, 'Teto::Track::SoundCloud';
};

subtest 'none handles' => sub {
    my $track = Teto::Track->from_url('http://www.example.com/');
    ok not $track;
};

subtest play => sub {
    my $track = new_ok 't::Track', [ url => '' ];
    $track->play;
    $track->play;
    is $track->{play_count}, 1;
};

subtest track_id => sub {
    my $track = new_ok 't::Track', [ url => '' ];
    ok $track->track_id;
    is $track, Teto::Track->of_track_id($track->track_id);
};

subtest buffer_gc => sub {
    $Teto::Track::BufferCache = Cache::LRU->new(size => 2);
    my @tracks;
    for (0 .. 9) {
        my $track = Teto::Track->new(url => '');
        $track->append_buffer("track $_");
        is $track->buffer, "track $_";
        push @tracks, $track;
    }
    foreach (0 .. 7) {
        ok !$tracks[$_]->has_buffer;
        # is $tracks[$_]->buffer, '' # XXX calling $track->buffer confuses underlying LRU cache
    }
    foreach (8 .. 9) {
        ok $tracks[$_]->has_buffer;
        # is $tracks[$_]->buffer, "track $_";
    }
};

BEGIN {
    package t::Track;
    use Mouse;

    extends 'Teto::Track';

    override _play => sub {
        my $self = shift;
        $self->{play_count}++;
    };
}
