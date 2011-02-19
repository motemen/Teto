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

our $user_agent;

sub _build_nicovideo_client {
    my $self = shift;

    my $config = pit_get('nicovideo.jp');
    return WWW::NicoVideo::Download->new(
        email    => $config->{username},
        password => $config->{password},
        ( $user_agent ? ( user_agent => $user_agent ) : () ),
    );
}

sub _build_user_agent {
    return $user_agent ||= shift->nicovideo_client->user_agent;
}

sub _build_media_url {
    my $self = shift;

    my $res = $self->user_agent->get($self->url);
    unless ($res->is_success) {
        $self->error($res->message);
        $self->sleep(60) if $res->code == 403;
        return;
    }

    if (defined (my $title = $self->extract_title_from_res($res))) {
        $self->title($title);
    }

    my $media_url = eval { $self->nicovideo_client->prepare_download($self->video_id) };
    unless ($media_url) {
        $self->error('Could not get media' . ($@ ? ": $@" : ''));
        $self->sleep($@ && $@ =~ /403/ ? 60 : 10);
        return;
    }
    $self->log(info => "media: $media_url");

    return $media_url;
}

sub extract_title_from_res {
    my ($self, $res) = @_;
    my ($title) = $res->decoded_content =~ m#<title>(.+?)</title># or warn $res->decoded_content;
    use utf8;
    $title =~ s/ ‐ ニコニコ動画.*?$//;
    return $title;
}

__PACKAGE__->meta->make_immutable;

no Mouse;

1;
