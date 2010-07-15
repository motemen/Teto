use strict;
use warnings;
use Test::More;

use_ok 'Teto::Server::Queue::Entry';

{
    my $e = new_ok 'Teto::Server::Queue::Entry', [ 'about:blank' ];
    is $e->url, 'about:blank';
}

{
    my $e = new_ok 'Teto::Server::Queue::Entry', [ { url => 'about:blank', name => 'foo' } ];
    is $e->url,  'about:blank';
    is $e->name, 'foo';
}

done_testing;
