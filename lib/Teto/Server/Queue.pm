package Teto::Server::Queue;
use Any::Moose;

has 'index', (
    is  => 'rw',
    isa => 'Int',
    default => sub { 0 },
);

has 'queue', (
    is  => 'rw',
    isa => 'ArrayRef',
    default => sub { +[] },
);

has 'server', (
    is  => 'rw',
    isa => 'Teto::Server',
    weak_ref => 1,
);

has 'writer', (
    is  => 'rw',
    isa => 'Teto::Writer',
    lazy_build => 1,
);

has 'guard', (
    is  => 'rw',
    isa => 'Guard',
);

__PACKAGE__->meta->make_immutable;

use AnyEvent;
use Guard ();
use Teto::Writer;
use Teto::Logger qw($logger);

sub push {
    my $self = shift;
    $logger->log(debug => "<< $_") for @_;
    CORE::push @{$self->queue}, @_;
}

sub next {
    my $self = shift;
    if ($self->index >= @{ $self->queue }) {
        return undef;
    }
    my $next = $self->queue->[ $self->index ];
    $self->index($self->index + 1);
    return $next;
}

sub start {
    my $self = shift;

    return if $self->guard;

    my $g = Guard::guard { $logger->log(debug => 'unguarded'); $self->start };
    $self->guard($g);

    my $next = $self->next or do { $g->cancel; $self->unguard; return };
    $logger->log(info => "#$self->{index}: $next");

    my $cv = $self->writer->write($next);
    $cv->cb(sub { $self->unguard });
}

sub start_async {
    my $self = shift;
    my $w; $w = AE::idle sub { $self->start; undef $w };
}

sub unguard {
    my $self = shift;
    undef $self->{guard};
}

sub _build_writer {
    my $self = shift;
    return Teto::Writer->new(server => $self->server);
}

sub DEMOLISH {
    my $self = shift;
    $self->guard->cancel if $self->guard;
}

1;
