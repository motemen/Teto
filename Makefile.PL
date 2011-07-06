use inc::Module::Install;

name 'Teto';
all_from 'lib/Teto.pm';

# Core
requires 'Mouse';
requires 'Mouse::Role';
requires 'MouseX::Types::Path::Class';
requires 'MouseX::Types::URI';
requires 'MouseX::NativeTraits', '1.04';
requires 'parent';
requires 'POSIX';

requires 'AnyEvent';
requires 'AnyEvent::AIO';
requires 'AnyEvent::HTTP';
requires 'AnyEvent::Util';
requires 'AnyEvent::Handle';

requires 'Coro';
requires 'Coro::Signal';
requires 'Coro::LWP';
requires 'Coro::AIO';
requires 'Coro::Timer';
requires 'Coro::Semaphore';

requires 'Twiggy';
requires 'Plack', '0.998';

requires 'URI';
requires 'Encode';
requires 'Try::Tiny';
requires 'JSON::XS';
requires 'Scalar::Util';
requires 'POSIX';

# Track
requires 'LWP::UserAgent';
requires 'WWW::Mechanize';
requires 'WWW::Mechanize::AutoPager';
requires 'HTTP::Request::Common';
requires 'Crypt::SSLeay';
requires 'Cache::LRU';
requires 'Class::Load';
requires 'Path::Class';
requires 'File::Temp';
requires 'IO::AIO';

# Track::NicoVideo
requires 'WWW::NicoVideo::Download';
requires 'Config::Pit';

# Track::YouTube
requires 'WWW::YouTube::Download', '0.16';

# Feeder
requires 'HTML::TreeBuilder::XPath';

# Server
requires 'Router::Simple';
requires 'Text::MicroTemplate::File';
requires 'Plack::Middleware::File::Sass';

test_requires 'Test::More';
test_requires 'Test::Deep';
test_requires 'Test::Requires';
test_requires 'File::Find::Rule';
test_requires 'LWPx::Record::DataSection';

tests 't/*.t';
# author_tests 'xt';

# Track::NicoVideo::sm
requires_external_bin 'ffmpeg';

# Track::NicoVideo::nm
requires_external_bin 'swfextract';

auto_include;
# auto_install;

WriteAll;
