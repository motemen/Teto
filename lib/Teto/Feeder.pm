package Teto::Feeder;
use Mouse;
use MouseX::Types::URI;
use AnyEvent;
use WWW::Mechanize;
use WWW::Mechanize::AutoPager;
# use Coro::LWP; # load in teto.pl
use Coro::Signal;
use Try::Tiny;
use JSON::XS;
use HTML::TreeBuilder::XPath;
use URI;
use URI::Escape;
use Teto::Track;
use Teto::Track::System;

$WWW::Mechanize::HAS_ZLIB = 0; # XXX to detect $res->base correctly

with 'Teto::Role::Log';

has url => (
    is  => 'rw',
    isa => 'URI',
    required => 1,
    coerce   => 1,
);

has image => (
    is  => 'rw',
    isa => 'Maybe[Str]', # Maybe[URI],
);

has title => (
    is  => 'rw',
    isa => 'Maybe[Str]',
);

has tracks => (
    is  => 'rw',
    isa => 'ArrayRef[Teto::Track]',
    default => sub { +[] },
    traits  => [ 'Array' ],
    handles => {
        push_track => 'push',
    },
    auto_deref => 1,
);

has user_agent => (
    is  => 'rw',
    isa => 'LWP::UserAgent',
    lazy_build => 1,
);

has autopagerize => (
    is  => 'rw',
    isa => 'Bool',
    default => 1,
);

has signal => (
    is  => 'rw',
    isa => 'Coro::Signal',
    default => sub { Coro::Signal->new },
);

# share HTML::AutoPagerize
sub _build_user_agent {
    my $self = shift;
    my $ua = WWW::Mechanize->new;
    if ($self->autopagerize) {
        if (our $AutoPager) {
            $ua->autopager->{autopager} = $AutoPager;
        } else {
            try {
                $ua->autopager->load_siteinfo;
                $AutoPager = $ua->autopager->{autopager};
            } catch {
                $self->log(warn => $_);
            };
        }
    }
    return $ua;
}

sub feed {
    my $self = shift;
    my $url = $self->url;

    if (Teto::Track->is_track_url($url)) {
        $self->push_track_url($url);
        return 1;
    }

    return $self->feed_url($url);
}

sub feed_url {
    my ($self, $url) = @_;

    $self->log(info => "fetching $url");

    my $res = eval { $self->user_agent->get($url) };
    if (!$res || $res->is_error) {
        $self->log(error => "$url: " . ($res ? $res->status_line : $@));
        return;
    }

    my $found = $self->feed_by_res($res, $url) || 0;
    $self->log(info => "found $found track(s)");

    if ($self->autopagerize && (my $next_link = $self->user_agent->next_link)) {
        $self->log(info => "found next page $next_link");
        $self->push_track(
            Teto::Track::System->new(title => "next page: $next_link", code => sub { $self->feed_next_url })
        );
    }

    $self->guess_title_from_res($res) unless $self->title;
    $self->guess_image_from_res($res) unless $self->image;

    return $found;
}

# TODO feed tracks delta
after feed_url => sub {
    my $self = shift;
    $self->log(debug => 'broadcast after feed_url');
    $self->signal->broadcast; # Control が受け取ってトラックを Queue に渡す
};

sub feed_next_url {
    my $self = shift;
    if (my $next_link = $self->user_agent->next_link) {
        return $self->feed_url($next_link);
    }
}

sub push_track_url {
    my ($self, $url, %args) = @_;
    my $track = Teto::Track->from_url($url, %args) or return;
    $self->push_track($track);
    return $track;
}

sub feed_by_res {
    my ($self, $res, $url) = @_;

    if ($url =~ m<^http://www\.nicovideo\.jp/mylist/\d+>) {
        $self->log(info => "$url seems to be a nicovideo mylist");
        return $self->_feed_by_nicovideo_mylist_res($res);
    } elsif ($res->content_type =~ m(/x?html\b)) {
        $self->log(info => "$url seems to be an HTML page");
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
        $self->push_track_url($url, title => $_->{title});
        $found++;
    }
    return $found;
}

sub _feed_by_html_res {
    my ($self, $res) = @_;

    my $tree = HTML::TreeBuilder::XPath->new;
    $tree->parse($res->decoded_content);

    my $base = $tree->findvalue('//base/@href') || $res->base; # workaround for AnyEvent::HTTP::LWP::UserAgent

    my $found = 0;
    my %seen;
    my @links = $tree->findnodes('//a');
    foreach my $link (@links) {
        my $url = URI->new_abs($link->attr('href'), $base);
        if ($seen{$url}) {
            $seen{$url}->{title} ||= $link->as_text;
            next;
        }
        if (Teto::Track->is_track_url($url) && !$seen{$url}) {
            $seen{$url} = $self->push_track_url($url, title => $link->as_text);
            $found++;
        }
    }

    $tree->delete;

    return $found;
}

sub guess_title_from_res {
    my ($self, $res) = @_;
    my ($title) = $res->decoded_content =~ m#<title>(.+)</title>#s or return;
    $self->title($title);
}

sub guess_image_from_res {
    my ($self, $res) = @_;

    if (my ($meta_og_image) = $res->decoded_content =~ m#(<meta[^>]*\bproperty="og:image"[^>]*>)#) {
        if (my ($image) = $meta_og_image =~ m#content="([^"]+)"#) {
            $self->image($image);
            return;
        }
    }

    if ($res->base->host eq 'b.hatena.ne.jp') {
        if (my ($username) = $res->base->path =~ m#^/([\w-]{3,32})/#) {
            $self->image(join '/', 'http://www.st-hatena.com/users', substr($username, 0, 2), $username, 'profile.gif');
            return;
        }
    }

    if ($res->base->host eq 'www.nicovideo.jp') {
        # 左上
        $self->image(sprintf 'http://res.nimg.jp/img/base/head/icon/nico/%03d.gif', int rand 960);
        return;
    }

    $self->image('http://cdn-ak.favicon.st-hatena.com/?url=' . uri_escape($res->base));
}

sub uri_canonical {
    my ($self, $uri) = @_;
    return URI->new($uri)->canonical;
}

no Mouse;

__PACKAGE__->meta->make_immutable;

1;
