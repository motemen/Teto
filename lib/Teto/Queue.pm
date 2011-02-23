package Teto::Queue;
use Mouse;
use Coro;
use Coro::Signal;
use Teto::Track;

# isa
# - queue of tracks
# does
# - supply track byte sequence

with 'Teto::Role::Log';

has queue => (
    is  => 'rw',
    isa => 'ArrayRef[Teto::Track]',
    default => sub { [] },
    traits  => [ 'Array' ],
    handles => {
        enqueue_track => 'push',
        dequeue_track => 'shift',
        queue_size    => 'count',
        clear_queue   => 'clear',
    },
);

has buffer => (
    is  => 'rw',
    isa => 'Teto::Buffer',
    default => sub { require Teto; Teto->buffer },
);

has fh => (
    is  => 'rw',
    isa => 'FileHandle',
    lazy_build => 1,
);

has track_signal => (
    is  => 'rw',
    isa => 'Coro::Signal',
    default => sub { Coro::Signal->new },
);

__PACKAGE__->meta->make_immutable;

no Mouse;

sub add_track {
    my ($self, $track) = @_;
    $self->log(info => "track added: $track");
    $self->enqueue_track($track);
    $self->track_signal->broadcast;
    return $track;
}

# blocks
sub next_track {
    my $self = shift;
    $self->log(debug => 'next_track');
    $self->dequeue_track;

    my $track = $self->wait_current_track;
    $track->prepare;
    $self->log(info => "next track: $track");
    return $track;
}

sub current_track {
    my $self = shift;
    return $self->queue->[0];
}

sub wait_current_track {
    my $self = shift;
    until ($self->current_track) {
        $self->track_signal->wait;
    }
    return $self->current_track;
}

sub succeeding_tracks {
    my $self = shift;
    my $n = shift || 2;
    return grep { $_ } map { $self->queue->[$_] } (1 .. $n);
}

sub read_buffer {
    my $self = shift;

    my $track = $self->wait_current_track;

    unless ($self->has_fh) {
        $self->open_fh or do {
            $self->next_track;
            return $self->read_buffer;
        }
    }

    my $bytes_to_read = length($track->buffer) - tell($self->fh);

    read $self->fh, my ($buf), $bytes_to_read;

    if ($track->is_done) {
        $self->close_fh;
        $self->dequeue_track; # $self->next_track;
        return $buf || $self->read_buffer;
    }

    if (length $buf == 0 || $bytes_to_read == 0) {
        $track->buffer_signal->wait;
        return $self->read_buffer;
    }

    return $buf;
}

sub open_fh {
    my $self = shift;
    my $track = $self->wait_current_track;
    $track->play or do {
        $self->log(warn => "playing $track failed");
        $self->next_track;
        return $self->open_fh;
    };
    # preload
    async {
        $_->play for $self->succeeding_tracks;
    };
    open $self->{fh}, '<', $track->buffer_ref or do {
        $self->log(error => $!);
        return undef;
    };
}

sub close_fh {
    my $self = shift;
    close $self->fh or $self->log(warn => $!);
    $self->clear_fh;
}

1;
