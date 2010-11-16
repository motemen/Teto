package Teto::Server::Queue;
use Any::Moose;

# is
# - play queue
# has
# - queue
# - server
# does
# - push to server
# - accept new entry

has index => (
    is      => 'rw',
    isa     => 'Int',
    default => 0,
);

has next_index => (
    is      => 'rw',
    isa     => 'Int',
    default => 0,
);

has queue => (
    is      => 'rw',
    isa     => 'ArrayRef',
    default => sub { +[] },
    traits  => [ 'Array' ],
    handles => {
        size => 'count',
        push => 'push',
        delete_queue => 'delete',
    },
);

has server => (
    is       => 'rw',
    isa      => 'Teto::Server',
    weak_ref => 1,
    required => 1,
);

has guard => (
    is  => 'rw',
    isa => 'Guard',
);

__PACKAGE__->meta->make_immutable;

use Teto::Writer;
use Teto::Logger qw($logger);
use Teto::Server::Queue::Entry;

use Coro;
use Coro::Timer;

use Guard ();
use UNIVERSAL::require;

around push => sub {
    my ($orig, $self, @args) = @_;
    @args = map { Teto::Server::Queue::Entry->new($_) } @args;
    $logger->log(debug => "<< $_") for @args;
    $self->$orig(@args);
};

around delete_queue => sub {
    my ($orig, $self, $i) = @_;
    $self->{index}-- if $i < $self->index;
    $self->{next_index}-- if $i < $self->next_index;
    $self->$orig($i);
};

sub next {
    my $self = shift;

    if ($self->next_index >= @{ $self->queue }) {
        return undef;
    }

    my $next = $self->queue->[ $self->next_index ];
    $self->{index} = $self->{next_index}++;

    # CodeRef が入ってたらその実行結果を push して次へ
    if ($next->code) {
        my @res = $next->code->();
        $self->push(@res) if @res;
        return $self->next;
    }

    return $next;
}

sub start {
    my $self = shift;

    while (1) {
        my $track = $self->next or do {
            Coro::Timer::sleep 1;
            next;
        };
        $logger->log(info => "next: $track");

        my $writer_class = Teto::Writer->handles_url($track->url) or do {
            $logger->log(notice => 'Cannot handle ' . $track->url);
            next;
        };
        $writer_class->require or do {
            $logger->log(warn => "Could not load $writer_class: $@");
            next;
        };

        my $writer = $writer_class->new(server => $self->server, url => $track->url);

        # 一曲書き込む
        if (my $cv = $writer->write) {
            $cv->cb(rouse_cb);
            rouse_wait;
        }

        if ($writer->wrote) {
            $self->server->wrote_one_track;
            $logger->log(debug => 'writer wrote');
        } elsif ($writer->error) {
            $logger->log(error => 'writer: ' . $writer->error);
        } else {
            $logger->log(notice => 'writer did not write');
        }

        while (1) {
            if ($self->server->buffer->is_full) {
                # $logger->log(debug => 'buffer full');
                $Coro::current->desc('queue paused: buffer is full');
            } elsif ($self->server->remaining_tracks > 1) {
                # $logger->log(info => $self->server->remaining_tracks . 'track(s) remaining');
                $Coro::current->desc('queue paused: ' . $self->server->remaining_tracks . 'track(s) remaining');
            } else {
                last;
            }
            Coro::Timer::sleep 1;
        }
    }
}

sub start_async {
    my $self = shift;
    async {
        $Coro::current->desc('queue');
        $self->start;
    };
}

1;
