use inc::Module::Install;

name 'Teto';
all_from 'lib/Teto.pm';

requires 'Any::Moose';
requires_any_moose 'X::Types::Path::Class';
requires_any_moose 'X::NativeTraits';

requires 'AnyEvent';
requires 'AnyEvent::HTTP';
requires 'Guard';

requires 'Coro';

requires 'Log::Dispatch';
requires 'Exporter::Lite';

requires 'WWW::NicoVideo::Download';
requires 'HTML::TreeBuilder::XPath';
requires 'HTTP::Request::Common';
requires 'Encode';
requires 'Config::Pit';

requires 'Text::MicroTemplate';

requires 'XML::Feed';
requires 'WWW::Mechanize';
requires 'WWW::Mechanize::AutoPager';
requires 'JSON::XS';
requires 'Regexp::Common';

requires 'YAML::Tiny';

test_requires 'Test::More';
test_requires 'Test::Base';
test_requires 'Test::Deep';
test_requires 'File::Find::Rule';

tests 't/*.t';
# author_tests 'xt';

requires_external_bin 'ffmpeg';

auto_include;
# auto_install;

WriteAll;
