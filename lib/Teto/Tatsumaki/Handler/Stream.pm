package Teto::Tatsumaki::Handler::Stream;
use strict;
use warnings;
use parent 'Teto::Tatsumaki::Handler';
use Coro;

use Teto::Worker::ReadBuffer;

__PACKAGE__->asynchronous(1);

sub get {
    my $self = shift;

    my $control = $self->build_control;

    my $icemeta = !!$self->request->header('ICY-Metadata');
    my $read_buffer = Teto::Worker::ReadBuffer->spawn(
        queue => $control->queue,
        ( $icemeta ? () : ( icemeta => undef ) ),
    );

    $self->binary(1);
    $self->response->content_type('audio/mp3');
    $self->response->header(
        $icemeta ? ( 'Icy-Metaint' => $read_buffer->icemeta->interval ) : (),
        Icy_Name       => 'tetocast',
        Icy_Url        => $self->request->uri,
        Ice_Audio_Info => 'ice-samplerate=44100;ice-bitrate=192000;ice-channels=2',
    );

    $self->flush; # iTunes seems to disconnect if header does not return immediately

    async {
        $Coro::current->desc('streamer coro');

        if ($self->get_writer->isa('Twiggy::Writer')) {
            $self->writer->{handle}->on_drain(unblock_sub {
                my $bytes = $read_buffer->channel->get;
                $self->writer->write($bytes);
            });
            $self->writer->{handle}->on_error(sub {
                my ($handle, $fatal, $msg) = @_;
                $self->log($fatal ? 'error' : 'warn', $msg);
                $self->writer->close;
            });
        } else {
            while (defined (my $bytes = $read_buffer->channel->get)) {
                eval { $self->stream_write($bytes) };
                if ($@) {
                    warn $@;
                    last;
                };
            }
            $self->finish;
        }
    };
}

1;
