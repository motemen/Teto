package Teto::Track::NicoVideo;
use Mouse;
use AnyEvent;
use Coro;
use Coro::Semaphore;
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

has '+image' => (
    lazy => 1,
    default => sub {
        my $self = shift;
        my ($id) = $self->video_id =~ /(\d+)$/;
        return "http://tn-skr3.smilevideo.jp/smile?i=$id";
    }
);

has '+user_agent' => (
    lazy_build => 1,
);

has 'semaphore' => (
    is  => 'rw',
    isa => 'Coro::Semaphore',
    default => sub {
        our $semaphore ||= Coro::Semaphore->new;
    },
);

our @RequestQueue;
our $UserAgent;

sub wait_in_queue {
    my $self = shift;
    push @RequestQueue, $Coro::current;

    if (@RequestQueue > 1) {
        $self->log(info => 'another track is doing request; wait in queue');
        $self->log(debug => "queue: @RequestQueue");
        schedule;
    }
}

sub leave_from_queue {
    my $self = shift;
    shift @RequestQueue; # XXX must be self
    $self->log(debug => 'release queue');
    if (my $coro = $RequestQueue[0]) {
        $coro->cede_to;
    }
}

sub log_extra_info {
    my $self = shift;
    return $self->video_id;
}

sub _build_nicovideo_client {
    my $self = shift;

    my $config = pit_get('nicovideo.jp');
    return WWW::NicoVideo::Download->new(
        email    => $config->{username},
        password => $config->{password},
        ( $UserAgent ? ( user_agent => $UserAgent ) : () ),
    );
}

sub _build_user_agent {
    return $UserAgent ||= shift->nicovideo_client->user_agent;
}

sub _build_media_url {
    my $self = shift;

    $self->log_coro('_build_media_url');

    $self->wait_in_queue;

    $self->log(debug => 'GET ' . $self->url);
    my $res = $self->user_agent->get($self->url);

    unless ($res->is_success) {
        $self->add_error('_build_media_url ' . $self->url . ': ' . $res->code . ' ' . $res->message);
        $self->sleep(60) if $res->code == 403;
        $self->leave_from_queue;
        return;
    }

    if (defined (my $title = $self->extract_title_from_res($res))) {
        $self->title($title);
    }

    my $media_url = eval { $self->nicovideo_client->prepare_download($self->video_id) };
    unless ($media_url) {
        $self->add_error('Could not get media' . ($@ ? ": $@" : ''));
        $self->sleep($@ && $@ =~ /403/ ? 60 : 10);
        $self->leave_from_queue;
        return;
    }
    $self->log(info => "media: $media_url");

    # release after 60 secs
    my $w; $w = AE::timer 60, 0, sub {
        $self->leave_from_queue;
        undef $w;
    };

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
