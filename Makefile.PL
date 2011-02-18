use inc::Module::Install;

name 'Teto';
all_from 'lib/Teto.pm';

# Core
requires 'Mouse';
requires 'MouseX::Types::Path::Class';
requires 'MouseX::Types::URI';
requires 'MouseX::NativeTraits', '1.04';

requires 'AnyEvent';
requires 'AnyEvent::HTTP';
requires 'AnyEvent::Util';

requires 'Coro';
requires 'Coro::Signal';
requires 'Coro::LWP';

requires 'Twiggy';
requires 'Plack::Runner';

# Track
requires 'LWP::UserAgent';
requires 'WWW::Mechanize';
requires 'WWW::Mechanize::AutoPager';
requires 'HTTP::Request::Common';
requires 'Crypt::SSLeay';

# Track::NicoVideo
requires 'WWW::NicoVideo::Download';
requires 'Config::Pit';

# Track::YouTube
requires 'WWW::YouTube::Download', '0.16';

# Feeder
requires 'HTML::LinkExtor';

requires 'JSON::XS';
requires 'Try::Tiny';

test_requires 'Test::More';
test_requires 'Test::Deep';
test_requires 'Test::Requires';
test_requires 'File::Find::Rule';

tests 't/*.t';
# author_tests 'xt';

# Track::NicoVideo::sm
requires_external_bin 'ffmpeg';

# Track::NicoVideo::nm
requires_external_bin 'swfextract';

auto_include;
# auto_install;

WriteAll;
