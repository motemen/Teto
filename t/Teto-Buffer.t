use strict;
use Test::More;
use Coro;

use_ok 'Teto::Buffer';

my $buffer = new_ok 'Teto::Buffer', [ max_buffer_size => 5, min_buffer_size => 1 ];

subtest 'read write' => sub {
    is $buffer->buffer, '', q(buffer = '');

    my @coros;

    push @coros, async {
        $buffer->write('abc');
        note q(wrote 'abc');
    };
    cede;

    is $buffer->buffer, 'abc', q(buffer = 'abc');

    push @coros, async {
        $buffer->write('def');
        note q(wrote 'def');
    };
    cede;

    is $buffer->buffer, 'abcdef', q(buffer = 'abcdef');

    push @coros, async {
        $buffer->write('ghi');
        note q(wrote 'ghi');
    };
    cede;

    is $buffer->buffer, 'abcdef', q(buffer = 'abcdef');

    push @coros, async {
        my $read = $buffer->read(5);
        is $read, 'abcde', q(read 'abcde');
    };
    cede;

    $_->join for @coros;

    is $buffer->buffer, 'fghi', q(buffer = 'fghi');
};

done_testing;
