package Teto::Worker::FeedTracksToQueue;
use Mouse;
use MouseX::Types::URI;
use Coro;

with 'Teto::Role::Log';

has playlist => (
    is  => 'rw',
    isa => 'Teto::Playlist',
);

has queue => (
    is  => 'rw',
    isa => 'Teto::Queue',
);

has dismissed => (
    is  => 'rw',
);

__PACKAGE__->meta->make_immutable;

no Mouse;

sub spawn {
    my ($class, %args) = @_;
    my $self = $class->new(%args);
    $self->work_async;
    return $self;
}

sub work_async {
    my $self = shift;

    async {
        $self->work;
    };
}

sub work {
    my $self = shift;

    $self->queue->clear;

    my @tracks = $self->playlist->tracks;
    $self->queue->add_track(@tracks);

    until ($self->dismissed) {
        $self->log(debug => 'wait for playlist signal');
        $self->playlist->track_signal->wait;

        my @new_tracks = do {
            my @tt = $self->playlist->tracks;
            splice @tt, scalar @tracks;
        };
        $self->log(debug => 'playlist signal: got ' . scalar(@new_tracks) . ' new tracks');
        $self->queue->add_track(@new_tracks);

        push @tracks, @new_tracks;
    }
}

sub dismiss {
    my $self = shift;
    $self->{dismissed}++;
    $self->log(debug => 'dismissed');
}

sub DESTROY {
    my $self = shift;

    local $@;
    eval { $self->dismiss };
    warn $@ if $@;
}

1;
