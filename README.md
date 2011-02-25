Teto
====

Description
-----------

Sound streaming server for continual listening to nicovideo/soundcloud/youtube tracks.

 * Treats web pages as playlists, and plays tracks in sequence.
 * Supports autopagering, thus automatically loads "next pages."
 * Requires `ffmpeg`.
 * Requires `swfextract` if you want to play nicovideo "nm" videos.

How to listen
-------------

	 ./teto.pl --port 9090 url url ...

And open http://localhost:9090/stream in your music player to start streaming. Open http://localhost:9090/ to see or manipulate playlists.

Screenshot
----------
[![http://f.hatena.ne.jp/motemen/20110225182738](http://cdn-ak.f.st-hatena.com/images/fotolife/m/motemen/20110225/20110225182738.png)](http://f.hatena.ne.jp/motemen/20110225182738)
