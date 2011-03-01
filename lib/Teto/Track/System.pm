package Teto::Track::System;
use Mouse;
use Try::Tiny;
use Scalar::Util qw(refaddr);

extends 'Teto::Track';

has code => (
    is  => 'rw',
    isa => 'CodeRef',
    required => 1,
);

has '+url' => (
    default => sub { 'teto://system/' . refaddr $_[0] },
);

override buildargs_from_url => sub {
};

override _play => sub {
    my $self = shift;

    try {
        $self->code->();
    } catch {
        $self->add_error($_);
    };

    $self->done;
    $self->buffer_signal->broadcast;
};

__PACKAGE__->meta->make_immutable;

no Mouse;

sub is_system { 1 }

1;
