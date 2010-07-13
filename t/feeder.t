use strict;
use warnings;
use utf8;
use Test::More tests => 11;
use Teto::Server::Queue;

use_ok 'Teto::Feeder';

my $q = Teto::Server::Queue->new;
my $feeder = new_ok 'Teto::Feeder', [ queue => $q ];

{
    use utf8;

    my $res = fake_http_response('http://b.hatena.ne.jp/motemen/');
    ok $res->is_success;

    $feeder->_feed_by_html($res);

    is $q->size, 2;
    is_deeply $q->queue, [ {
        title => '重音テト　で　「サンドキャニオン」‐ニコニコ動画(秋)',
        url   => 'http://www.nicovideo.jp/watch/sm4965375',
    }, {
        title => 'ゆめにっきキャニオン‐ニコニコ動画(ββ)',
        url   => 'http://www.nicovideo.jp/watch/sm7786003',
    } ];
}

$q->queue([]);

{
    use utf8;

    # 「サンドキャニオン」タグ
    my $res = fake_http_response('http://www.nicovideo.jp/tag/%E3%82%B5%E3%83%B3%E3%83%89%E3%82%AD%E3%83%A3%E3%83%8B%E3%82%AA%E3%83%B3');
    ok $res->is_success;

    $feeder->_feed_by_html($res);

    is $q->size, 31; # nm\d+ が抜けてる
    is_deeply $q->queue->[0], {
        title => '変態先進国 黒子キャニオン【とある科学の超電磁砲】',
        url   => 'http://www.nicovideo.jp/watch/sm8755361',
    };
}

$q->queue([]);

{
    my $res = fake_http_response('http://www.nicovideo.jp/mylist/12065500');
    ok $res->is_success;

    $feeder->_feed_by_nicovideo_mylist($res);

    is $q->size, 27;
    is_deeply $q->queue->[0], {
        title => '【VOCALOID】公開マイリスト一覧入口【無限公開マイリスト】',
        url   => 'http://www.nicovideo.jp/watch/sm3555836',
    };
}

done_testing;

use HTTP::Response;

sub fake_http_response {
    my $url = shift;

    (my $file = $url) =~ s/[:\/]+/-/g;
    $file = "t/samples/$file";

    open my $fh, '<', $file or die "$!: $file";

    local $/;
    return HTTP::Response->parse(<$fh>);
}
