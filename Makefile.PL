use inc::Module::Install;

name 'Teto';
all_from 'lib/Teto.pm';

# requires '';

test_requires 'Test::More';

tests 't/*.t';
# author_tests 'xt';

auto_include;

WriteAll;
