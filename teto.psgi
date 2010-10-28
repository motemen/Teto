#!/usr/bin/env perl
use strict;
use warnings;
use lib 'lib';

use Teto;

use Coro::Debug;
our $codro_debug_server = Coro::Debug->new_unix_server('/tmp/teto_debug');

$Teto::teto = Teto->new_with_options;
$Teto::teto->start_psgi;
