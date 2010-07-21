package Teto::Feeder::Twitter;
use Any::Moose;

use AnyEvent::HTTP;
use Config::Pit;
use MIME::Base64;
use Encode;

use Teto::Logger '$logger';

extends 'Teto::Feeder';

has 'guard', (
    is  => 'rw',
    isa => 'Guard',
    builder => '_build_guard',
);

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
                my ($url) = $json->{text} =~ m<(http://nico\.ms/sm\d+)>;
                $self->queue->push($url) if $url;
            };
            $hdl->on_read(sub { $hdl->push_read(json => $r) });
        },
    );
}

1;
