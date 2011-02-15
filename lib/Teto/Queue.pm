package Teto::Queue;
use Mouse;
use Coro;
use Coro::Semaphore;
use Teto::Track;

has queue => (
    is  => 'rw',
    isa => 'ArrayRef[Teto::Track]',
    default => sub { [] },
    traits  => [ 'Array' ],
    handles => {
        push_queue  => 'push',
        shift_queue => 'shift',
    },
);

has queue_semaphore => (
    is  => 'rw',
    isa => 'Coro::Semaphore',
    default => sub { Coro::Semaphore->new(0) },
);

__PACKAGE__->meta->make_immutable;

no Mouse;

sub enqueue_url {
    my ($self, $url) = @_;
    my $track = Teto::Track->from_url($url) or return undef;
    $self->push_queue($track);
    $self->queue_semaphore->up;
    return $track;
}

sub dequeue_track {
    my $self = shift;
    $self->queue_semaphore->down;
    return $self->shift_queue;
}

sub play_next {
    my $self = shift;
    my $track = $self->dequeue_track;
    $track->play;
}

1;
