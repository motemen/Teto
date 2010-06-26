use strict;
use Test::More;
use File::Find::Rule;

require_ok $_ for File::Find::Rule->file->name('*.pm')->in('lib');

done_testing;
