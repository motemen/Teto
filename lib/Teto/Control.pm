package Teto::Control;
use Mouse;
use Coro;
use List::MoreUtils qw(first_value);

with 'Teto::Role::Log';

has queue => (
    is  => 'rw',
    isa => 'Teto::Queue',
    default => sub { require Teto::Queue; Teto::Queue->new },
);

has feeder => (
    is  => 'rw',
    isa => 'Teto::Feeder',
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

__PACKAGE__->meta->make_immutable;

no Mouse;

sub BUILD {
    my $self = shift;
    require Teto;
    my $url = first_value { $_ ne Teto::Context->URL_SCRATCH } keys %{ Teto->feeders };
       $url ||= Teto::Context->URL_SCRATCH;
    if (my $feeder = Teto->feeders->{$url}) {
        $self->set_feeder($feeder);
        async { $self->update };
    }
}

sub play_feeder {
    my ($self, $feeder) = @_;
    $self->set_feeder($feeder);
    $self->update;
}

sub set_feeder {
    my ($self, $feeder) = @_;
    $self->feeder($feeder);
    $self->index(0);
}

sub set_index {
    my ($self, $index) = @_;
    $self->index($index);
}

sub update {
    my $self = shift;
    $self->feed_tracks_to_queue;
}

sub reset {
    my $self = shift;
    $self->queue->icemeta->reset_position if $self->queue->icemeta;
}

sub feed_tracks_to_queue {
    my $self = shift;
    $self->queue->clear_queue;

    my @tracks = $self->feeder->tracks;
    my $num_tracks = @tracks;
    splice @tracks, 0, $self->index;
    $self->queue->add_track(@tracks);
    $self->queue->current_track->play if $self->queue->current_track;
    $_->prepare for $self->queue->succeeding_tracks;
    $self->_feed_tracks_to_queue_after($num_tracks);
}

sub _feed_tracks_to_queue_after {
    my ($self, $n) = @_;
    $self->log(debug => 'wait for feeder signal');
    # signal broadcasts after feeder got new tracks
    $self->feeder->signal->wait(sub {
        my @tracks = $self->feeder->tracks;
        $self->log(debug => "feeder signal: @tracks");
        splice @tracks, 0, $n; # skip n tracks
        $self->log(debug => "-> @tracks");
        $self->queue->add_track(@tracks);
        $self->_feed_tracks_to_queue_after($n + @tracks);
        $self->queue->current_track->play if $self->queue->current_track;
    });
}

1;
