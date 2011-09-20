package Teto::Coro::MarkedChannel;
use strict;
use warnings;
use Mouse;
use Coro::Semaphore;

has size => ( is => 'rw', isa => 'Int', default => sub { 1 } );
has data => ( is => 'rw', isa => 'ArrayRef', default => sub { [] } );

has read_sem => ( is => 'rw', default => sub { Coro::Semaphore->new(0) } );
has mark_sem => ( is => 'rw', default => sub { Coro::Semaphore->new($_[0]->size) } );

no Mouse;

__PACKAGE__->meta->make_immutable;

use constant MARK => \0;

sub put {
    my ($self, $data) = @_;
    push @{ $self->data }, $data;
    $self->read_sem->up;
}

sub put_mark {
    my $self = shift;
    $self->put(MARK);
    $self->mark_sem->down;
}

sub get {
    my $self = shift;

    $self->read_sem->down;

    my $data = shift @{ $self->data };
    if (ref $data && $data == MARK) {
        $self->mark_sem->up;
        return $self->get;
    }

    return $data;
}

1;
