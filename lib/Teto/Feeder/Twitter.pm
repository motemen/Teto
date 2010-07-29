package Teto::Feeder::Twitter;
use Any::Moose;

use Coro;
use AnyEvent::HTTP;
use Config::Pit;
use MIME::Base64;
use Encode;
use Regexp::Common 'URI';

use Teto::Logger '$logger';

extends 'Teto::Feeder';

has 'guard', (
    is  => 'rw',
    isa => 'Guard',
    builder => '_build_guard',
);

our $SHORT_URL_SERVICE_RE = qr(
    http://bit\.ly/\w+
        |
    http://j\.mp/\w+
        |
    http://nico\.ms/\w+
        |
    http://htn\.to/\w+
)x;

sub url_is_expandable {
    my ($url) = @_;
    return $url =~ $SHORT_URL_SERVICE_RE;
}

sub expand_short_url {
    my ($url, $cb) = @_;

    if (url_is_expandable $url) {
        http_head $url, recurse => 0, sub {
            my ($data, $headers) = @_;
            $cb->($headers->{location});
        };
        return 1;
    } else {
        $cb->();
        return undef;
    }
}

sub _build_guard {
    my $self = shift;
    my $config = pit_get('twitter.com');

    die 'login required' unless defined $config->{username} && defined $config->{password};

    my $auth = MIME::Base64::encode("$config->{username}:$config->{password}", '');

    http_request(
        GET => 'http://betastream.twitter.com/2b/user.json',
        headers => {
            Accept => '*/*',
            Authorization => "Basic $auth",
        },
        want_body_handle => 1,
        sub {
            my $hdl = shift;
            my $r = sub {
                my (undef, $json) = @_;
                return unless defined $json->{text};
                $logger->log(debug => "$json->{user}->{screen_name}: $json->{text}");
                for my $url ($json->{text} =~ /$RE{URI}{HTTP}/go) {
                    if (url_is_expandable $url) {
                        $logger->log(info => "found URL $url");
                        async {
                            expand_short_url $url, Coro::rouse_cb;
                            my ($expanded) = Coro::rouse_wait or return;
                            $logger->log(info => "$url => $expanded");
                            $self->queue->push($expanded) if $expanded =~ /www\.nicovideo\.jp/; # XXX
                        };
                    }
                }
            };
            $hdl->on_read(sub { $hdl->push_read(json => $r) });
        },
    );
}

1;
