package Teto::DAAP;
use Mouse;
use Teto::Feeder;
use Teto::Track;
use AnyEvent::DAAP::Server;

has daap_server => (
    is  => 'rw',
    isa => 'AnyEvent::DAAP::Server',
    default => sub { AnyEvent::DAAP::Server->new(port => 13689, name => 'teto') },
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
    Teto::Feeder->meta->add_after_method_modifier(feed_url => sub { $self->find_tracks });
}

sub find_tracks {
    my $self = shift;
    # TODO tracks delta
    while (my ($id, $track) = each %$Teto::Track::IdToInstance) {
        $self->daap_server->add_track($track->as_daap_track);
    }
    $self->daap_server->database_updated;
}

package AnyEvent::DAAP::Server::Track::Teto;
use Mouse;
use Coro;

with 'Teto::Role::Log';

extends 'AnyEvent::DAAP::Server::Track';

has track => (
    is  => 'rw',
    isa => 'Teto::Track',
    required => 1,
);

__PACKAGE__->meta->make_immutable;

no Mouse;

use Coro::Debug;

# TODO ugly
sub stream {
    my ($self, $connection) = @_;

    my $track = $self->track;
    $track->log(info => 'daap: start streaming');
    $track->buffer; # prepare
    $connection->handle->push_write(
        join "\r\n", (
            'HTTP/1.1 200 OK',
            'Content-Type: audio/mp3',
            'Connection: close',
            '',
        )
    );
    async {
        $Coro::current->{desc} = 'daap stream play';
        $track->prepare;
        $track->play;
    };
    async {
        $Coro::current->{desc} = 'daap stream write';
        open my $fh, '<', $track->buffer_ref or die $!;
        while (1) {
            read $fh, my $buf, 1024;
            if (length $buf == 0) {
                last if $track->is_done;
                $track->buffer_signal->wait;
            } else {
                $connection->handle->push_write($buf);
            }
            cede;
        }
        close $fh;
        $connection->handle->push_shutdown;
    };
}

package Teto::Track;

sub dmap_track_id {
    my $self = shift;
    return $self->track_id & 0xFFFFFF;
}

sub as_daap_track {
    my $self = shift;
    my $track = AnyEvent::DAAP::Server::Track::Teto->new(track => $self);

    $track->dmap_itemid($self->dmap_track_id);
    $track->dmap_containeritemid($self->track_id);

    $track->dmap_itemkind(2);
    $track->dmap_persistentid($self->track_id);

    $track->daap_songbitrate(192000);
    $track->daap_songsamplerate(44100 * 1000);
    $track->daap_songtime(180);

    $track->dmap_itemname($self->title || $self->track_id);

    $track->daap_songdateadded(time());
    $track->daap_songdatemodified(time());
    $track->daap_songformat('mp3');
    $track->daap_songsize($self->peek_buffer_length);

    return $track;
}

1;
