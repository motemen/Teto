#!/usr/bin/env perl
use strict;
use warnings;
use Config::Pit;
use WWW::NicoVideo::Download;

my $config = pit_get('nicovideo.jp', require => {
    username => 'email/username',
    password => 'password',
});
my $client = WWW::NicoVideo::Download->new(
    email    => $config->{username},
    password => $config->{password},
);

eval {
    $client->login('sm14');
};

if ($@) {
    warn "$@\n";
    print "Login failed; please check your config\n";
} else {
    print "Login succeeded\n";
}

1;
