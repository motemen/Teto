package Teto::Track::NicoVideo::sm;
use Mouse;

extends 'Teto::Track::NicoVideo';

override buildargs_from_url => sub {
    my ($class, $url) = @_;
    $url =~ m<^http://(?:\w+\.nicovideo\.jp/watch|nico\.ms)/(sm\d+)> or return undef;
    return { video_id => $1 };
};

override _play => sub {
    my $self = shift;
    my $media_url = $self->media_url or return;
    my $fh = $self->url_to_fh($media_url);
    $self->ffmpeg($fh);
};

after done => sub {
    my $self = shift;
    if (my $e = $self->error) {
        $self->sleep($e =~ /403/ ? 30 : 10);
    }
};

__PACKAGE__->meta->make_immutable;

no Mouse;

1;
