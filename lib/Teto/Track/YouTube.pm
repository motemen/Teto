package Teto::Track::YouTube;
use Mouse;
use WWW::YouTube::Download;
use Encode;

extends 'Teto::Track';

has video_id => (
    is  => 'rw',
    isa => 'Str',
    required => 1,
);

has '+image' => (
    lazy => 1,
    default => sub {
        my $self = shift;
        return "http://i.ytimg.com/vi/$self->{video_id}/0.jpg";
    },
);

has youtube_client => (
    is  => 'rw',
    isa => 'WWW::YouTube::Download',
    default => sub { WWW::YouTube::Download->new },
);

override buildargs_from_url => sub {
    my ($class, $url) = @_;
    $url =~ m<^http://www\.youtube\.com/watch\?.*?\bv=([^&]+)> or return undef;
    return { video_id => $1 };
};

override _play => sub {
    my $self = shift;
    my $media_url = $self->media_url or do {
        $self->add_error('no media url');
        return;
    };
    my $fh = $self->url_to_fh($media_url);
    $self->ffmpeg($fh);
};

sub _build_media_url {
    my $self = shift;
    my $media_url = eval { $self->youtube_client->get_video_url($self->video_id) } or do {
        $self->add_error("get_video_url failed: $@");
        return undef;
    };
    $self->title(Encode::decode_utf8 $self->youtube_client->get_title($self->video_id));
    return $media_url;
}

__PACKAGE__->meta->make_immutable;

no Mouse;

1;
