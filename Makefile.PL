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

requires 'Coro';
requires 'Coro::LWP';

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

test_requires 'Test::More';
test_requires 'Tset::Base';
test_requires 'Tset::Deep';
test_requires 'File::Find::Rule';

tests 't/*.t';
# author_tests 'xt';

requires_external_bin 'ffmpeg';

auto_include;

WriteAll;
