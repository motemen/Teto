use strict;
use warnings;
use lib 'lib';
use Teto::Track;
use Teto::Buffer;
use Perl6::Say;

my $url = shift or die "Usage: $0 url\n";
my $track = Teto::Track->from_url($url) or die;

my $buffer = Teto::Buffer->new(min_buffer_size => 0);
$track->buffer($buffer);
$track->play;

my ($fh, $filename) = $track->tempfile(SUFFIX => '.mp3');
say "$url -> $filename";
print $fh $buffer->buffer;
