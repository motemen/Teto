package Teto::Playlist;
use Mouse;
use Coro::Signal;
use Teto::Track;

with 'Teto::Role::Log';

has playlist => (
    is  => 'rw',
    isa => 'ArrayRef[Teto::Track]',
    default => sub { [] },
    traits  => [ 'Array' ],
    handles => {
        push_playlist => 'push',
    },
);

has index => (
    is  => 'rw',
    isa => 'Int',
    default => -1,
    traits  => [ 'Number' ],
    handles => {
        add_index => 'add',
        increment_index => [ 'add', 1 ],
    },
);

has waiting_track_signal => (
    is  => 'rw',
    isa => 'Coro::Signal',
    default => sub { Coro::Signal->new },
);

has buffer => (
    is  => 'rw',
    isa => 'Teto::Buffer',
    default => sub { require Teto; Teto->buffer },
);

__PACKAGE__->meta->make_immutable;

no Mouse;

sub add_track {
    my ($self, $track) = @_;
    $self->log(info => "track added: $track");
    $self->push_playlist($track);
    $self->waiting_track_signal->broadcast;
    return $track;
}

sub next_track {
    my $self = shift;
    $self->increment_index;
    $self->log(info => 'track#', $self->index - 1, '->', $self->index);
    until ($self->current_track) {
        $self->waiting_track_signal->wait;
    }
    return $self->current_track;
}

sub current_track {
    my $self = shift;
    return $self->playlist->[ $self->index ];
}

sub play_next {
    my $self = shift;
    $self->buffer->wait_until_writable;
    my $track = $self->next_track;
    $track->prepare;
    $self->log(notice => "play: $track");
    $track->play;
}

1;
