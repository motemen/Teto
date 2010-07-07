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
 * http://yourhost:9090/ をブラウザで開くといろいろ見られます。
 * 初回時には script/setup-pit.pl を実行して、ログイン情報を設定する必要があります。

TODO
----
 * リンク抽出するときにタイトルも抽出する
 * 403 になると何もできなくなる → キューを辿る条件をきつくした
 * ニコ動以外のサイト
 * <del>AutoPagerize</del>
 * Twitter
 * nm\d+ って再生できるのか
 * マイリストは JS が必要らしい…

Screenshot
----------
[![http://f.hatena.ne.jp/motemen/20100628065201](http://img.f.hatena.ne.jp/images/fotolife/m/motemen/20100628/20100628065201.png)](http://f.hatena.ne.jp/motemen/20100628065201)
