use strict;
use warnings;
use Test::More;

use_ok 'Teto::Server::Queue';

my $the_cv;

{
    package t::worker;
    use base 'Teto::Writer';

    our @cv;
    our $i = 0;

    sub write {
        return $cv[$i++] = AE::cv;
    }
}

my $writer = t::worker->new;
my $q = new_ok 'Teto::Server::Queue', [ writer => $writer ];

is $q->index, 0;
$q->push('a', 'b');
is $q->index, 0;
$q->start;
is $q->index, 1;
$q->push('c');
is $q->index, 1;
$t::worker::cv[0]->send;
is $q->index, 2;
$t::worker::cv[1]->send;
is $q->index, 3;

done_testing;
