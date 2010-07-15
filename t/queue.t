use strict;
use warnings;
use Test::More tests => 13;
use Test::Deep;
use Teto::Server;

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

}

my $writer = t::writer->new;
my $server = Teto::Server->new;
my $q = new_ok 'Teto::Server::Queue', [ writer => $writer, server => $server ];

is $q->index, 0;

$q->push('about:blank');
$q->push({ name => 'example', url => 'http://www.example.com/' });

is $q->index, 0;

$q->start;

is $t::writer::wrote, 'about:blank'
    or diag explain $t::writer::wrote;
undef $t::writer::wrote;
is $q->index, 1;

$q->push(sub { +{ url => 'http://localhost/' } });

is $q->index, 1;

$t::writer::cv[0]->send;

is $q->index, 2;
is $t::writer::wrote, 'http://www.example.com/'
    or diag explain $t::writer::wrote;
undef $t::writer::wrote;

$t::writer::cv[1]->send;

is $q->index, 4;
is $t::writer::wrote, 'http://localhost/'
    or diag explain $t::writer::wrote;

my $called;
$q->push(sub { $called++; () });

$t::writer::cv[2]->send;

is $q->index, 5;
ok $called;

done_testing;
