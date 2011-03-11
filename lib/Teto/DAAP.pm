package Teto::DAAP;
use Mouse;
use Teto::Feeder;
use Teto::Track;
use Sys::Hostname;
use AnyEvent::DAAP::Server;

has daap_server => (
    is  => 'rw',
    isa => 'AnyEvent::DAAP::Server',
    default => sub { AnyEvent::DAAP::Server->new(port => 13689, name => 'teto ' . hostname) },
);

__PACKAGE__->meta->make_immutable;

no Mouse;

### XXX experimental. to enable this, run teto.pl with --enable_daap.
# https://github.com/motemen/AnyEvent-DAAP-Server

# TODO
# - preload tracks
# - update track length
# - show feeders as playlists

sub BUILD {
    my $self = shift;
    $self->daap_server->setup;

    Teto::Feeder->meta->add_after_method_modifier(
        feed_url => sub {
            my $feeder = shift;
            $self->daap_server->add_track($_->as_daap_track) for $feeder->tracks;
            $self->daap_server->add_playlist($feeder->as_daap_playlist);
        }
    );
}

package AnyEvent::DAAP::Server::Track::Teto;
use Mouse;
use Coro;

extends 'AnyEvent::DAAP::Server::Track';

has track => (
    is  => 'rw',
    isa => 'Teto::Track',
    required => 1,
);

__PACKAGE__->meta->make_immutable;

no Mouse;

sub allow_range { 1 }

sub data {
    my ($self, $start) = @_;

    my $track = $self->track;
    $track->log(info => 'daap: start streaming');

    return sub {
        my $cb = shift;

        async {
            $Coro::current->{desc} = 'daap stream play';
            $track->prepare;
            $track->play;

            until ($track->is_done) {
                $track->buffer_signal->wait;
            }

            open my $fh, '<', $track->buffer_ref or die $!; # FIXME
            my $buf = substr $track->buffer, $start || 0;
            $cb->($buf);
            close $fh;
        };
    };
}

package Teto::Track;

sub dmap_track_id {
    my $self = shift;
    return $self->track_id & 0xFFFFFF; # XXX this field is 3 byte long
}

sub as_daap_track {
    my $self = shift;
    my $track = AnyEvent::DAAP::Server::Track::Teto->new(track => $self);

    $track->dmap_itemid($self->dmap_track_id);
    $track->dmap_containeritemid($self->track_id);

    $track->dmap_itemkind(2);
    $track->dmap_persistentid($self->track_id);

    $track->daap_songbitrate(192 * 1000);
    $track->daap_songsamplerate(44100 * 1000);

    $track->dmap_itemname($self->title || $self->track_id);

    $track->daap_songdateadded(time());
    $track->daap_songdatemodified(time());
    $track->daap_songformat('mp3');
    $track->daap_songsize($self->peek_buffer_length || (59 * 60 + 59) * 192 / 8);

    $track->daap_songtime((59 * 60 + 59) * 1000); # 59:99 dummy, to enable seek

    return $track;
}

package Teto::Feeder;
use AnyEvent::DAAP::Server::Playlist;

sub dmap_playlist_id {
    my $self = shift;
    return 0+$self & 0xFFFFFF;
}

sub as_daap_playlist {
    my $self = shift;
    my $playlist = AnyEvent::DAAP::Server::Playlist->new;
    $playlist->dmap_itemname($self->title);
    $playlist->dmap_itemid($self->dmap_playlist_id);
    $playlist->tracks([ map { $_->as_daap_track } $self->tracks ]);
    return $playlist;
}

1;
