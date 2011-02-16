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

# XXX ?
has write_cb => (
    is  => 'rw',
    isa => 'CodeRef',
);

__PACKAGE__->meta->make_immutable;

no Mouse;

sub add_url {
    my ($self, $url) = @_;
    my $track = Teto::Track->from_url($url) or return undef;
    $self->log(info => "playlist: $url");
    $track->write_cb($self->write_cb) if $self->write_cb; # XXX
    $self->push_playlist($track);
    $self->waiting_track_signal->broadcast;
    return $track;
}

sub next_track {
    my $self = shift;
    $self->increment_index;
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
    my $track = $self->next_track;
    $self->log(info => "play: $track->{url}");
    $track->play;
}

1;
