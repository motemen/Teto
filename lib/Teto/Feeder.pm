package Teto::Feeder;
use Any::Moose;

has 'queue', (
    is  => 'rw',
    isa => 'Teto::Server::Queue',
);

has 'ua', (
    is  => 'rw',
    isa => 'LWP::UserAgent',
    default => sub { LWP::UserAgent->new },
);

__PACKAGE__->meta->make_immutable;

use Teto::Logger qw($logger);

use LWP::UserAgent;
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

        my $tree = HTML::TreeBuilder::XPath->new;
        $tree->parse($res->content);

        my $found;
        my %seen;
        my @links = grep $_, map {
            my $url = $_->string_value;
            not $seen{$url}++ and $url;
        } $tree->findnodes('//a/@href');
        $logger->log(debug => "@links");

        foreach my $link (@links) {
            $link =~ s"^/*"http://www.nicovideo.jp/" unless $link =~ /^https?:/;
            if (_url_is_like_nicovideo $link) {
                $found++;
                $logger->log(debug => "found $link");
                $self->queue->push($link);
            }
        }

        return $found;
    }
    elsif ($res->content_type =~ /rss|atom|xml/) {
        $logger->log(debug => "$url seems like a feed");

        my $feed = XML::Feed->parse(\$res->content)
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
}

1;
