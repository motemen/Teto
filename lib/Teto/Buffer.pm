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

has write_signal => (
    is  => 'rw',
    isa => 'Coro::Signal',
    default => sub { Coro::Signal->new },
);

has max_buffer_size => (
    is  => 'rw',
    isa => 'Int',
    default => sub { 16 * 1024 * 1024 },
);

__PACKAGE__->meta->make_immutable;

no Mouse;

sub write {
    my ($self, $data) = @_;
    $self->write_signal->wait if $self->buffer_length + length $data > $self->max_buffer_size;
    $self->append_buffer($data);
}

sub read {
    my ($self, $length) = @_;
    my $data = substr($self->{buffer}, 0, $length, '');
    $self->write_signal->broadcast if $self->buffer_length <= $self->max_buffer_size;
    return $data;
}

1;
