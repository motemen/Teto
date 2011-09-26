package Teto::Tatsumaki::Handler;
use strict;
use warnings;
use parent 'Tatsumaki::Handler';
use Teto::Control;

sub controls {
    return our $Controls ||= {};
}

sub build_control {
    my $self = shift;
    return $self->controls->{ $self->request->address } ||= Teto::Control->new;
}

1;
