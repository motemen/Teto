use strict;
use Test::More;
use File::Find::Rule;

for (File::Find::Rule->file->name('*.pm')->in('lib')) {
    s<^lib/><>;
    s<\.pm$><>;
    s</><::>g;
    use_ok $_;
}

done_testing;
