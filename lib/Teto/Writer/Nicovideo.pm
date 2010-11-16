package Teto::Writer::Nicovideo;
use Any::Moose;
use Config::Pit;
use WWW::NicoVideo::Download;
use Teto::Logger qw($logger);
use HTML::TreeBuilder::XPath;

extends 'Teto::Writer';

has nicovideo_client => (
    is  => 'rw',
    isa => 'WWW::NicoVideo::Download',
    lazy_build => 1,
);

sub _build_nicovideo_client {
    my $self = shift;

    my $config = pit_get('nicovideo.jp');
    return WWW::NicoVideo::Download->new(
        email      => $config->{username},
        password   => $config->{password},
    );
}

has '+user_agent' => (
    lazy_build => 1,
);

sub _build_user_agent {
    return shift->nicovideo_client->user_agent;
}

override handles_url => sub {
    my ($self, $url) = @_;
    return $url =~ m<^http://(?:\w+\.nicovideo\.jp/watch|nico\.ms)/(sm\d+)>;
};

no Any::Moose;

sub _write {
    my $self = shift;

    $self->url =~ m<^http://(?:\w+\.nicovideo\.jp/watch|nico\.ms)/(sm\d+)> or die;

    my $video_id = $1;
    utf8::downgrade $video_id, 1;

    my $res = $self->user_agent->get($self->url);
    unless ($res->is_success) {
        $self->error("$self->{url}: " . $res->message);

        my $cv = AE::cv;
        if ($res->code == 403) {
            $logger->log(notice => 'Got 403, sleep for 60s');
            my $w; $w = AE::timer 60, 0, sub {
                $cv->send;
                undef $w;
            };
        } else {
            $cv->send;
        }

        return $cv;
    }
    
    my $title = $self->extract_title($res);
    $logger->log(info => "title: $title");
    my $media_url = eval { $self->nicovideo_client->prepare_download($video_id) };
    if (!$media_url) {
        $logger->log(error => 'Could not get media' . ($@ ? ": $@" : ''));
        my $cv = AE::cv;
        my $w; $w = AE::timer 10, 0, sub {
            $cv->send;
            undef $w;
        };
        return $cv;
    }
    $logger->log(info => "media: $media_url");

    $self->file_cache->set_meta($self->url, title => $title);

    return $self->start_transcoding_url($media_url, { title => $title });
}

sub extract_title {
    my ($self, $res) = @_;
    my $tree = HTML::TreeBuilder::XPath->new_from_content($res->decoded_content);
    my $title = $tree->findvalue('//h1') || $tree->findvalue('//p[@class="video_title"]');
    $tree->delete;
    return $title;
}

1;
