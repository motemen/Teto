package Teto::Control;
use Mouse;

with 'Teto::Role::Log';

has queue => (
    is  => 'rw',
    isa => 'Teto::Queue',
    default => sub { require Teto; Teto->queue },
);

has buffer => (
    is  => 'rw',
    isa => 'Teto::Buffer',
    default => sub { require Teto; Teto->buffer },
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

sub set_feeder {
    my ($self, $feeder) = @_;
    $self->feeder($feeder);
    $self->index(0);
    $feeder->cv->cb(
        sub {
            $self->queue->clear_queue;
            $self->queue->add_track($_) for @{ $feeder->tracks };
            $self->queue->current_track->play; # XXX
            $_->prepare for $self->queue->succeeding_tracks;
        }
    );
}

1;
