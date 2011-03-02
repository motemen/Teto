package Teto::DAAP;
use strict;
use warnings;
use parent 'Net::DAAP::Server';
use Coro;
use Net::DAAP::Server::Track;
use AnyEvent::Impl::POE;
use AnyEvent::HTTP::LWP::UserAgent;

### XXX experimental. to enable this, run teto.pl with --enable_daap.
# not in Makefile.PL:
# - Net::DAAP::Server
# - AnyEvent::Impl::POE
# - AnyEvent::HTTP::LWP::UserAgent

# TODO - preload tracks
# TODO - AnyEvent::DAAP::Server ??

die if defined $AnyEvent::MODEL && $AnyEvent::MODEL eq 'POE';

sub import {
    our $Instance = __PACKAGE__->new;

#   our $LWP_UserAgent_new = \&LWP::UserAgent::new;
#   *LWP::UserAgent::new = sub {
#       my $ua = &$LWP_UserAgent_new(@_);
#       return bless $ua, 'AnyEvent::HTTP::LWP::UserAgent';
#   };

    @WWW::Mechanize::ISA = AnyEvent::HTTP::LWP::UserAgent::;

    require Teto::Feeder;
    Teto::Feeder->meta->add_after_method_modifier(
        feed_url => sub { $Instance->find_tracks }
    );

    async { POE::Kernel->run };
}

sub default_port { 13689 }

sub find_tracks {
    my $self = shift;
    while (my ($id, $track) = each %$Teto::Track::IdToInstance) {
        $self->tracks->{$track->dmap_track_id} = $track->as_net_daap_server_track;
    }
}

package Teto::DAAP::Track;
use parent 'Net::DAAP::Server::Track';
use Net::DAAP::DMAP qw(dmap_to_hash_ref dmap_pack);

sub data {
    my $self = shift;
    my $track = $self->{track};
    $track->play;
    return $track->buffer;
}

sub Teto::Track::dmap_track_id {
    my $self = shift;
    return $self->track_id & 0xFFFFFF;
}

sub Teto::Track::as_net_daap_server_track {
    my $self = shift;
    my $track = Teto::DAAP::Track->new({ track => $self });

    $track->dmap_itemid($self->dmap_track_id);
    $track->dmap_containeritemid($self->track_id);

    $track->dmap_itemkind(2);
    $track->dmap_persistentid($self->track_id);
    $track->daap_songbeatsperminute(0);

    $track->daap_songbitrate(192000);
    $track->daap_songsamplerate(44100 * 1000);
    $track->daap_songtime(180);

    $track->dmap_itemname($self->title || $self->track_id);
    # $track->daap_songtrackcount( $count || 0);
    # $track->daap_songtracknumber( $number || 0 );

    $track->daap_songcompilation(0);
    $track->daap_songdateadded(time());
    $track->daap_songdatemodified(time());
    $track->daap_songdisccount(0);
    $track->daap_songdiscnumber(0);
    $track->daap_songdisabled(0);
    $track->daap_songeqpreset('');
    $track->daap_songformat('mp3');
    $track->daap_songgenre('');
    $track->daap_songgrouping('');
    $track->daap_songsize($self->peek_buffer_length);
    $track->daap_songstarttime(0);
    $track->daap_songstoptime(0);

    $track->daap_songuserrating(0);
    $track->daap_songdatakind(0);
    $track->com_apple_itunes_norm_volume(17502);

    return $track;
}

1;
