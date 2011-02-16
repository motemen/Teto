package Teto::Feeder;
use Mouse;
use WWW::Mechanize;
use WWW::Mechanize::AutoPager;
use Coro::LWP;
use Try::Tiny;
use JSON::XS;
use HTML::ResolveLink;
use Teto::Track;

with 'Teto::Role::Log';

has playlist => (
    is  => 'rw',
    isa => 'Teto::Playlist',
    default => sub { require Teto; Teto->playlist },
);

has user_agent => (
    is  => 'rw',
    isa => 'LWP::UserAgent',
    lazy_build => 1,
);

sub _build_user_agent {
    my $self = shift;
    my $ua = WWW::Mechanize->new;
    try {
        $ua->autopager->load_siteinfo;
    } catch {
        $self->log(warn => $_);
    };
    return $ua;
}

sub feed_by_url {
    my ($self, $url) = @_;

    if (Teto::Track->is_track_url($url)) {
        $self->playlist->add_url($url);
        return 1;
    }

    my $res = $self->user_agent->get($url);
    if ($res->is_error) {
        $self->log(error => "$url: " . $res->message);
        return;
    }

    return $self->feed_by_res($res, $url);
}

sub feed_by_res {
    my ($self, $res, $url) = @_;

    if ($url =~ m<^http://www\.nicovideo\.jp/mylist/\d+>) {
        $self->log(debug => "$url seems to be a nicovideo mylist");
        return $self->_feed_by_nicovideo_mylist_res($res);
    } elsif ($res->content_type =~ m(/x?html\b)) {
        $self->log(debug => "$url seems to be an HTML page");
        return $self->_feed_by_html_res($res);
    }
}

sub _feed_by_nicovideo_mylist_res {
    my ($self, $res) = @_;

    my ($json) = $res->decoded_content =~ /\bMylist\.preload\(\d+,(.+?)\);/ or return;
    my @items = map { $_->{item_data} } @{ decode_json $json };

    # my ($title) = $res->decoded_content =~ m#<link rel="alternate" charset="utf-8" type="application/rss\+xml" title="([^"]+)"#;

    my $found = 0;
    foreach (@items) {
        next unless ref eq 'HASH';
        my $video_id = $_->{video_id} or next;
        my $url = "http://www.nicovideo.jp/watch/$video_id";
        $self->log(debug => "found $url");
        $self->playlist->add_url($url);
        $found++;
    }
    return $found;
}

sub _feed_by_html_res {
    my ($self, $res) = @_;

    my $found = 0;
    my $resolver = HTML::ResolveLink->new(
        base => $res->base,
        callback => sub {
            my $url = shift;
            if (Teto::Track->is_track_url($url)) {
                $self->log(debug => "found $url");
                $self->playlist->add_url($url);
                $found++;
            }
        },
    );
    $resolver->resolve($res->decoded_content);
    return $found;
}

no Mouse;

__PACKAGE__->meta->make_immutable;

1;
