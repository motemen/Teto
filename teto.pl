#!/usr/bin/env perl
use strict;
use warnings;
use lib 'lib';

use Teto;

Teto->new_with_options->run;

__END__

./teto.pl --port=9090 --cache-dir=.cache --readonly
