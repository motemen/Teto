package Teto::Track::NicoVideo;
use Mouse;
use WWW::NicoVideo::Download;
use Config::Pit;

extends 'Teto::Track';

has video_id => (
    is  => 'rw',
    isa => 'Str',
    required => 1,
);

has nicovideo_client => (
    is  => 'rw',
    isa => 'WWW::NicoVideo::Download',
    lazy_build => 1,
);

has '+user_agent' => (
    lazy_build => 1,
);

override buildargs_from_url => sub {
    my ($class, $url) = @_;
    $url =~ m<^http://(?:\w+\.nicovideo\.jp/watch|nico\.ms)/(sm\d+)> or return undef;
    return { video_id => $1 };
};

override play => sub {
    my $self = shift;
    my $media_url = $self->get_media_url or return;
    my $fh = $self->url_to_fh($media_url);
    $self->ffmpeg($fh);
};

sub _build_nicovideo_client {
    my $self = shift;

    my $config = pit_get('nicovideo.jp');
    return WWW::NicoVideo::Download->new(
        email    => $config->{username},
        password => $config->{password},
    );
}

sub _build_user_agent {
    return shift->nicovideo_client->user_agent;
}

sub get_media_url {
    my $self = shift;

    my $res = $self->user_agent->get($self->url);
    unless ($res->is_success) {
        $self->error($res->message);
        $self->sleep(60) if $res->code == 403;
        return;
    }

    my $media_url = eval { $self->nicovideo_client->prepare_download($self->video_id) };
    unless ($media_url) {
        $self->error('Could not get media' . ($@ ? ": $@" : ''));
        $self->sleep(10);
        return;
    }
    $self->log(info => "media: $media_url");

    return $media_url;
}

__PACKAGE__->meta->make_immutable;

no Mouse;

1;
