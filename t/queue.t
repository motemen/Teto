use strict;
use warnings;
use Test::More;
use Test::Deep;

use Teto::Server;
use Teto::Writer;

use AnyEvent;

my $cv;
my @writers;

{
    no warnings 'redefine';
    *Teto::Writer::write = sub {
        push @writers, $_[0];
        return $cv = AE::cv;
    };
}

use_ok 'Teto::Server::Queue';

my $server = Teto::Server->new;
my $queue  = new_ok 'Teto::Server::Queue', [ server => $server ];

# push url, hashref
$queue->push('about:blank');
$queue->push({ name => 'example', url => 'http://www.example.com/' });

is $queue->index, 0,      'initial';
cmp_deeply \@writers, [ ],'initial';

$queue->start;
cmp_deeply \@writers, [
    noclass({ server => $server, url => 'about:blank' })
], 'started';
is $queue->index, 1, 'started';

# push coderef
$queue->push(sub { +{ url => 'http://localhost/' } });
is $queue->index, 1, 'pushed; writer 1 not finished';

$cv->send;
cmp_deeply \@writers, [
    noclass({ server => $server, url => 'about:blank' }),
    noclass({ server => $server, url => 'http://www.example.com/' }),
], 'writer 1 finish';
is $queue->index, 2, 'writer 1 finish';

$cv->send;
cmp_deeply \@writers, [
    noclass({ server => $server, url => 'about:blank' }),
    noclass({ server => $server, url => 'http://www.example.com/' }),
    noclass({ server => $server, url => 'http://localhost/' }),
], 'writer 2 finish; produced url';
is $queue->index, 4, 'writer 2 finish; produced url';

done_testing;
