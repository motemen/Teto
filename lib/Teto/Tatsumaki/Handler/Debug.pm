package Teto::Tatsumaki::Handler::Debug;
use strict;
use warnings;
use parent 'Teto::Tatsumaki::Handler';
use Coro::State;
use Carp;

sub get {
    my $self = shift;
    my @coros = map {
        +{
            coro => $_,
            backtrace => do {
                my $bt = '';
                $_->call(sub { $bt = Carp::longmess });
                $bt;
            },
        }
    } Coro::State::list;
    $self->render('debug.html', { coros => \@coros });
}

1;
