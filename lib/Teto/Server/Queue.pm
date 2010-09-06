package Teto::Server::Queue;
use Any::Moose;

has 'index', (
    is      => 'rw',
    isa     => 'Int',
    default => 0,
);

has 'queue', (
    is      => 'rw',
    isa     => 'ArrayRef',
    default => sub { +[] },
    traits  => [ 'Array' ],
    handles => {
        size => 'count',
        push => 'push',
        insert_queue => 'insert',
    },
);

has 'server', (
    is       => 'rw',
    isa      => 'Teto::Server',
    weak_ref => 1,
    required => 1,
);

has 'guard', (
    is  => 'rw',
    isa => 'Guard',
);

__PACKAGE__->meta->make_immutable;

use Teto::Writer;
use Teto::Logger qw($logger);
use Teto::Server::Queue::Entry;

use AnyEvent;
use Guard ();

around push => sub {
    my ($orig, $self, @args) = @_;
    @args = map Teto::Server::Queue::Entry->new($_), @args;
    $logger->log(debug => "<< $_") for @args;
    $self->$orig(@args);
};

sub insert {
    my $self = shift;
    my @entries = map { Teto::Server::Queue::Entry->new($_) } @_;
    $logger->log(debug => "<< $_") for @entries;
    $self->insert_queue($self->index, $_) for @entries;
}

sub next {
    my $self = shift;

    if ($self->index >= @{ $self->queue }) {
        return undef;
    }

    my $next = $self->queue->[ $self->index ];
    $self->{index}++;

    if ($next->code) {
        my @res = $next->code->();
        $self->insert(@res) if @res;
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

    $self->{guard} = Guard::guard {
        return unless $self->server;
        $logger->log(debug => 'unguarded');
        if ($self->server->buffer->overruns) {
            $logger->log(debug => 'buffer is full');
            return;
        }
        if ($self->server->remaining_tracks > 1) {
            $logger->log(debug => 'too many remaining tracks');
            return;
        }
        $self->start;
    };

    my $next = $self->next;
    
    if (not $next) {
        $self->guard->cancel;
        $self->unguard;
        return;
    };

    my $writer = Teto::Writer->new(server => $self->server, url => $next->url);
    my $cv = $writer->write;
        
    if (not $cv) {
        $logger->log(debug => 'writer did not write');
        $self->unguard;
        return;
    }

    $cv->cb(sub {
        my $exit_code = shift->recv || 0;
        if ($exit_code != 0) {
            $logger->log(error => "transcoder exited with code $exit_code");
        }
        $self->server->wrote_one_track;
        $self->unguard;
    });
}

sub unguard {
    my $self = shift;
    undef $self->{guard};
}

sub DEMOLISH {
    my $self = shift;
    $self->guard->cancel if $self->guard;
}

1;
