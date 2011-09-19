package Teto::Control;
use Mouse;
use Teto::Queue;
use Teto::Playlist;
use Teto::Worker::FeedTracksToQueue;

with 'Teto::Role::Log';

has queue => (
    is  => 'rw',
    isa => 'Teto::Queue',
    default => sub { Teto::Queue->new },
);

has playlist => (
    is  => 'rw',
    isa => 'Teto::Playlist',
);

__PACKAGE__->meta->make_immutable;

no Mouse;

sub BUILD {
    my $self = shift;

    my $playlist = (values %{ Teto::Playlist->all })[-1];
    $self->set_playlist($playlist);
}

sub set_playlist {
    my ($self, $playlist) = @_;
    $self->playlist($playlist);

    $self->{worker}->dismiss if $self->{worker};
    $self->{worker} = Teto::Worker::FeedTracksToQueue->spawn(
        playlist => $self->playlist,
        queue    => $self->queue,
    );
}

1;
