package Teto::Tatsumaki::Handler::Index;
use strict;
use warnings;
use parent 'Teto::Tatsumaki::Handler';

sub get {
    my $self = shift;
    my $control = $self->build_control;
    $self->render('index.html', { control => $control });
}

1;
