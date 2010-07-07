use strict;
use warnings;
use Test::More;
use Teto::Server::Queue;
use HTTP::Response;

use_ok 'Teto::Feeder';

my $q = Teto::Server::Queue->new;
my $feeder = new_ok 'Teto::Feeder', [ queue => $q ];

my $res = fake_http_response('http://b.hatena.ne.jp/motemen/');
$feeder->_feed_by_html($res);

is $q->size, 2;
is_deeply $q->queue, [
  'http://www.nicovideo.jp/watch/sm4965375',
  'http://www.nicovideo.jp/watch/sm7786003',
];

sub fake_http_response {
    my $url = shift;

    (my $file = $url) =~ s/[:\/]+/-/g;
    $file = "t/samples/$file";

    open my $fh, '<', $file or die "$!: $file";

    local $/;
    return HTTP::Response->parse(<$fh>);
}

done_testing;
