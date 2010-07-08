use strict;
use Test::More;
use File::Find::Rule;

my @files = File::Find::Rule->file->name('*.pm')->in('lib');
plan tests => scalar @files;

for (@files) {
    s<^lib/><>;
    s<\.pm$><>;
    s</><::>g;
    use_ok $_;
}

done_testing;
