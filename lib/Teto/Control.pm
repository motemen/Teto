package Teto::Control;
use Mouse;
use Teto::Worker::FeedTracksToQueue;

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

__PACKAGE__->meta->make_immutable;

no Mouse;

sub BUILD {
    my $self = shift;

    require Teto::Feeder;
    my $feeder = (values %{ Teto::Feeder->all })[-1];
    $self->set_feeder($feeder);
}

sub set_feeder {
    my ($self, $feeder) = @_;
    $self->feeder($feeder);

    $self->{worker}->dismiss if $self->{worker};
    $self->{worker} = Teto::Worker::FeedTracksToQueue->spawn(
        playlist => $self->feeder,
        queue    => $self->queue,
    );
}

1;
