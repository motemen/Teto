use inc::Module::Install;

name 'Teto';
all_from 'lib/Teto.pm';

requires 'Any::Moose';
requires_any_moose 'X::Types::Path::Class';

requires 'AnyEvent';
requires 'AnyEvent::HTTP';
requires 'AnyEvent::Util';
requires 'AnyEvent::HTTPD';
requires 'Guard';

requires 'WWW::NicoVideo::Download';
requires 'HTML::TreeBuilder::XPath';
requires 'HTTP::Request::Common';
requires 'Encode';
requires 'Config::Pit';

requires 'Text::MicroTemplate';

test_requires 'Test::More';
test_requires 'File::Find::Rule';

tests 't/*.t';
# author_tests 'xt';

requires_external_bin 'ffmpeg';

auto_include;

WriteAll;
