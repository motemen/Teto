use Test::Base;
use Test::More;

plan tests => 3 + blocks;

use_ok 'Teto::Feeder';
use_ok 'Teto::Server::Queue';

my $feeder = new_ok 'Teto::Feeder', [ queue => Teto::Server::Queue->new ];

local $Test::Builder::Level = $Test::Builder::Level + 2;

filters {
    url => 'fake_feed',
    queue => [ qw(utf8 yaml) ],
};

run_is_deep url => 'queue';

sub fake_feed {
    use HTTP::Response;
    use URI::Escape;

    my $url = shift;
    chomp $url;

    (my $file = uri_escape($url, "\x00-\x1f\x7f-\xff")) =~ s/[:\/]+/-/g;
    $file = "t/samples/$file";

    open my $fh, '<', $file or die "$!: $file";

    my $res = HTTP::Response->parse(do { local $/; <$fh> });
    $feeder->queue->queue([]);
    $feeder->feed_res($res, $url);
    return $feeder->queue->queue;
}

sub only {
    use Test::Deep ();
    my @indices = split /,/, filter_arguments;
    my %index_to_value; @index_to_value{ @indices } = @{ $_[0] };
    return [ map { exists $index_to_value{$_} ? $index_to_value{$_} : Test::Deep::ignore() } (0 .. $indices[-1]) ];
}

sub utf8 {
    use Encode;
    return Encode::decode_utf8($_[0]);
}

__END__

=== はてなブックマーク
--- url
http://b.hatena.ne.jp/motemen/
--- queue
- title: 重音テト　で　「サンドキャニオン」‐ニコニコ動画(秋)
  url: http://www.nicovideo.jp/watch/sm4965375
- title: ゆめにっきキャニオン‐ニコニコ動画(ββ)
  url: http://www.nicovideo.jp/watch/sm7786003

=== ニコニコ動画タグ一覧
--- url
http://www.nicovideo.jp/tag/サンドキャニオン
--- queue only=0,30
- title: 変態先進国 黒子キャニオン【とある科学の超電磁砲】
  url: http://www.nicovideo.jp/watch/sm8755361
- title: 【吉幾三】先進村になれる訳無ェ！！【サンドキャニオン】
  url: http://www.nicovideo.jp/watch/sm5296951

=== ニコニコ動画マイリスト
--- url
http://www.nicovideo.jp/mylist/12065500
--- queue only=0,26
- title: 【VOCALOID】公開マイリスト一覧入口【無限公開マイリスト】
  url: http://www.nicovideo.jp/watch/sm3555836
- title: 【初音ミク他】 VOCALOMANIA SPEED2 【高速ノンストップメドレー】
  url: http://www.nicovideo.jp/watch/sm8078428
