Teto
====

Description
-----------
音声を聴くためのニコニコ動画ストリームプロキシです。
メディアファイルをローカルに保存しつつ、トランスコーディングしてストリームプレーヤーで再生できます。


Synopsis
--------
以下のようにして起動し、

	./teto.pl 'http://www.nicovideo.jp/tag/サンドキャニオン?sort=v'

 * http://yourhost:9090/stream にプレーヤでアクセスすると連続して音声を聴けます。
   * 動的なタイトルの更新に対応しているプレーヤー (iTunes, foobar2000 など) で聴く必要があります.
 * http://yourhost:9090/ をブラウザで開くといろいろ見られます。
 * 初回時には script/setup-pit.pl を実行して、ログイン情報を設定する必要があります。

アイコンは [Mini Pixel Icons](http://icondock.com/free/mini-pixel-icons) のものを使用しました。

TODO
----
 * <del>リンク抽出するときにタイトルも抽出する</del>
 * 403 になると何もできなくなる → キューを辿る条件をきつくした
 * ニコ動以外のサイト
 * <del>AutoPagerize</del>
 * Twitter
 * nm\d+ って再生できるのか
 * マイリストは JS が必要らしい…
 * ICY 対応してないのも
 * Queue ちゃんと表示
 * HTTP GET で固まる/進行状況
 * どうせ時報女です

Screenshot
----------
[![http://f.hatena.ne.jp/motemen/20100708224728](http://img.f.hatena.ne.jp/images/fotolife/m/motemen/20100708/20100708224728.png)](http://f.hatena.ne.jp/motemen/20100708224728)
