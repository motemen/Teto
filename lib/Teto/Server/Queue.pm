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
    $self->{index}++;

    if (ref $next eq 'CODE') {
        my @res = $next->();
        splice @{$self->queue}, $self->index, 0, @res;
        return $self->next;
    }

    return $next;
}

sub remove {
    my ($self, $i) = @_;
    if ($self->index < $i) {
        $self->{index}--;
    }
    splice @{ $self->queue }, $i, 1;
}

sub start {
    my $self = shift;

    return if $self->guard;

    my $g = Guard::guard {
        return unless $self->server;
        $logger->log(debug => 'unguarded');
        if ($self->server->buffer_is_full) {
            $logger->log(debug => 'buffer is full');
            return;
        }
        if ($self->server->remaining_tracks > 1) {
            $logger->log(debug => 'too many remaining tracks');
            return;
        }
        $self->start;
    };
    $self->guard($g);

    my $next = $self->next or do {
        $g->cancel;
        $self->unguard;
        return;
    };

    my $url;
    if (ref $next eq 'HASH') {
        $url = $next->{url};
        $logger->log(notice => "#$self->{index}: $next->{title} <$url>");
    } else {
        $url = $next;
        $logger->log(notice => "#$self->{index}: $url");
    }

    my $cv = $self->writer->write($url)
        or do {
            $logger->log(info => 'writer did not write');
            $self->unguard;
            return;
        };
    $cv->cb(sub {
        $self->server->wrote_one_track;
        $self->unguard;
    });
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
