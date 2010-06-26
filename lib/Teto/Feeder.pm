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
        my $tree = HTML::TreeBuilder::XPath->new;
        $tree->parse($res->content);

        my $found;
        my %seen;
        my @links = grep $_, map {
            my $url = $_->string_value;
            not $seen{$url}++ and $url;
        } $tree->findnodes('//a/@href');

        foreach my $link (@links) {
            if (_url_is_like_nicovideo $link) {
                $found++;
                $self->queue->push($link);
            }
        }
        return $found;
    } elsif ($res->content_type =~ /rss|atom|xml/) {
        my $feed = XML::Feed->parse(\$res->content)
            or warn XML::Feed->errstr and return;
        my $found;
        foreach my $entry ($feed->entries) {
            my $link = $entry->link;
            if (_url_is_like_nicovideo $link) {
                $found++;
                $self->queue->push($link);
            }
        }
        return $found;
    }
}

1;
