package Teto::Buffer;
use Mouse;
use Coro::Semaphore;
use Carp;

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

has write_semaphore => (
    is  => 'rw',
    isa => 'Coro::Semaphore',
    default => sub { Coro::Semaphore->new },
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
    $self->write_semaphore->down if $self->buffer_length + length $data > $self->max_buffer_size;
    $self->append_buffer($data);
}

sub read {
    my ($self, $length) = @_;
    my $data = substr($self->{buffer}, 0, $length, '');
    $self->write_semaphore->up if $self->buffer_length <= $self->max_buffer_size && $self->write_semaphore->count <= 0;
    return $data;
}

1;
