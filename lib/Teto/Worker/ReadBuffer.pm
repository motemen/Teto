package Teto::Worker::ReadBuffer;
use Mouse;
use Coro;
use Data::Interleave::IcecastMetadata;

with 'Teto::Role::Log';

has queue => (
    is  => 'rw',
    isa => 'Teto::Queue',
);

has icemeta => (
    is  => 'rw',
    default => sub { Data::Interleave::IcecastMetadata->new },
);

# TODO これバイト列専用に
has channel => (
    is  => 'rw',
    default => sub { Coro::Channel->new },
);

__PACKAGE__->meta->make_immutable;

no Mouse;

sub spawn {
    my ($class, %args) = @_;
    my $self = $class->new(%args);
    $self->work_async;
    return $self;
}

sub work_async {
    my $self = shift;

    async {
        $self->read_one_track while 1;
    };
}

sub wait_for_current_track {
    my $self = shift;

    my $track;
    until ($track = $self->queue->queue->[0]) {
        $self->log(debug => 'wait for queue->track_signal');
        $self->queue->track_signal->wait;
        $self->log(debug => 'back from queue->track_signal');
    }
    $self->icemeta->metadata->{title} = $track->title if $self->icemeta;

    return $track;
}

sub read_one_track {
    my $self = shift;

    $self->log(debug => 'read_one_track');

    my $track = $self->wait_for_current_track;

    $self->log(debug => 'track: ' . $track->url);

    async { $track->play }; # ここ誰かに任せるべき
    open my $fh, '<', $track->buffer_ref or do {
        $self->log(error => $!);
        return;
    };

    while (1) {
        # この辺を Worker::PlayTrack にする？
        my $bytes_to_read = length($track->buffer) - tell($fh);
        if ($bytes_to_read < 0) {
            $track->log(error => q(track buffer got GC'ed));
            $track->done;
            $track->buffer_signal->broadcast;

            close $fh;
            $self->queue->dequeue_track;

            return;
        }

        read $fh, my ($buf), $bytes_to_read;

        if (length $buf == 0 || $bytes_to_read == 0) {
            if ($track->is_done) {
                close $fh;
                $self->queue->dequeue_track;

                $self->log(debug => 'track done');

                return;
            }

            # $self->log(debug => 'wait for track->buffer_signal');
            $track->buffer_signal->wait;
            # $self->log(debug => 'back from track->buffer_signal');
        } else {
            $buf = $self->icemeta->interleave($buf) if $self->icemeta;
            $self->log(debug => 'put ' . length($buf) . ' bytes');
            $self->channel->put($buf);
            cede;
        }
    }
}

1;
