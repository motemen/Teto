#!/usr/bin/env perl
use strict;
use warnings;
use lib 'lib';

use Teto;

use Config::Pit;

pit_get('nicovideo.jp', require => {
    username => 'nicovideo email/username',
    password => 'nicovideo password',
});

if ($0 eq __FILE__) {
    require Plack::Runner;
    my $teto = Teto->new_with_options;
    my $runner = Plack::Runner->new;
    $runner->parse_options(@{ $teto->extra_argv });
    $runner->run($teto->start_psgi);
} else {
    Teto->new->start_psgi;
}
