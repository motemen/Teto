use strict;
use warnings;
use Test::More;

use_ok 'Teto::Server::Queue';

my $the_cv;

{
    package t::writer;
    use base 'Teto::Writer';

    our @cv;
    our $i = 0;
    our $wrote;

    sub write {
        $wrote = $_[1];
        return $cv[$i++] = AE::cv;
    }

    package t::server;
    use base 'Teto::Server';

    sub setup_callbacks {}
    sub buffer_is_full {}
}

my $writer = t::writer->new;
my $server = t::server->new;
my $q = new_ok 'Teto::Server::Queue', [ writer => $writer, server => $server ];

is $q->index, 0;

$q->push('a', { title => 'b', url => 'http://localhost/' });
is $q->index, 0;

$q->start;
is $t::writer::wrote, 'a';
is $q->index, 1;

$q->push('c');
is $q->index, 1;

$t::writer::cv[0]->send;
is $q->index, 2;
is $t::writer::wrote, 'http://localhost/';

$t::writer::cv[1]->send;
is $q->index, 3;
is $t::writer::wrote, 'c';

done_testing;
