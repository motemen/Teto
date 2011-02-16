package Teto::Track::NicoVideo::nm;
use Mouse;

extends 'Teto::Track::NicoVideo';

override buildargs_from_url => sub {
    my ($class, $url) = @_;
    $url =~ m<^http://(?:\w+\.nicovideo\.jp/watch|nico\.ms)/(nm\d+)> or return undef;
    return { video_id => $1 };
};

override play => sub {
    my $self = shift;
    my $media_url = $self->get_media_url or return;
    my $flv = $self->download_temporary($media_url => '.flv');
    my $mp3 = $self->temporary_filename('.mp3');
    $self->run_command([ 'swfextract', $flv, '-m', '-o', $mp3 ]);
    $self->read_file_to_buffer($mp3);
};

__PACKAGE__->meta->make_immutable;

no Mouse;

1;
