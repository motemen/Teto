BEGIN {
    require Module::Install::Any::Moose;
}

use inc::Module::Install;

name 'Teto';
all_from 'lib/Teto.pm';

requires 'Any::Moose', '0.13';
requires_any_moose;
requires_any_moose 'X::Types::Path::Class';
requires_any_moose 'X::Getopt::Strict';

requires 'MouseX::NativeTraits', '1.04';

requires 'AnyEvent';
requires 'Guard';

requires 'Coro';

requires 'Log::Dispatch';
requires 'Exporter::Lite';

requires 'WWW::NicoVideo::Download';
requires 'WWW::YouTube::Download', '0.16';
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

requires 'Twiggy'; # XXX 本当は Plack だけでいいはず

requires 'Plack';

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
