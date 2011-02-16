use strict;
use warnings;
use lib 'lib';
use Teto::Track;
use Perl6::Say;

my $url = shift or die "Usage: $0 url\n";
my $track = Teto::Track->from_url($url);

my ($fh, $filename) = $track->tempfile(SUFFIX => '.mp3');
say "$url -> $filename";

$track->write_cb(sub { print $fh $_[0] });
$track->play;
