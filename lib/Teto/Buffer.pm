package Teto::Buffer;
use Mouse;
use Coro::Signal;

has buffer => (
    is  => 'rw',
    isa => 'Str',
    default => '',
    traits  => [ 'String' ],
    handles => {
        append_buffer => 'append',
        buffer_length => 'length',
    },
);

has full_signal => (
    is  => 'rw',
    isa => 'Coro::Signal',
    default => sub { Coro::Signal->new },
);

has low_signal => (
    is  => 'rw',
    isa => 'Coro::Signal',
    default => sub { Coro::Signal->new },
);

has max_buffer_size => (
    is  => 'rw',
    isa => 'Int',
    default => 16 * 1024 * 1024,
);

has min_buffer_size => (
    is  => 'rw',
    isa => 'Int',
    default => 8 * 1024,
);

__PACKAGE__->meta->make_immutable;

no Mouse;

sub write {
    my ($self, $data) = @_;
    $self->full_signal->wait if $self->buffer_length > $self->max_buffer_size;
    $self->append_buffer($data);
    $self->low_signal->broadcast if $self->buffer_length > $self->min_buffer_size;
}

sub read {
    my ($self, $length) = @_;
    $self->low_signal->wait if $self->buffer_length < $self->min_buffer_size;
    my $data = substr($self->{buffer}, 0, $length, '');
    $self->full_signal->broadcast if $self->buffer_length <= $self->max_buffer_size;
    return $data;
}

1;
