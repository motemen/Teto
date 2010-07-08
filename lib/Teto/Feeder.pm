package Teto::Feeder;
use Any::Moose;

has 'queue', (
    is  => 'rw',
    isa => 'Teto::Server::Queue',
);

has 'ua', (
    is  => 'rw',
    isa => 'LWP::UserAgent',
    default => sub {
        my $ua = WWW::Mechanize->new;
        eval { $ua->autopager->load_siteinfo };
        warn $@ if $@;
        return $ua;
    },
);

__PACKAGE__->meta->make_immutable;

use Teto::Logger qw($logger);

use WWW::Mechanize;
use WWW::Mechanize::AutoPager;
use HTML::TreeBuilder::XPath;
use XML::Feed;

sub _url_is_like_nicovideo {
    my $url = shift;
    $url =~ m<^http://www\.nicovideo\.jp/watch/(s\w+\d+)>;
}

sub feed {
    my ($self, $url) = @_;

    if (_url_is_like_nicovideo $url) {
        $self->queue->push($url);
        return;
    }

    my $res = $self->ua->get($url);
    return if $res->is_error;

    if ($res->content_type =~ /html/) {
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

    my $found;

    my @entries;
    my %url_to_entry;
    foreach ($tree->findnodes('//a[@href]')) {
        my $url = $_->attr('href');
        if ($url_to_entry{$url}) {
            $url_to_entry{$url}{title} ||= $_->as_text;
        } else {
            push @entries, $url_to_entry{$url} = {
                title => $_->as_text,
                url   => $url,
            };
        }
    }

    foreach my $entry (@entries) {
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
            $self->queue->push(sub {
                $self->feed($url);
                return ();
            });
        }
    }

    return $found;
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
                title => $title,
                url   => $link,
            });
        }
    }

    return $found;
}

1;
