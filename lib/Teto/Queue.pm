package Teto::Queue;
use Mouse;

# isa
# - queue of tracks

with 'Teto::Role::Log';

has tracks => (
    is  => 'rw',
    isa => 'ArrayRef[Teto::Track]',
    default => sub { [] },
    traits  => [ 'Array' ],
    handles => {
        enqueue => 'push',
        dequeue => 'shift',
        clear   => 'clear',
    },
);

has track_signal => (
    is  => 'rw',
    isa => 'Coro::Signal',
    default => sub { Coro::Signal->new },
);

__PACKAGE__->meta->make_immutable;

no Mouse;

sub add_track {
    my ($self, @tracks) = @_;
    foreach my $track (@tracks) {
        $self->log(info => "track added: $track");
        $self->enqueue($track);
    }
    $self->track_signal->broadcast;
}

sub current_track {
    my $self = shift;
    return $self->tracks->[0];
}

sub succeeding_tracks {
    my $self = shift;
    my $n    = shift || 2;
    return grep { $_ } map { $self->tracks->[$_] } (1 .. $n);
}

sub wait_for_track {
    my $self = shift;
    
    until ($self->current_track) {
        $self->log(debug => 'wait for queue->track_signal');
        $self->track_signal->wait;
        $self->log(debug => 'back from queue->track_signal');
    }

    return $self->current_track;
}

1;
