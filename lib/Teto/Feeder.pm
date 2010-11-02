package Teto::Feeder;
use Any::Moose;

has queue => (
    is  => 'rw',
    isa => 'Teto::Server::Queue',
    required => 1,
);

has ua => (
    is  => 'rw',
    isa => 'LWP::UserAgent',
    lazy_build => 1,
);

has feeds => (
    is  => 'rw',
    isa => 'ArrayRef[HashRef]',
    traits  => [ 'Array' ],
    default => sub { [] },
    handles => {
        push_feed => 'push',
    },
);

__PACKAGE__->meta->make_immutable;

use Teto::Logger qw($logger);

use Coro;
use Coro::LWP;
use WWW::Mechanize;
use WWW::Mechanize::AutoPager;
use HTML::TreeBuilder::XPath;
use XML::Feed;
use JSON::XS qw(decode_json);

sub _build_ua {
    my $ua = WWW::Mechanize->new;
    eval { $ua->autopager->load_siteinfo };
    $logger->log(warn => $@) if $@;
    return $ua;
}

sub _url_is_like_nicovideo {
    my $url = shift;
    $url =~ m<^http://(?:www\.nicovideo\.jp/watch|nico\.ms)/sm\d+>;
}

sub feed_async {
    my ($self, @urls) = @_;

    async {
        foreach my $url (@urls) {
            utf8::encode $url if utf8::is_utf8 $url;

            if (_url_is_like_nicovideo $url) {
                $self->queue->push($url);
                next;
            }

            my $res = $self->ua->get($url);
            if ($res->is_error) {
                $logger->log(error => "$url: " . $res->message);
                next;
            }

            my ($found, $title) = $self->feed_res($res, $url);

            if ($found) {
                $self->push_feed({ url => $url, title => $title });
            } else {
                $logger->log(notice => "$url: no video found");
            }
        }
    };
}

sub feed_res {
    my ($self, $res, $url) = @_;

    $Coro::current->desc("feeder: feeding $url") if $Coro::current;

    $url ||= $res->base;

    if ($url =~ m<^http://www\.nicovideo\.jp/mylist/\d+>) {
        $logger->log(debug => "$url seems like a nicovideo mylist");
        return $self->_feed_by_nicovideo_mylist($res);
    } elsif ($res->content_type =~ /html/) {
        $logger->log(debug => "$url seems like an HTML");
        return $self->_feed_by_html($res);
    }
    elsif ($res->content_type =~ /rss|atom|xml/) {
        $logger->log(debug => "$url seems like a feed");
        return $self->_feed_by_feed($res);
    }
}

sub _feed_by_html {
    my ($self, $res) = @_;

    my $tree = HTML::TreeBuilder::XPath->new;
    $tree->parse($res->decoded_content);

    my ($title) = $res->decoded_content =~ m#<title>(.+?)</title>#s;

    my $found;

    my @entries;
    my %url_to_entry;
    foreach ($tree->findnodes('//a[@href]')) {
        my $url = $_->attr('href');
        if ($url_to_entry{$url}) {
            $url_to_entry{$url}{name} ||= $_->as_text;
        } else {
            push @entries, $url_to_entry{$url} = {
                name => $_->as_text,
                url  => $url,
            };
        }
    }

    my $content = $res->decoded_content;
    while ($content =~ m#<iframe[^>]* src="http://ext\.nicovideo\.jp/thumb/(sm\d+)"#g) {
        push @entries, { url => "http://www.nicovideo.jp/watch/$1", name => $1 };
    }

    foreach my $entry (@entries) {
        # 相対 URL を (むりやり) 絶対 URL に
        $entry->{url} =~ s"^/*"http://www.nicovideo.jp/" unless $entry->{url} =~ /^https?:/;
        if (_url_is_like_nicovideo $entry->{url}) {
            $found++;
            $logger->log(debug => "found $entry->{url}");
            $self->queue->push($entry);
        }
    }

    if ($found) {
        if (my $url = $self->ua->next_link) {
            $logger->log(debug => "autopager link found: $url");
            $self->queue->push({
                name => "AutoPager $url",
                code => sub {
                    $self->feed_async($url);
                    return ();
                },
            });
        }
    }

    $tree->delete;

    return ($found, $title);
}

sub _feed_by_feed {
    my ($self, $res) = @_;

    my $feed = XML::Feed->parse(\$res->decoded_content)
        or warn XML::Feed->errstr and return;

    my $found;
    foreach my $entry ($feed->entries) {
        my $link = $entry->link;
        if (_url_is_like_nicovideo $link) {
            $found++;
            my $title = $entry->title;
            $logger->log(debug => "found $title <$link>");
            $self->queue->push({
                name => $title,
                url  => $link,
            });
        }
    }

    return ($found, $feed->title);
}

sub _feed_by_nicovideo_mylist {
    my ($self, $res) = @_;

    my ($json) = $res->decoded_content =~ /\bMylist\.preload\(\d+,(.+?)\);/ or return;
    my $list = decode_json $json;

    my ($title) = $res->decoded_content =~ m#<link rel="alternate" charset="utf-8" type="application/rss\+xml" title="([^"]+)"#;

    my $found;
    foreach (@$list) {
        my $item_data = $_->{item_data};
        next unless ref $item_data eq 'HASH';
        my $url   = 'http://www.nicovideo.jp/watch/' . ($item_data->{video_id} || next);
        my $title = $_->{item_data}->{title};
        $found++;
        $logger->log(debug => "found $title <$url>");
        $self->queue->push({
            name => $title,
            url  => $url,
        });
    }

    return ($found, $title);
}

1;
