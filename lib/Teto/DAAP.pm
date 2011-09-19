package Teto::DAAP;
use Mouse;
use Teto::Playlist;
use Teto::Track;
use AnyEvent::DAAP::Server;
use Sys::Hostname;

has daap_server => (
    is  => 'rw',
    isa => 'AnyEvent::DAAP::Server',
    default => sub { AnyEvent::DAAP::Server->new(port => 13689, name => 'teto ' . hostname) },
);

__PACKAGE__->meta->make_immutable;

no Mouse;

### XXX experimental. to enable this, run teto.pl with --enable_daap.
# depends on https://github.com/motemen/AnyEvent-DAAP-Server

# TODO
# - preload tracks
# - update track length

sub BUILD {
    my $self = shift;
    $self->daap_server->setup;

    Teto::Playlist->meta->add_after_method_modifier(
        feed_url => sub {
            my $playlist = shift;
            $self->daap_server->add_track($_->as_daap_track) for $playlist->tracks;
            $self->daap_server->add_playlist($playlist->as_daap_playlist);
            $self->daap_server->database_updated;
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

sub write_data {
    my ($self, $connection, $res, $pos) = @_;

    my $track = $self->track;
    $track->log(debug => 'daap: start streaming');

    async {
        $Coro::current->{desc} = 'daap track play';
        $track->prepare;
        $track->play;
    };

    async {
        $Coro::current->{desc} = 'daap track write';

        until ($track->is_done) {
            $track->buffer_signal->wait;
        }

        my $buf = substr $track->buffer, $pos || 0;
        $res->content_length(length $buf);
        $res->content($buf);
        $self->push_response($connection, $res);
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

    $track->daap_songtime((59 * 60 + 59) * 1000); # 59:59 dummy, to enable seek

    return $track;
}

package Teto::Playlist;
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
