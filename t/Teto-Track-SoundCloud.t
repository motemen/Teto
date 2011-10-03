use strict;
use utf8;
use lib 'lib';
use Test::More;
use Test::Requires 'Test::Fake::LWP';

use_ok 'Teto::Track::SoundCloud';

my %Cases = (
    'http://soundcloud.com/takuma-hosokawa/darksidenadeko-electro-mix' => {
        title => '恋愛サーキュレーション（DarksideNADEKO Electro Mix)',
        as_string => '恋愛サーキュレーション（DarksideNADEKO Electro Mix) <http://soundcloud.com/takuma-hosokawa/darksidenadeko-electro-mix>',
    },
    'http://soundcloud.com/inu/virgins-high-crabmixx2-221210' => {
        title => q#virgin's high! (crabMixx2) 221210#,
        as_string => q#virgin's high! (crabMixx2) 221210 <http://soundcloud.com/inu/virgins-high-crabmixx2-221210>#,
    },
);

while (my ($url, $e) = each %Cases) {
    subtest $url => sub {
        my $track = new_ok 'Teto::Track::SoundCloud', [ url => $url ];
        $track->prepare;
        ok $track->media_url, 'media_url';
        is $track->title, $e->{title}, 'title';
        is "$track", $e->{as_string}, '""';
    };
}

done_testing;

__DATA__

@@ GET http://soundcloud.com/takuma-hosokawa/darksidenadeko-electro-mix
HTTP/1.1 200 OK
Cache-Control: private, max-age=0, must-revalidate
Connection: close
Date: Fri, 18 Feb 2011 04:46:58 GMT
Via: 1.1 varnish
Age: 0
ETag: "e78ca2af68c5256418df0d89f5202a66"
Server: nginx
Vary: Accept-Encoding
Content-Length: 34904
Content-Type: text/html; charset=utf-8

<!DOCTYPE html>
<html lang="en" xml:lang="en" xmlns="http://www.w3.org/1999/xhtml"><head><meta charset="utf-8" />
<title>恋愛サーキュレーション（DarksideNADEKO Electro Mix) by Takuma. on SoundCloud - Create, record and share your sounds for free</title>
<meta content="record, sounds, share, sound, audio, tracks, music, soundcloud" name="keywords" />
<meta content="Listen to 恋愛サーキュレーション（DarksideNADEKO Electro Mix) by Takuma.: 恋愛サーキュレーションのバンギンエレクトロリミックス！！ | Create, record and share the sounds you create anywhere to friends, family and the world with SoundCloud, the world's largest community of sound creators." name="description" />

<meta content="width=device-width" name="viewport" />
<meta content="chrome=1" name="X-UA-Compatible" />
<meta content="19507961798" property="fb:app_id" />
<meta content="SoundCloud" property="og:site_name" />
<meta content="恋愛サーキュレーション（DarksideNADEKO Electro Mix) by Takuma. on SoundCloud" property="og:title" />
<meta content="http://a1.soundcloud.com/images/fb_placeholder.png?983cc9" property="og:image" />
<meta content="Click to listen to this sound by Takuma.: 恋愛サーキュレーションのバンギンエレクトロリミックス！！ | Shared via SoundCloud" property="og:description" />
<meta content="video" name="medium" />
<meta content="98" property="og:video:height" />
<meta content="460" property="og:video:width" />
<meta content="application/x-shockwave-flash" property="og:video:type" />
<meta content="http://player.soundcloud.com/player.swf?url=http%3A%2F%2Fsoundcloud.com%2Ftakuma-hosokawa%2Fdarksidenadeko-electro-mix&amp;color=3b5998&amp;auto_play=true&amp;show_artwork=false" property="og:video" />
<link href="http://soundcloud.com/oembed?url=http%3A%2F%2Fsoundcloud.com%2Ftakuma-hosokawa%2Fdarksidenadeko-electro-mix&amp;format=xml" rel="alternate" type="text/xml+oembed" />
<link href="http://soundcloud.com/oembed?url=http%3A%2F%2Fsoundcloud.com%2Ftakuma-hosokawa%2Fdarksidenadeko-electro-mix&amp;format=json" rel="alternate" type="application/json+oembed" />

<!--[if IE]>
<script src="http://a1.soundcloud.com/javascripts/plugins/vendor/excanvas-compressed.js?983cc9" type="text/javascript"></script>
<![endif]-->
<!--[if IE 8]>
<script type="text/javascript">
document.getElementsByTagName("html")[0].className = "ie8";
</script>
<![endif]-->
<!--[if IE 7]>
<script type="text/javascript">
document.getElementsByTagName("html")[0].className = "ie7";
</script>
<![endif]-->
<!--[if lte IE 7]>
<meta content="true" name="MSSmartTagsPreventParsing" />
<meta content="false" http-equiv="imagetoolbar" />
<![endif]-->
<script type="text/javascript">
window.SC = {"bufferTracks":[],"bufferComments":[],"cookieDomain":"soundcloud.com","assetPath":"a1.soundcloud.com","assetPathSSL":"soundcloud.com","facebook":{"appKey":"61261ce0407b2ccb568641b513098e18","xdReceiver":"/connect/xd_receiver.htm"},"gaID":"UA-2519404-1"};
</script>
<link href="http://a1.soundcloud.com/stylesheets/general.css?983cc9" media="all" rel="stylesheet" type="text/css" />
<link href="http://a1.soundcloud.com/stylesheets/special.css?983cc9" media="all" rel="stylesheet" type="text/css" />
<link href="/sc-opensearch.xml" rel="search" title="SoundCloud Search" type="application/opensearchdescription+xml" />

<link href="http://a1.soundcloud.com/images/apple-touch-icon.png?983cc9" rel="apple-touch-icon" />
<link href="http://a1.soundcloud.com/favicon.ico?983cc9" rel="shortcut icon" />
<link href="http://a1.soundcloud.com/images/soundcloud_fluid.png?983cc9" rel="fluid-icon" />
</head>
<body class="show restricted full-music" id="tracks"><div id="header"><div id="header-top"><div id="sc-info"><a href="/apps?ref=top">App Gallery</a>
|
<a href="/help">Get help</a>
|
<a href="/premium?ref=top">Plans</a>
|
<a href="http://blog.soundcloud.com/tag/feature/">What's new?</a></div>
<div id="user-status"><a class="logged-out" href="/" id="logo">Soundcloud</a>
<a href="/login?ref=top" class="sign-in" id="login-link">Log In</a>
|
<a href="/signup?ref=top">Sign Up</a></div></div>
<div id="header-lower"><ul id="main-nav"><li class="nav no-submenu" id="menu-button-home"><a href="/">Home</a>
<div class="open-submenu"></div></li>
<li class="nav no-submenu" id="menu-button-tour"><a href="/tour/">The Tour</a>
<div class="open-submenu"></div></li>
<li class="nav no-submenu" id="menu-button-signup"><a href="/signup">Sign Up</a>
<div class="open-submenu"></div></li>
<li id="menu-button-upload"><a href="/upload" class="link-button">Upload &amp; Share</a></li></ul>

<div id="volume"><a class="volume-control-button level0" title="Set the volume">Volume</a>
<div class="aural" id="volume-control"><a class="volume-control-button level0">Volume</a>
<div id="volume-control-wrapper"><a class="volume-plus">+</a>
<div id="volume-control-handle"></div>
<div id="volume-control-scale"></div>
<a class="volume-minus"></a></div></div></div>
<div id="search"><form action="/search" method="get">
<input accesskey="f" autocomplete="off" class="blurred" id="header-search" name="q[fulltext]" placeholder="Search SoundCloud" type="text" value="Search SoundCloud" />
<div class="search-selector" title="Select what you want to search for"></div>
<ul class="pulldown hidden search-select"><li><a href="/tracks/search">Tracks</a></li>
<li><a href="/people/search">Users</a></li>
<li><a href="/groups/search">Groups</a></li></ul>
</form></div></div></div>

<div id="main-wrapper"><div id="main-content"><div id="main-content-inner">
<div class="player mode large haudio  " data-sc-track="3174371"><div class="info-header large"><div class="meta-data"><div class="key-bpm"><span class="track-type">Remix</span></div></div>
<h1><em>
恋愛サーキュレーション（DarksideNADEKO Electro Mix)
</em></h1>
<h2>Uploaded by
<span class="user tiny"><a href="/takuma-hosokawa" class="user-name">Takuma.</a>&#x000A;<span class="user-status"><span class="contact add-contact"><a class="contact-link update"><span>Start following</span></a></span></span></span>


<abbr title='May, 29 2010 14:44:31 +0000' class='pretty-date'>on May 29, 2010 14:44</abbr></h2></div>
<div class="actionbar"><a href="/tags/electro"><span class="genre" title="Find more Electro tracks">Electro</span></a><div class="actions"><div class="primary"><a href="#share" class="share pl-button" onclick="return false;" rel="nofollow" title="Share this on other networks"><span>Share</span></a>
<div class="share-code hidden action-overlay"><div class="action-overlay-inner"><a href="/takuma-hosokawa/darksidenadeko-electro-mix/share-options" class="lazy initial" onclick="return false;" rel="nofollow">Loading sharing options</a></div></div>

<a href="/you/favorites/takuma-hosokawa/darksidenadeko-electro-mix" class="pl-button favorite create" onclick="return false;" rel="nofollow"><span>Save to Favorites</span></a>
<span class="disabled download pl-button" title="The track has reached its download limit"><span>Download</span></span></div>
<div class="secondary"><a href="/reports?track=darksidenadeko-electro-mix&amp;user=takuma-hosokawa" class="report-this-track pl-button" onclick="return false;" rel="nofollow" title="Report this track"><span>Report this track</span></a></div>
<div class="hidden download-options action-overlay" data-sc-track="3174371"><div class="action-overlay-inner">This track has reached its <strong>download limit</strong>.</div></div></div></div>

<div class="container"><div class="controls"><a href="#play" class="play" onclick="return false;" rel="nofollow">Play</a>
<div class="timecodes"><span class="editable">0.00</span>
/
<span class="duration" title="PT639">6.39</span></div></div>
<div class="display"><div class="progress"></div>
<img class="waveform" src="http://waveforms.soundcloud.com/eM86sW4HK4Gz_m.png" unselectable="on" />
<img class="waveform-overlay" src="http://a1.soundcloud.com/images/player-overlay.png?983cc9" unselectable="on" />
<div class="playhead aural"></div>
<div class="seekhead hidden"><div><span></span></div></div>
<ol class="timestamped-comments "><li class="aural template timestamped-comment"><div class="marker" style="width: 1px"></div></li></ol></div>
<a class="comments-toggle" href="#no-comments" title="Hide the comments">Hide the comments</a>
</div>

<script type="text/javascript">
window.SC.bufferTracks.push({"id":3174371,"uid":"eM86sW4HK4Gz","user":{"username":"Takuma.","permalink":"takuma-hosokawa"},"uri":"/takuma-hosokawa/darksidenadeko-electro-mix","duration":399067,"token":"wUEVM","name":"darksidenadeko-electro-mix","title":"\u604b\u611b\u30b5\u30fc\u30ad\u30e5\u30ec\u30fc\u30b7\u30e7\u30f3\uff08DarksideNADEKO Electro Mix)","commentable":true,"revealComments":true,"commentUri":"/takuma-hosokawa/darksidenadeko-electro-mix/comments/","streamUrl":"http://media.soundcloud.com/stream/eM86sW4HK4Gz?stream_token=wUEVM","waveformUrl":"http://waveforms.soundcloud.com/eM86sW4HK4Gz_m.png","propertiesUri":"/takuma-hosokawa/darksidenadeko-electro-mix/properties/","statusUri":"/transcodings/eM86sW4HK4Gz","replacingUid":null,"preprocessingReady":true,"renderingFailed":false,"commentableByUser":true,"makeHeardUri":false,"favorite":false,"followingTrackOwner":false,"conversations":{}});
</script>
<script type="text/javascript">
window.SC.bufferComments = window.SC.bufferComments.concat([]);
</script></div>

</div></div>
<div id="side-content">
<div class="context-item context-box"><div class="mini-update"><h3>Stats for this track</h3>
<table><tr><th></th>
<th class="week">This Week</th>
<th class="total">Total</th></tr><tr class="even"><td class="plays">Plays</td>
<td class="week" data-sc-week-plays="25">25</td>
<td class="total" data-sc-total-plays="1070">1070</td></tr>
<tr class="odd"><td class="favoritings">Favoritings</td>
<td class="week" data-sc-week-favoritings="0">&ndash;</td>
<td class="total" data-sc-total-favoritings="22">22</td></tr>
<tr class="even"><td class="downloads">Downloads</td>
<td class="week" data-sc-week-downloads="0">&ndash;</td>
<td class="total" data-sc-total-downloads="100">100</td></tr>
</table></div></div>

<div class="context-item"><h3>Uploaded by</h3>
<ul class="user-list-small"><li class="user small" id="user-small-615815"><a href="/takuma-hosokawa" class="user-image-badge" style="background-image: url(http://i1.soundcloud.com/avatars-000001293320-oasacr-badge.jpg?983cc9)">Takuma.</a>
<span class="user-info"><a href="/takuma-hosokawa" class="user-link">Takuma.</a>
<span class="user-status"><span class="contact add-contact"><a class="contact-link update"><span>Start following</span></a></span>

<a href="/messages/new?to=615815" class="send-message" title="Send a message"></a></span>
<span class="user-realname">Takuma (Sugar's Campaign)</span>
<div class="public-songs-info">7 public tracks</div></span></li>
</ul></div>
<div class="context-item"><h3>More tracks by
 Takuma.</h3>
<div class="tracks-small"><div class="small player haudio mode" data-sc-track="10636085"><h3><a href="/takuma-hosokawa/sleeping-jellyfish">Sleeping Jellyfish</a></h3>
<div class="container"><div class="controls"><a href="#play" class="play" onclick="return false">Play</a></div><div class="display"><div class="progress"></div>
<img class="waveform" src="http://waveforms.soundcloud.com/xooG6q9Iyork_m.png" unselectable="on" />
<img class="waveform-overlay" src="http://a1.soundcloud.com/images/player-overlay.png?983cc9" unselectable="on" />
<div class="playhead aural"></div>
<div class="seekhead hidden"><div><span></span></div></div>
<ol class="timestamped-comments "><li class="aural template timestamped-comment"><div class="marker" style="width: 1px"><a href="/tel_yee" class="user-image-tiny" style="background-image: url(http://i1.soundcloud.com/avatars-000002424553-eevees-tiny.jpg?983cc9)">TEL-YEE aka TEL=I</a></div></li></ol></div>
</div>
<script type="text/javascript">
window.SC.bufferTracks.push({"id":10636085,"uid":"xooG6q9Iyork","user":{"username":"Takuma.","permalink":"takuma-hosokawa"},"uri":"/takuma-hosokawa/sleeping-jellyfish","duration":191158,"token":"T7Z6v","name":"sleeping-jellyfish","title":"Sleeping Jellyfish","commentable":true,"revealComments":true,"commentUri":"/takuma-hosokawa/sleeping-jellyfish/comments/","streamUrl":"http://media.soundcloud.com/stream/xooG6q9Iyork?stream_token=T7Z6v","waveformUrl":"http://waveforms.soundcloud.com/xooG6q9Iyork_m.png","propertiesUri":"/takuma-hosokawa/sleeping-jellyfish/properties/","statusUri":"/transcodings/xooG6q9Iyork","replacingUid":null,"preprocessingReady":true,"renderingFailed":false,"commentableByUser":true,"makeHeardUri":false,"favorite":false,"followingTrackOwner":false,"conversations":{}});
</script>
<script type="text/javascript">
window.SC.bufferComments = window.SC.bufferComments.concat([]);
</script></div>
<div class="small player haudio mode" data-sc-track="8748227"><h3><a href="/takuma-hosokawa/j-theatre-takuma-remix">J.theatre (Takuma remix)  ※DL Free</a></h3>
<div class="container"><div class="controls"><a href="#play" class="play" onclick="return false">Play</a></div><div class="display"><div class="progress"></div>
<img class="waveform" src="http://waveforms.soundcloud.com/XCC3Si1QuIAD_m.png" unselectable="on" />
<img class="waveform-overlay" src="http://a1.soundcloud.com/images/player-overlay.png?983cc9" unselectable="on" />
<div class="playhead aural"></div>
<div class="seekhead hidden"><div><span></span></div></div>
<ol class="timestamped-comments "><li class="aural template timestamped-comment"><div class="marker" style="width: 1px"></div></li></ol></div>
</div>
<script type="text/javascript">
window.SC.bufferTracks.push({"id":8748227,"uid":"XCC3Si1QuIAD","user":{"username":"Takuma.","permalink":"takuma-hosokawa"},"uri":"/takuma-hosokawa/j-theatre-takuma-remix","duration":411322,"token":"VXrMa","name":"j-theatre-takuma-remix","title":"J.theatre (Takuma remix)  \u203bDL Free","commentable":true,"revealComments":true,"commentUri":"/takuma-hosokawa/j-theatre-takuma-remix/comments/","streamUrl":"http://media.soundcloud.com/stream/XCC3Si1QuIAD?stream_token=VXrMa","waveformUrl":"http://waveforms.soundcloud.com/XCC3Si1QuIAD_m.png","propertiesUri":"/takuma-hosokawa/j-theatre-takuma-remix/properties/","statusUri":"/transcodings/XCC3Si1QuIAD","replacingUid":null,"preprocessingReady":true,"renderingFailed":false,"commentableByUser":true,"makeHeardUri":false,"favorite":false,"followingTrackOwner":false,"conversations":{}});
</script>
<script type="text/javascript">
window.SC.bufferComments = window.SC.bufferComments.concat([]);
</script></div>
<div class="small player haudio mode" data-sc-track="8085671"><h3><a href="/takuma-hosokawa/takumas-remix">坂本真綾 - 悲しくてやりきれない (Takuma's remix)</a></h3>
<div class="container"><div class="controls"><a href="#play" class="play" onclick="return false">Play</a></div><div class="display"><div class="progress"></div>
<img class="waveform" src="http://waveforms.soundcloud.com/iVcVmLHxaYL4_m.png" unselectable="on" />
<img class="waveform-overlay" src="http://a1.soundcloud.com/images/player-overlay.png?983cc9" unselectable="on" />
<div class="playhead aural"></div>
<div class="seekhead hidden"><div><span></span></div></div>
<ol class="timestamped-comments "><li class="aural template timestamped-comment"><div class="marker" style="width: 1px"></div></li></ol></div>
</div>
<script type="text/javascript">
window.SC.bufferTracks.push({"id":8085671,"uid":"iVcVmLHxaYL4","user":{"username":"Takuma.","permalink":"takuma-hosokawa"},"uri":"/takuma-hosokawa/takumas-remix","duration":319310,"token":"gLdtt","name":"takumas-remix","title":"\u5742\u672c\u771f\u7dbe - \u60b2\u3057\u304f\u3066\u3084\u308a\u304d\u308c\u306a\u3044 (Takuma's remix)","commentable":true,"revealComments":true,"commentUri":"/takuma-hosokawa/takumas-remix/comments/","streamUrl":"http://media.soundcloud.com/stream/iVcVmLHxaYL4?stream_token=gLdtt","waveformUrl":"http://waveforms.soundcloud.com/iVcVmLHxaYL4_m.png","propertiesUri":"/takuma-hosokawa/takumas-remix/properties/","statusUri":"/transcodings/iVcVmLHxaYL4","replacingUid":null,"preprocessingReady":true,"renderingFailed":false,"commentableByUser":true,"makeHeardUri":false,"favorite":false,"followingTrackOwner":false,"conversations":{}});
</script>
<script type="text/javascript">
window.SC.bufferComments = window.SC.bufferComments.concat([]);
</script></div>
<div class="small player haudio mode" data-sc-track="6910399"><h3><a href="/takuma-hosokawa/mix">恋愛サーキュレーション （00:00:00 おやすmix）</a></h3>
<div class="container"><div class="controls"><a href="#play" class="play" onclick="return false">Play</a></div><div class="display"><div class="progress"></div>
<img class="waveform" src="http://waveforms.soundcloud.com/X18rjieneEQP_m.png" unselectable="on" />
<img class="waveform-overlay" src="http://a1.soundcloud.com/images/player-overlay.png?983cc9" unselectable="on" />
<div class="playhead aural"></div>
<div class="seekhead hidden"><div><span></span></div></div>
<ol class="timestamped-comments "><li class="aural template timestamped-comment"><div class="marker" style="width: 1px"></div></li></ol></div>
</div>
<script type="text/javascript">
window.SC.bufferTracks.push({"id":6910399,"uid":"X18rjieneEQP","user":{"username":"Takuma.","permalink":"takuma-hosokawa"},"uri":"/takuma-hosokawa/mix","duration":496437,"token":"xfYYE","name":"mix","title":"\u604b\u611b\u30b5\u30fc\u30ad\u30e5\u30ec\u30fc\u30b7\u30e7\u30f3 \uff0800:00:00 \u304a\u3084\u3059mix\uff09","commentable":true,"revealComments":true,"commentUri":"/takuma-hosokawa/mix/comments/","streamUrl":"http://media.soundcloud.com/stream/X18rjieneEQP?stream_token=xfYYE","waveformUrl":"http://waveforms.soundcloud.com/X18rjieneEQP_m.png","propertiesUri":"/takuma-hosokawa/mix/properties/","statusUri":"/transcodings/X18rjieneEQP","replacingUid":null,"preprocessingReady":true,"renderingFailed":false,"commentableByUser":true,"makeHeardUri":false,"favorite":false,"followingTrackOwner":false,"conversations":{}});
</script>
<script type="text/javascript">
window.SC.bufferComments = window.SC.bufferComments.concat([]);
</script></div>
<div class="small player haudio mode" data-sc-track="6909948"><h3><a href="/takuma-hosokawa/wind-scene-skweee-remix">クロノトリガー 風の憧憬 -Wind Scene - (Skweee Remix)</a></h3>
<div class="container"><div class="controls"><a href="#play" class="play" onclick="return false">Play</a></div><div class="display"><div class="progress"></div>
<img class="waveform" src="http://waveforms.soundcloud.com/zWhPWPNT8OBL_m.png" unselectable="on" />
<img class="waveform-overlay" src="http://a1.soundcloud.com/images/player-overlay.png?983cc9" unselectable="on" />
<div class="playhead aural"></div>
<div class="seekhead hidden"><div><span></span></div></div>
<ol class="timestamped-comments "><li class="aural template timestamped-comment"><div class="marker" style="width: 1px"></div></li>
<li class="timestamped-comment" data-sc-comment-timestamp="29097" style="left: 11.121133478827536%;"><div class="marker" style="width: 1px"><a href="/486" class="user-image-tiny" style="background-image: url(http://i1.soundcloud.com/avatars-000002661839-xqzujp-tiny.jpg?983cc9)">486 Sound System™</a></div></li>
<li class="timestamped-comment" data-sc-comment-timestamp="43501" style="left: 16.62647102665143%;"><div class="marker" style="width: 1px"><a href="/ogpg" class="user-image-tiny" style="background-image: url(http://i1.soundcloud.com/avatars-000002210301-ff72qm-tiny.jpg?983cc9)">ogopogo</a></div></li>
<li class="timestamped-comment" data-sc-comment-timestamp="80313" style="left: 30.696346464758424%;"><div class="marker" style="width: 1px"><a href="/itsmeelan" class="user-image-tiny" style="background-image: url(http://i1.soundcloud.com/avatars-000000915256-ucz04h-tiny.jpg?983cc9)">eLan</a></div></li>
<li class="timestamped-comment" data-sc-comment-timestamp="130499" style="left: 49.877884244200935%;"><div class="marker" style="width: 2px"><a href="/submerse" class="user-image-tiny" style="background-image: url(http://i1.soundcloud.com/avatars-000002343014-r7aotm-tiny.jpg?983cc9)">submerse</a></div></li>
<li class="timestamped-comment" data-sc-comment-timestamp="148108" style="left: 56.60820143939886%;"><div class="marker" style="width: 1px"><a href="/djdj-dj" class="user-image-tiny" style="background-image: url(http://i1.soundcloud.com/avatars-000002150790-x7u0pp-tiny.jpg?983cc9)">DJDJ   dj?</a></div></li>
<li class="timestamped-comment" data-sc-comment-timestamp="168477" style="left: 64.39341530441031%;"><div class="marker" style="width: 1px"><a href="/stickem" class="user-image-tiny" style="background-image: url(http://i1.soundcloud.com/avatars-000001739313-uuqfwk-tiny.jpg?983cc9)">Stickem</a></div></li></ol></div>
</div>
<script type="text/javascript">
window.SC.bufferTracks.push({"id":6909948,"uid":"zWhPWPNT8OBL","user":{"username":"Takuma.","permalink":"takuma-hosokawa"},"uri":"/takuma-hosokawa/wind-scene-skweee-remix","duration":261637,"token":"EqkKx","name":"wind-scene-skweee-remix","title":"\u30af\u30ed\u30ce\u30c8\u30ea\u30ac\u30fc \u98a8\u306e\u61a7\u61ac -Wind Scene - (Skweee Remix)","commentable":true,"revealComments":true,"commentUri":"/takuma-hosokawa/wind-scene-skweee-remix/comments/","streamUrl":"http://media.soundcloud.com/stream/zWhPWPNT8OBL?stream_token=EqkKx","waveformUrl":"http://waveforms.soundcloud.com/zWhPWPNT8OBL_m.png","propertiesUri":"/takuma-hosokawa/wind-scene-skweee-remix/properties/","statusUri":"/transcodings/zWhPWPNT8OBL","replacingUid":null,"preprocessingReady":true,"renderingFailed":false,"commentableByUser":true,"makeHeardUri":false,"favorite":false,"followingTrackOwner":false,"conversations":{"29097":[8557350],"43501":[10872022],"80313":[7455074],"130499":[6532501,6547838],"148108":[9044345],"168477":[6812804]}});
</script>
<script type="text/javascript">
window.SC.bufferComments = window.SC.bufferComments.concat([{"id":8557350,"uri":"/takuma-hosokawa/wind-scene-skweee-remix/comments/8557350/","avatar":"http://i1.soundcloud.com/avatars-000002661839-xqzujp-tiny.jpg?983cc9","name":"486 Sound System\u2122","userPermalink":"486","userUri":"/486","editable":false,"created_at":"2011/01/02 10:00:07 +0000","body":"\u003Cp\u003Efunky glitchz! \u003C/p\u003E","timestamp":29097,"track_id":6909948},{"id":10872022,"uri":"/takuma-hosokawa/wind-scene-skweee-remix/comments/10872022/","avatar":"http://i1.soundcloud.com/avatars-000002210301-ff72qm-tiny.jpg?983cc9","name":"ogopogo","userPermalink":"ogpg","userUri":"/ogpg","editable":false,"created_at":"2011/02/16 14:41:30 +0000","body":"\u003Cp\u003Eyeah skweeeeee! i really love this tune! \u30cb\u30b3\u52d5\u3067\u898b\u307e\u3057\u305f\uff01\u304b\u3063\u3053\u3044\u3044\uff01\u003C/p\u003E","timestamp":43501,"track_id":6909948},{"id":7455074,"uri":"/takuma-hosokawa/wind-scene-skweee-remix/comments/7455074/","avatar":"http://i1.soundcloud.com/avatars-000000915256-ucz04h-tiny.jpg?983cc9","name":"eLan","userPermalink":"itsmeelan","userUri":"/itsmeelan","editable":false,"created_at":"2010/12/05 06:43:16 +0000","body":"\u003Cp\u003Enuts\u003C/p\u003E","timestamp":80313,"track_id":6909948},{"id":6532501,"uri":"/takuma-hosokawa/wind-scene-skweee-remix/comments/6532501/","avatar":"http://i1.soundcloud.com/avatars-000002343014-r7aotm-tiny.jpg?983cc9","name":"submerse","userPermalink":"submerse","userUri":"/submerse","editable":false,"created_at":"2010/11/11 20:28:28 +0000","body":"\u003Cp\u003ECool!!! like this ^^\u003C/p\u003E","timestamp":130499,"track_id":6909948},{"id":6547838,"uri":"/takuma-hosokawa/wind-scene-skweee-remix/comments/6547838/","avatar":"http://i1.soundcloud.com/avatars-000001293320-oasacr-tiny.jpg?983cc9","name":"Takuma.","userPermalink":"takuma-hosokawa","userUri":"/takuma-hosokawa","editable":false,"created_at":"2010/11/12 05:57:10 +0000","body":"\u003Cp\u003E@\u003Ca href=\"http://soundcloud.com/submerse\" rel=\"nofollow\" target=\"_blank\"\u003Esubmerse\u003C/a\u003E:  thank you!! :)\u003C/p\u003E","timestamp":130499,"track_id":6909948},{"id":9044345,"uri":"/takuma-hosokawa/wind-scene-skweee-remix/comments/9044345/","avatar":"http://i1.soundcloud.com/avatars-000002150790-x7u0pp-tiny.jpg?983cc9","name":"DJDJ   dj?","userPermalink":"djdj-dj","userUri":"/djdj-dj","editable":false,"created_at":"2011/01/12 14:43:29 +0000","body":"\u003Cp\u003EFUCK'n cool\u003C/p\u003E","timestamp":148108,"track_id":6909948},{"id":6812804,"uri":"/takuma-hosokawa/wind-scene-skweee-remix/comments/6812804/","avatar":"http://i1.soundcloud.com/avatars-000001739313-uuqfwk-tiny.jpg?983cc9","name":"Stickem","userPermalink":"stickem","userUri":"/stickem","editable":false,"created_at":"2010/11/19 06:13:10 +0000","body":"\u003Cp\u003Ethis is dope!\u003C/p\u003E","timestamp":168477,"track_id":6909948}]);
</script></div>
</div>
<a href="/takuma-hosokawa/tracks" class="link-button  view-all right">View all</a></div>


</div>
<div id="secondary-content"><div id="secondary-content-inner"><div class="hidden" id="track-id">darksidenadeko-electro-mix</div>
<div class="info-body"><div class="tag-list"><strong>Tags:</strong>
<a href="/tags/anime"><span class="tag" title="Find more tracks tagged with 'anime'">anime</span></a>
<a href="/tags/remix"><span class="tag" title="Find more tracks tagged with 'remix'">remix</span></a>
<a href="/tags/electro-bakemonogtari"><span class="tag" title="Find more tracks tagged with 'electro bakemonogtari'">electro bakemonogtari</span></a>
<a href="/tags/renaicirculation"><span class="tag" title="Find more tracks tagged with 'renaicirculation'">renaicirculation</span></a></div>
<div class="description"><div id="track-description-value"><p>恋愛サーキュレーションのバンギンエレクトロリミックス！！</p></div></div></div>

<div class="track-comments"><div class="hidden"><div class="hidden" id="comments-list-headers"><h3 class="comment-count" id="comments"><abbr>
0
</abbr>
<dfn>
Comments
</dfn></h3>
<p class="comment-count-kinds"><span class="timed-count"><strong>
0
<span>timed comments</span>
</strong></span>
and
<span class="regular-count"><strong>
0
<span>regular comments</span>
</strong></span></p></div>
<ul class="" id="comments-list"><script type="text/javascript">
window.SC.bufferComments = window.SC.bufferComments.concat([]);
</script></ul></div>
<div class="new-comment-form"><h3 class="comment-add-header">Add a new comment</h3>
<div id="no-timestamp-comment-form"><div class="body">You need to be logged in to post a comment. If you're already a
member, please
<a href="/login?return_to=%2Ftakuma-hosokawa%2Fdarksidenadeko-electro-mix#comments" class="sign-in">log in</a>
or
<a href="/signup">sign up</a>
for a free account.</div></div></div></div>
</div></div></div>
<div id="footer"><div class="footer-col"><h4>Sign Up</h4>
<ul><li>Not on SoundCloud yet?
<a href="/signup">Sign up for free</a></li></ul></div>
<div class="footer-col"><h4>Explore</h4>
<ul><li><a href="/tracks">Tracks</a></li>
<li><a href="/creativecommons">Creative Commons</a></li>
<li><a href="/people">People</a></li>
<li><a href="/groups">Groups</a></li>
<li><a href="/apps">Apps</a></li>
<li><a href="/forums">Forums</a></li>
<li><a href="/pages/meetups">Meetups</a></li></ul></div>
<div class="footer-col"><h4>Premium</h4>
<ul><li><a href="/premium/">Feature Overview</a></li>
<li><a href="/premium/gifts">Buy a Gift</a></li>
<li><a class="icon-button" href="/premium/"><span class="go-pro">Premium</span></a></li></ul></div>
<div class="footer-col"><h4>Developers</h4>
<ul><li><a href="/developers">Getting Started</a></li>
<li><a href="/developers/case-studies">Case Studies</a></li>
<li><a href="/developers/connect">How To Connect</a></li>
<li><a href="/developers/policies">Policies</a></li>
<li><a href="http://github.com/soundcloud/api/wiki/">Documentation</a></li></ul></div>
<div class="footer-col"><h4>About Us</h4>
<ul><li><a href="http://blog.soundcloud.com">Blog</a></li>
<li><a href="/pages/contact">Contact Us</a></li>
<li><a href="/jobs">Jobs</a></li>
<li><a href="/press">Press</a></li></ul></div>
<div class="footer-col last"><h4>Help</h4>
<ul><li><a href="/tour">Take The Tour</a></li>
<li><a href="/101">SoundCloud 101</a></li>
<li><a href="/help">Help</a></li>
<li><a href="http://getsatisfaction.com/soundcloud">Help Forums</a></li>
<li><a href="/videos">Videos</a></li>
<li><a href="/help">Support</a></li></ul></div>
<div id="logo-footer"></div><p id="copyright">© 2007-2011 SoundCloud Ltd. All rights reserved.
<a href="/community-guidelines">Community Guidelines</a>
|
<a href="/terms-of-use">Terms of Use</a>
|
<a href="/pages/privacy">Privacy Policy</a>
|
<a href="/imprint">Imprint</a></p>
</div>
<div class="templates aural"><div id="blogger-form"><form accept-charset="utf-8" action="" enctype="multipart/form-data" method="post">
<label for="blogs-list">
Your blog
</label>
<select name="blogs-list"></select>
<label for="entry-title">
Title
</label>
<input class="title" id="entry-title" name="entry-title" type="text" />
<label for="entry-content">
Text
</label>
<textarea class="content" id="entry-content" name="entry-content"></textarea>
<label for="entry-tags">
Tags (separated by comma)
</label>
<input class="tags" id="entry-tags" name="entry-tags" type="text" value="SoundCloud" />
<div class="checkbox"><input id="entry-draft" name="entry-draft" type="checkbox" />
<label for="entry-draft">
Save as draft?
</label></div>
<div class="form-buttons"><input class="default" name="commit" type="submit" value="Post" /><a href="#" class="cancel" onclick="return false;" rel="nofollow">Cancel</a></div>
</form></div>

<div id="wordpress-form"><h2>Share to WordPress.com</h2>
<form><label for="short-code">
Grab the <strong>shortcode</strong> or
<a class="customize-link" href="#customize">customize your player</a>
</label>
<input class="content auto-select" id="short-code" name="short-code" />
<div class="expl">If you are using <strong>self-hosted WordPress</strong>, please use our standard embed code or install the
<a href="http://wordpress.org/extend/plugins/soundcloud-shortcode/">plugin</a>
to use shortcodes.</div></form></div>

<div id="timestamped-comment-template"><div class="content"><div class="header"><a class="close" href="#"></a>
<span class="new">Add a comment</span>
<span class="count">0 comments</span>
at
<span class="time">0.00</span></div>
<div class="replies"><ol></ol>
<div class="form-buttons"><input class="reply small" type="submit" value="Reply" /></div></div>
<div class="tooltip"><abbr>
Click to enter a
<br />
comment at
</abbr>
<span>0.00</span></div>
<div class="footer"></div></div>
<div class="arrow"></div></div>

<div id="report-track"><div id="report-track-wrapper"><h3>Report this track</h3>
<p>Is there a problem with this track? Is it a <strong>copyright infringement</strong>,
is it <strong>spam</strong> or are there problems with the <strong>sound quality</strong>?
Please let us know!</p>
<form action="/reports" id="new-report" method="post">
<label>
Select the sort of problem 
<span class="required">* required</span>
</label>
<div class="form-group"><select id="report_category" name="report[category]"><option value="Copyright infringement">Copyright infringement</option>
<option value="Sound quality">Sound quality</option>
<option value="Spam">Spam</option></select></div>
<div class="form-group"><label>
Short description of the problem 
<span class="required">* required</span>
</label>
<textarea cols="40" id="report_message" name="report[message]" rows="20"></textarea>
<small>Note: this message will be sent to SoundCloud staff, not to the user</small></div>
<div class="form-buttons"><input class="default" type="Submit" value="Report this track" /><a href="#cancel" class="cancel" onclick="return false;" rel="nofollow">Cancel</a></div>
</form></div></div>

<div class="ad-appstores" id="ad-iphone"><div><a href="http://itunes.apple.com/us/app/soundcloud/id336353151?mt=8" target="itunes_store"><img id="launch-appstore" src="../images/iphone/appstore_high_dpi_2.png" /></a>
<p class="hide-this">Hide this</p></div></div>

<div class="ad-appstores" id="ad-android"><div><a href="market://details?id=com.soundcloud.android"><img id="launch-appstore" src="../images/android/appstore_480x800.png" /></a>
<p class="hide-this">Hide this</p></div></div>

<div class="aural"><div id="unlock-form"><div class="site-login-form-wrapper"><h2>Log In
<a href="/signup">Not a member yet? Sign up here.</a></h2>
<form accept-charset="utf-8" action="https://soundcloud.com/session" id="zoom-login-form" method="post">
<label for="zoom-site-username">Your email address</label>
<input id="login_submitted_via" name="login_submitted_via" type="hidden" value="zoom" />
<input class="title auto-select" id="zoom-site-username" name="username" tabindex="1" type="text" />
<label for="zoom-site-password">Password</label>
<input class="title auto-select" id="zoom-site-password" name="password" tabindex="2" type="password" />
<div class="remember"><div class="checkbox"><input id="zoom-site-remember-me" name="remember_me" tabindex="3" type="checkbox" />
<label for="zoom-site-remember-me">Remember me</label></div></div>
<div class="form-buttons"><input class="default" id="zoom-log-in-submit-button" name="commit" tabindex="4" type="submit" value="Log in" /><a href="#" class="cancel" onclick="return false;" rel="nofollow">Cancel</a></div>
</form>
<div class="forgot-password"><div class="forgot-password-container hidden"><form accept-charset="utf-8" action="http://soundcloud.com/login/forgot" id="forgot-password-form" method="post">
<p>Enter your <strong>email address</strong> and we'll <strong>send you a link</strong> that'll allow you to <strong>change your password</strong>. Problems? Contact <a href="/pages/support">support</a>.</p>
<div><label for="email">Your email address</label>
<input class="title auto-focus" id="email" name="email" type="text" />
<div class="form-buttons"><input class="default" name="commit" type="submit" value="Submit" /></div></div>
</form>
</div><a href="/login/forgot" class="forgot-link" tabindex="5">Forgot password?</a></div></div></div></div></div>
<script src="http://a1.soundcloud.com/javascripts/base.js?983cc9" type="text/javascript"></script>

<script type="text/javascript">
var _gaq = _gaq || [];
$.helpers.loadScriptAsync('http://www.google-analytics.com/ga.js', 'https://ssl.google-analytics.com/ga.js');
$.helpers.loadScriptAsync('http://www.google.com/jsapi', 'https://www.google.com/jsapi');
</script>
<script type="text/javascript">
_qoptions = {qacct: "p-47_zcqmJsLHXQ"};
$.helpers.loadScriptAsync('http://edge.quantserve.com/quant.js', 'https://quantserve.com/quant.js', true);
</script>
<noscript>
<img alt="Quantcast" class="hidden" src="http://pixel.quantserve.com/pixel/p-47_zcqmJsLHXQ.gif" />
</noscript>


</body></html>

@@ GET http://soundcloud.com/inu/virgins-high-crabmixx2-221210
HTTP/1.1 200 OK
Cache-Control: private, max-age=0, must-revalidate
Connection: close
Date: Sat, 19 Feb 2011 08:37:16 GMT
Via: 1.1 varnish
Age: 0
ETag: "64b92b60806017b262230cd08ec48c38"
Server: nginx
Vary: Accept-Encoding
Content-Length: 31860
Content-Type: text/html; charset=utf-8

<!DOCTYPE html>
<html lang="en" xml:lang="en" xmlns="http://www.w3.org/1999/xhtml"><head><meta charset="utf-8" />
<title>virgin's high! (crabMixx2) 221210 by inu on SoundCloud - Create, record and share your sounds for free</title>
<meta content="record, sounds, share, sound, audio, tracks, music, soundcloud" name="keywords" />
<meta content="Listen to virgin's high! (crabMixx2) 221210 by inu: MELL - virgin's high! (crabMixx2)&#x000A;スカイガールズ&#x000A;後半テンポ落ちます [177-88.5bpm] | Create, record and share the sounds you create anywhere to friends, family and the world with SoundCloud, the world's largest community of sound creators." name="description" />

<meta content="width=device-width" name="viewport" />
<meta content="chrome=1" name="X-UA-Compatible" />
<meta content="19507961798" property="fb:app_id" />
<meta content="SoundCloud" property="og:site_name" />
<meta content="virgin's high! (crabMixx2) 221210 by inu on SoundCloud" property="og:title" />
<meta content="http://i1.soundcloud.com/artworks-000004842103-wukwox-t300x300.jpg?c1f0ed" property="og:image" />
<meta content="Click to listen to this sound by inu: MELL - virgin's high! (crabMixx2)&#x000A;スカイガールズ&#x000A;後半テンポ落ちます [177-88.5bpm] | Shared via SoundCloud" property="og:description" />
<meta content="video" name="medium" />
<meta content="98" property="og:video:height" />
<meta content="460" property="og:video:width" />
<meta content="application/x-shockwave-flash" property="og:video:type" />
<meta content="http://player.soundcloud.com/player.swf?url=http%3A%2F%2Fsoundcloud.com%2Finu%2Fvirgins-high-crabmixx2-221210&amp;color=3b5998&amp;auto_play=true&amp;show_artwork=false" property="og:video" />
<link href="http://soundcloud.com/oembed?url=http%3A%2F%2Fsoundcloud.com%2Finu%2Fvirgins-high-crabmixx2-221210&amp;format=xml" rel="alternate" type="text/xml+oembed" />
<link href="http://soundcloud.com/oembed?url=http%3A%2F%2Fsoundcloud.com%2Finu%2Fvirgins-high-crabmixx2-221210&amp;format=json" rel="alternate" type="application/json+oembed" />

<!--[if IE]>
<script src="http://a1.soundcloud.com/javascripts/plugins/vendor/excanvas-compressed.js?c1f0ed" type="text/javascript"></script>
<![endif]-->
<!--[if IE 8]>
<script type="text/javascript">
document.getElementsByTagName("html")[0].className = "ie8";
</script>
<![endif]-->
<!--[if IE 7]>
<script type="text/javascript">
document.getElementsByTagName("html")[0].className = "ie7";
</script>
<![endif]-->
<!--[if lte IE 7]>
<meta content="true" name="MSSmartTagsPreventParsing" />
<meta content="false" http-equiv="imagetoolbar" />
<![endif]-->
<script type="text/javascript">
window.SC = {"bufferTracks":[],"bufferComments":[],"cookieDomain":"soundcloud.com","assetPath":"a1.soundcloud.com","assetPathSSL":"soundcloud.com","facebook":{"appKey":"61261ce0407b2ccb568641b513098e18","xdReceiver":"/connect/xd_receiver.htm"},"gaID":"UA-2519404-1"};
</script>
<link href="http://a1.soundcloud.com/stylesheets/general.css?c1f0ed" media="all" rel="stylesheet" type="text/css" />
<link href="http://a1.soundcloud.com/stylesheets/special.css?c1f0ed" media="all" rel="stylesheet" type="text/css" />
<link href="/sc-opensearch.xml" rel="search" title="SoundCloud Search" type="application/opensearchdescription+xml" />

<link href="http://a1.soundcloud.com/images/apple-touch-icon.png?c1f0ed" rel="apple-touch-icon" />
<link href="http://a1.soundcloud.com/favicon.ico?c1f0ed" rel="shortcut icon" />
<link href="http://a1.soundcloud.com/images/soundcloud_fluid.png?c1f0ed" rel="fluid-icon" />
</head>
<body class="show restricted full-music" id="tracks"><div id="header"><div id="header-top"><div id="sc-info"><a href="/apps?ref=top">App Gallery</a>
|
<a href="/help">Get help</a>
|
<a href="/premium?ref=top">Plans</a>
|
<a href="http://blog.soundcloud.com/tag/feature/">What's new?</a></div>
<div id="user-status"><a class="logged-out" href="/" id="logo">Soundcloud</a>
<a href="/login?ref=top" class="sign-in" id="login-link">Log In</a>
|
<a href="/signup?ref=top">Sign Up</a></div></div>
<div id="header-lower"><ul id="main-nav"><li class="nav no-submenu" id="menu-button-home"><a href="/">Home</a>
<div class="open-submenu"></div></li>
<li class="nav no-submenu" id="menu-button-tour"><a href="/tour/">The Tour</a>
<div class="open-submenu"></div></li>
<li class="nav no-submenu" id="menu-button-signup"><a href="/signup">Sign Up</a>
<div class="open-submenu"></div></li>
<li id="menu-button-upload"><a href="/upload" class="link-button">Upload &amp; Share</a></li></ul>

<div id="volume"><a class="volume-control-button level0" title="Set the volume">Volume</a>
<div class="aural" id="volume-control"><a class="volume-control-button level0">Volume</a>
<div id="volume-control-wrapper"><a class="volume-plus">+</a>
<div id="volume-control-handle"></div>
<div id="volume-control-scale"></div>
<a class="volume-minus"></a></div></div></div>
<div id="search"><form action="/search" method="get">
<input accesskey="f" autocomplete="off" class="blurred" id="header-search" name="q[fulltext]" placeholder="Search SoundCloud" type="text" value="Search SoundCloud" />
<div class="search-selector" title="Select what you want to search for"></div>
<ul class="pulldown hidden search-select"><li><a href="/tracks/search">Tracks</a></li>
<li><a href="/people/search">Users</a></li>
<li><a href="/groups/search">Groups</a></li></ul>
</form></div></div></div>

<div id="main-wrapper"><div id="main-content"><div id="main-content-inner">
<div class="player mode large haudio  " data-sc-track="10536048"><div class="info-header large"><div class="meta-data"><div class="key-bpm"><span class="bpm-value-show">177.0</span>
<span class="bpm">BPM</span>
<span class="track-type">Remix</span></div></div>
<a class="artwork" href="#zoomed-artwork" style="background:url(http://i1.soundcloud.com/artworks-000004842103-wukwox-large.jpg?c1f0ed)">Track artwork</a>
<div class="aural"><div id="zoomed-artwork"><img alt="Track artwork" src="http://i1.soundcloud.com/artworks-000004842103-wukwox-crop.jpg?c1f0ed" />
<div class="artwork-download-link"><a href="http://i1.soundcloud.com/artworks-000004842103-wukwox-original.jpg?c1f0ed" target="SC_artwork">Download artwork</a></div></div></div>
<h1 class="with-artwork"><em>
virgin's high! (crabMixx2) 221210
</em></h1>
<h2>Uploaded by
<span class="user tiny online"><a href="/inu" class="user-name">inu</a>&#x000A;<span class="user-status"><span class="user-online" title="Online now"></span>
<span class="contact add-contact"><a class="contact-link update"><span>Start following</span></a></span></span></span>


<abbr title='February, 14 2011 11:26:12 +0000' class='pretty-date'>on February 14, 2011 11:26</abbr></h2></div>
<div class="actionbar"><a href="/tags/anime"><span class="genre" title="Find more Anime tracks">Anime</span></a><div class="actions"><div class="primary"><a href="#share" class="share pl-button" onclick="return false;" rel="nofollow" title="Share this on other networks"><span>Share</span></a>
<div class="share-code hidden action-overlay"><div class="action-overlay-inner"><a href="/inu/virgins-high-crabmixx2-221210/share-options" class="lazy initial" onclick="return false;" rel="nofollow">Loading sharing options</a></div></div>

<a href="/you/favorites/inu/virgins-high-crabmixx2-221210" class="pl-button favorite create" onclick="return false;" rel="nofollow"><span>Save to Favorites</span></a>
<a href="/inu/virgins-high-crabmixx2-221210/download" class="download pl-button" title="The file you're about to download has a size of 30.34 MB"><span>Download</span></a></div>
<div class="secondary"><a href="/reports?track=virgins-high-crabmixx2-221210&amp;user=inu" class="report-this-track pl-button" onclick="return false;" rel="nofollow" title="Report this track"><span>Report this track</span></a></div>
<div class="hidden download-options action-overlay" data-sc-track="10536048"><div class="action-overlay-inner"><a href="/inu/virgins-high-crabmixx2-221210/download" class="icon-button download"><span>Download</span></a>
<span class="file-type">aiff</span>
<span class="content-size">30.34 MB</span></div></div></div></div>

<div class="container"><div class="controls"><a href="#play" class="play" onclick="return false;" rel="nofollow">Play</a>
<div class="timecodes"><span class="editable">0.00</span>
/
<span class="duration" title="PT259">2.59</span></div></div>
<div class="display"><div class="progress"></div>
<img class="waveform" src="http://waveforms.soundcloud.com/AV1qKt2x5J5H_m.png" unselectable="on" />
<img class="waveform-overlay" src="http://a1.soundcloud.com/images/player-overlay.png?c1f0ed" unselectable="on" />
<div class="playhead aural"></div>
<div class="seekhead hidden"><div><span></span></div></div>
<ol class="timestamped-comments "><li class="aural template timestamped-comment"><div class="marker" style="width: 1px"></div></li>
<li class="timestamped-comment" data-sc-comment-timestamp="145219" style="left: 80.91231745571856%;"><div class="marker" style="width: 1px"><a href="/3nen2kumi" class="user-image-tiny" style="background-image: url(http://i1.soundcloud.com/avatars-000002502075-t8jgst-tiny.jpg?c1f0ed)">3nen2kumi</a></div></li></ol></div>
<a class="comments-toggle" href="#no-comments" title="Hide the comments">Hide the comments</a>
</div>

<script type="text/javascript">
window.SC.bufferTracks.push({"id":10536048,"uid":"AV1qKt2x5J5H","user":{"username":"inu","permalink":"inu"},"uri":"/inu/virgins-high-crabmixx2-221210","duration":179477,"token":"eSbkh","name":"virgins-high-crabmixx2-221210","title":"virgin's high! (crabMixx2) 221210","commentable":true,"revealComments":true,"commentUri":"/inu/virgins-high-crabmixx2-221210/comments/","streamUrl":"http://media.soundcloud.com/stream/AV1qKt2x5J5H?stream_token=eSbkh","waveformUrl":"http://waveforms.soundcloud.com/AV1qKt2x5J5H_m.png","propertiesUri":"/inu/virgins-high-crabmixx2-221210/properties/","statusUri":"/transcodings/AV1qKt2x5J5H","replacingUid":null,"preprocessingReady":true,"renderingFailed":false,"commentableByUser":true,"makeHeardUri":false,"favorite":false,"followingTrackOwner":false,"conversations":{"145219":[10868618]}});
</script>
<script type="text/javascript">
window.SC.bufferComments = window.SC.bufferComments.concat([{"id":10868618,"uri":"/inu/virgins-high-crabmixx2-221210/comments/10868618/","avatar":"http://i1.soundcloud.com/avatars-000002502075-t8jgst-tiny.jpg?c1f0ed","name":"3nen2kumi","userPermalink":"3nen2kumi","userUri":"/3nen2kumi","editable":false,"created_at":"2011/02/16 13:13:23 +0000","body":"\u003Cp\u003E\u3053\u306e\u3078\u3093\u597d\u304d\u003C/p\u003E","timestamp":145219,"track_id":10536048}]);
</script></div>

</div></div>
<div id="side-content">
<div class="context-item context-box"><div class="mini-update"><h3>Stats for this track</h3>
<table><tr><th></th>
<th class="week">This Week</th>
<th class="total">Total</th></tr><tr class="even"><td class="plays">Plays</td>
<td class="week" data-sc-week-plays="326">326</td>
<td class="total" data-sc-total-plays="326">326</td></tr>
<tr class="odd"><td class="comments">Comments</td>
<td class="week" data-sc-week-comments="1">1</td>
<td class="total" data-sc-total-comments="1">1</td></tr>
<tr class="even"><td class="favoritings">Favoritings</td>
<td class="week" data-sc-week-favoritings="5">5</td>
<td class="total" data-sc-total-favoritings="5">5</td></tr>
<tr class="odd"><td class="downloads">Downloads</td>
<td class="week" data-sc-week-downloads="202">202</td>
<td class="total" data-sc-total-downloads="202">202</td></tr>
</table></div></div>

<div class="context-item"><h3>Uploaded by</h3>
<ul class="user-list-small"><li class="user small" id="user-small-545815"><a href="/inu" class="user-image-badge" style="background-image: url(http://i1.soundcloud.com/avatars-000001116597-n5grk8-badge.jpg?c1f0ed)">inu</a>
<span class="user-info"><a href="/inu" class="user-link">inu</a>
<span class="user-status"><a class="pro-lite" href="/premium/"></a>
<span class="contact add-contact"><a class="contact-link update"><span>Start following</span></a></span>

<a href="/messages/new?to=545815" class="send-message" title="Send a message"></a></span>
<span class="user-realname">史 三好</span>
<div class="public-songs-info">62 public tracks</div></span></li>
</ul></div>
<div class="context-item"><h3>More tracks by
 inu</h3>
<div class="tracks-small"><div class="small player haudio mode" data-sc-track="10772644"><h3><a href="/inu/sentimental-230217">センチメンタル (crabMixx) 230217</a></h3>
<div class="container"><div class="controls"><a href="#play" class="play" onclick="return false">Play</a></div><div class="display"><div class="progress"></div>
<img class="waveform" src="http://waveforms.soundcloud.com/SSczlPwEC89J_m.png" unselectable="on" />
<img class="waveform-overlay" src="http://a1.soundcloud.com/images/player-overlay.png?c1f0ed" unselectable="on" />
<div class="playhead aural"></div>
<div class="seekhead hidden"><div><span></span></div></div>
<ol class="timestamped-comments "><li class="aural template timestamped-comment"><div class="marker" style="width: 1px"><a href="/gerge" class="user-image-tiny" style="background-image: url(http://i1.soundcloud.com/avatars-000002662448-exersv-tiny.jpg?c1f0ed)">slaill / gerge</a></div></li></ol></div>
</div>
<script type="text/javascript">
window.SC.bufferTracks.push({"id":10772644,"uid":"SSczlPwEC89J","user":{"username":"inu","permalink":"inu"},"uri":"/inu/sentimental-230217","duration":181358,"token":"uaCcv","name":"sentimental-230217","title":"\u30bb\u30f3\u30c1\u30e1\u30f3\u30bf\u30eb (crabMixx) 230217","commentable":true,"revealComments":true,"commentUri":"/inu/sentimental-230217/comments/","streamUrl":"http://media.soundcloud.com/stream/SSczlPwEC89J?stream_token=uaCcv","waveformUrl":"http://waveforms.soundcloud.com/SSczlPwEC89J_m.png","propertiesUri":"/inu/sentimental-230217/properties/","statusUri":"/transcodings/SSczlPwEC89J","replacingUid":null,"preprocessingReady":true,"renderingFailed":false,"commentableByUser":true,"makeHeardUri":false,"favorite":false,"followingTrackOwner":false,"conversations":{}});
</script>
<script type="text/javascript">
window.SC.bufferComments = window.SC.bufferComments.concat([]);
</script></div>
<div class="small player haudio mode" data-sc-track="10539555"><h3><a href="/inu/yamibou-220824">瞳の中の迷宮 (crabMixx) 220824</a></h3>
<div class="container"><div class="controls"><a href="#play" class="play" onclick="return false">Play</a></div><div class="display"><div class="progress"></div>
<img class="waveform" src="http://waveforms.soundcloud.com/PJEUeZVTPEbL_m.png" unselectable="on" />
<img class="waveform-overlay" src="http://a1.soundcloud.com/images/player-overlay.png?c1f0ed" unselectable="on" />
<div class="playhead aural"></div>
<div class="seekhead hidden"><div><span></span></div></div>
<ol class="timestamped-comments "><li class="aural template timestamped-comment"><div class="marker" style="width: 1px"></div></li></ol></div>
</div>
<script type="text/javascript">
window.SC.bufferTracks.push({"id":10539555,"uid":"PJEUeZVTPEbL","user":{"username":"inu","permalink":"inu"},"uri":"/inu/yamibou-220824","duration":227612,"token":"LXau0","name":"yamibou-220824","title":"\u77b3\u306e\u4e2d\u306e\u8ff7\u5bae (crabMixx) 220824","commentable":true,"revealComments":true,"commentUri":"/inu/yamibou-220824/comments/","streamUrl":"http://media.soundcloud.com/stream/PJEUeZVTPEbL?stream_token=LXau0","waveformUrl":"http://waveforms.soundcloud.com/PJEUeZVTPEbL_m.png","propertiesUri":"/inu/yamibou-220824/properties/","statusUri":"/transcodings/PJEUeZVTPEbL","replacingUid":null,"preprocessingReady":true,"renderingFailed":false,"commentableByUser":true,"makeHeardUri":false,"favorite":false,"followingTrackOwner":false,"conversations":{}});
</script>
<script type="text/javascript">
window.SC.bufferComments = window.SC.bufferComments.concat([]);
</script></div>
<div class="small player haudio mode" data-sc-track="10537454"><h3><a href="/inu/happy-birthday-crabmixx-220827">Happy Birthday (crabMixx) 220827</a></h3>
<div class="container"><div class="controls"><a href="#play" class="play" onclick="return false">Play</a></div><div class="display"><div class="progress"></div>
<img class="waveform" src="http://waveforms.soundcloud.com/As79ZwEJzqMj_m.png" unselectable="on" />
<img class="waveform-overlay" src="http://a1.soundcloud.com/images/player-overlay.png?c1f0ed" unselectable="on" />
<div class="playhead aural"></div>
<div class="seekhead hidden"><div><span></span></div></div>
<ol class="timestamped-comments "><li class="aural template timestamped-comment"><div class="marker" style="width: 1px"></div></li></ol></div>
</div>
<script type="text/javascript">
window.SC.bufferTracks.push({"id":10537454,"uid":"As79ZwEJzqMj","user":{"username":"inu","permalink":"inu"},"uri":"/inu/happy-birthday-crabmixx-220827","duration":208667,"token":"Ps692","name":"happy-birthday-crabmixx-220827","title":"Happy Birthday (crabMixx) 220827","commentable":true,"revealComments":true,"commentUri":"/inu/happy-birthday-crabmixx-220827/comments/","streamUrl":"http://media.soundcloud.com/stream/As79ZwEJzqMj?stream_token=Ps692","waveformUrl":"http://waveforms.soundcloud.com/As79ZwEJzqMj_m.png","propertiesUri":"/inu/happy-birthday-crabmixx-220827/properties/","statusUri":"/transcodings/As79ZwEJzqMj","replacingUid":null,"preprocessingReady":true,"renderingFailed":false,"commentableByUser":true,"makeHeardUri":false,"favorite":false,"followingTrackOwner":false,"conversations":{}});
</script>
<script type="text/javascript">
window.SC.bufferComments = window.SC.bufferComments.concat([]);
</script></div>
<div class="small player haudio mode" data-sc-track="10536750"><h3><a href="/inu/fate-staynight-kirameku-230203">きらめく涙は星に (crabMixx) 230203</a></h3>
<div class="container"><div class="controls"><a href="#play" class="play" onclick="return false">Play</a></div><div class="display"><div class="progress"></div>
<img class="waveform" src="http://waveforms.soundcloud.com/W7zJpHIfgxP5_m.png" unselectable="on" />
<img class="waveform-overlay" src="http://a1.soundcloud.com/images/player-overlay.png?c1f0ed" unselectable="on" />
<div class="playhead aural"></div>
<div class="seekhead hidden"><div><span></span></div></div>
<ol class="timestamped-comments "><li class="aural template timestamped-comment"><div class="marker" style="width: 1px"></div></li></ol></div>
</div>
<script type="text/javascript">
window.SC.bufferTracks.push({"id":10536750,"uid":"W7zJpHIfgxP5","user":{"username":"inu","permalink":"inu"},"uri":"/inu/fate-staynight-kirameku-230203","duration":202943,"token":"bkFJF","name":"fate-staynight-kirameku-230203","title":"\u304d\u3089\u3081\u304f\u6d99\u306f\u661f\u306b (crabMixx) 230203","commentable":true,"revealComments":true,"commentUri":"/inu/fate-staynight-kirameku-230203/comments/","streamUrl":"http://media.soundcloud.com/stream/W7zJpHIfgxP5?stream_token=bkFJF","waveformUrl":"http://waveforms.soundcloud.com/W7zJpHIfgxP5_m.png","propertiesUri":"/inu/fate-staynight-kirameku-230203/properties/","statusUri":"/transcodings/W7zJpHIfgxP5","replacingUid":null,"preprocessingReady":true,"renderingFailed":false,"commentableByUser":true,"makeHeardUri":false,"favorite":false,"followingTrackOwner":false,"conversations":{}});
</script>
<script type="text/javascript">
window.SC.bufferComments = window.SC.bufferComments.concat([]);
</script></div>
<div class="small player haudio mode" data-sc-track="10535289"><h3><a href="/inu/hit-in-the-usa-crabmixx-230209">HIT IN THE USA (crabMixx) 230209</a></h3>
<div class="container"><div class="controls"><a href="#play" class="play" onclick="return false">Play</a></div><div class="display"><div class="progress"></div>
<img class="waveform" src="http://waveforms.soundcloud.com/BvDVO7KaFcZa_m.png" unselectable="on" />
<img class="waveform-overlay" src="http://a1.soundcloud.com/images/player-overlay.png?c1f0ed" unselectable="on" />
<div class="playhead aural"></div>
<div class="seekhead hidden"><div><span></span></div></div>
<ol class="timestamped-comments "><li class="aural template timestamped-comment"><div class="marker" style="width: 1px"></div></li></ol></div>
</div>
<script type="text/javascript">
window.SC.bufferTracks.push({"id":10535289,"uid":"BvDVO7KaFcZa","user":{"username":"inu","permalink":"inu"},"uri":"/inu/hit-in-the-usa-crabmixx-230209","duration":176968,"token":"gQDWm","name":"hit-in-the-usa-crabmixx-230209","title":"HIT IN THE USA (crabMixx) 230209","commentable":true,"revealComments":true,"commentUri":"/inu/hit-in-the-usa-crabmixx-230209/comments/","streamUrl":"http://media.soundcloud.com/stream/BvDVO7KaFcZa?stream_token=gQDWm","waveformUrl":"http://waveforms.soundcloud.com/BvDVO7KaFcZa_m.png","propertiesUri":"/inu/hit-in-the-usa-crabmixx-230209/properties/","statusUri":"/transcodings/BvDVO7KaFcZa","replacingUid":null,"preprocessingReady":true,"renderingFailed":false,"commentableByUser":true,"makeHeardUri":false,"favorite":false,"followingTrackOwner":false,"conversations":{}});
</script>
<script type="text/javascript">
window.SC.bufferComments = window.SC.bufferComments.concat([]);
</script></div>
</div>
<a href="/inu/tracks" class="link-button  view-all right">View all</a></div>


</div>
<div id="secondary-content"><div id="secondary-content-inner"><div class="hidden" id="track-id">virgins-high-crabmixx2-221210</div>
<div class="info-body"><div class="description"><div id="track-description-value"><p>MELL - virgin's high! (crabMixx2)
<br>スカイガールズ
<br>後半テンポ落ちます [177-88.5bpm]</p></div></div></div>

<div class="track-comments"><div><div id="comments-list-headers"><h3 class="comment-count" id="comments"><abbr>
1
</abbr>
<dfn>
Comment
</dfn></h3>
<p class="comment-count-kinds"><span class="timed-count"><strong>
1
<span>timed comment</span>
</strong></span>
and
<span class="regular-count"><strong>
0
<span>regular comments</span>
</strong></span></p></div>
<ul class="" id="comments-list"><li class="comment" data-sc-comment-id="10868618" id="comment-10868618"><a href="/3nen2kumi" class="user-image-badge" style="background-image: url(http://i1.soundcloud.com/avatars-000002502075-t8jgst-badge.jpg?c1f0ed)">3nen2kumi</a>
<div class="comment-inner"><span class="user tiny"><a href="/3nen2kumi" class="user-name">3nen2kumi</a>
<span class="user-status"><span class="contact add-contact"><a class="contact-link update"><span>Start following</span></a></span></span></span>

<span class="time">at
2.25</span>
<a class="go-to-comment" href="/inu/virgins-high-crabmixx2-221210/comment-10868618" rel="bookmark nofollow"><abbr title='February, 16 2011 13:13:23 +0000' class='pretty-date'>on February 16, 2011 13:13</abbr></a>
<div class="comment-body"><p>このへん好き</p></div>
<div class="action-buttons"><div class="action-buttons-inner"><a href="/inu/virgins-high-crabmixx2-221210/comment-10868618" class="go-to-comment button" data-sc-comment-id="10868618" rel="nofollow">Show in player</a> <a href="/inu/virgins-high-crabmixx2-221210/comment-10868618?fragment=reply" class="reply comment last" data-sc-comment-id="10868618" rel="nofollow">Reply</a></div></div></div></li>
<script type="text/javascript">
window.SC.bufferComments = window.SC.bufferComments.concat([]);
</script></ul></div>
<div class="new-comment-form"><h3 class="comment-add-header">Add a new comment</h3>
<div id="no-timestamp-comment-form"><div class="body">You need to be logged in to post a comment. If you're already a
member, please
<a href="/login?return_to=%2Finu%2Fvirgins-high-crabmixx2-221210#comments" class="sign-in">log in</a>
or
<a href="/signup">sign up</a>
for a free account.</div></div></div></div>
</div></div></div>
<div id="footer"><div class="footer-col"><h4>Sign Up</h4>
<ul><li>Not on SoundCloud yet?
<a href="/signup">Sign up for free</a></li></ul></div>
<div class="footer-col"><h4>Explore</h4>
<ul><li><a href="/tracks">Tracks</a></li>
<li><a href="/creativecommons">Creative Commons</a></li>
<li><a href="/people">People</a></li>
<li><a href="/groups">Groups</a></li>
<li><a href="/apps">Apps</a></li>
<li><a href="/forums">Forums</a></li>
<li><a href="/pages/meetups">Meetups</a></li></ul></div>
<div class="footer-col"><h4>Premium</h4>
<ul><li><a href="/premium/">Feature Overview</a></li>
<li><a href="/premium/gifts">Buy a Gift</a></li>
<li><a class="icon-button" href="/premium/"><span class="go-pro">Premium</span></a></li></ul></div>
<div class="footer-col"><h4>Developers</h4>
<ul><li><a href="/developers">Getting Started</a></li>
<li><a href="/developers/case-studies">Case Studies</a></li>
<li><a href="/developers/connect">How To Connect</a></li>
<li><a href="/developers/policies">Policies</a></li>
<li><a href="http://github.com/soundcloud/api/wiki/">Documentation</a></li></ul></div>
<div class="footer-col"><h4>About Us</h4>
<ul><li><a href="http://blog.soundcloud.com">Blog</a></li>
<li><a href="/pages/contact">Contact Us</a></li>
<li><a href="/jobs">Jobs</a></li>
<li><a href="/press">Press</a></li></ul></div>
<div class="footer-col last"><h4>Help</h4>
<ul><li><a href="/tour">Take The Tour</a></li>
<li><a href="/101">SoundCloud 101</a></li>
<li><a href="/help">Help</a></li>
<li><a href="http://getsatisfaction.com/soundcloud">Help Forums</a></li>
<li><a href="/videos">Videos</a></li>
<li><a href="/help">Support</a></li></ul></div>
<div id="logo-footer"></div><p id="copyright">© 2007-2011 SoundCloud Ltd. All rights reserved.
<a href="/community-guidelines">Community Guidelines</a>
|
<a href="/terms-of-use">Terms of Use</a>
|
<a href="/pages/privacy">Privacy Policy</a>
|
<a href="/imprint">Imprint</a></p>
</div>
<div class="templates aural"><div id="blogger-form"><form accept-charset="utf-8" action="" enctype="multipart/form-data" method="post">
<label for="blogs-list">
Your blog
</label>
<select name="blogs-list"></select>
<label for="entry-title">
Title
</label>
<input class="title" id="entry-title" name="entry-title" type="text" />
<label for="entry-content">
Text
</label>
<textarea class="content" id="entry-content" name="entry-content"></textarea>
<label for="entry-tags">
Tags (separated by comma)
</label>
<input class="tags" id="entry-tags" name="entry-tags" type="text" value="SoundCloud" />
<div class="checkbox"><input id="entry-draft" name="entry-draft" type="checkbox" />
<label for="entry-draft">
Save as draft?
</label></div>
<div class="form-buttons"><input class="default" name="commit" type="submit" value="Post" /><a href="#" class="cancel" onclick="return false;" rel="nofollow">Cancel</a></div>
</form></div>

<div id="wordpress-form"><h2>Share to WordPress.com</h2>
<form><label for="short-code">
Grab the <strong>shortcode</strong> or
<a class="customize-link" href="#customize">customize your player</a>
</label>
<input class="content auto-select" id="short-code" name="short-code" />
<div class="expl">If you are using <strong>self-hosted WordPress</strong>, please use our standard embed code or install the
<a href="http://wordpress.org/extend/plugins/soundcloud-shortcode/">plugin</a>
to use shortcodes.</div></form></div>

<div id="timestamped-comment-template"><div class="content"><div class="header"><a class="close" href="#"></a>
<span class="new">Add a comment</span>
<span class="count">0 comments</span>
at
<span class="time">0.00</span></div>
<div class="replies"><ol></ol>
<div class="form-buttons"><input class="reply small" type="submit" value="Reply" /></div></div>
<div class="tooltip"><abbr>
Click to enter a
<br />
comment at
</abbr>
<span>0.00</span></div>
<div class="footer"></div></div>
<div class="arrow"></div></div>

<div id="report-track"><div id="report-track-wrapper"><h3>Report this track</h3>
<p>Is there a problem with this track? Is it a <strong>copyright infringement</strong>,
is it <strong>spam</strong> or are there problems with the <strong>sound quality</strong>?
Please let us know!</p>
<form action="/reports" id="new-report" method="post">
<label>
Select the sort of problem 
<span class="required">* required</span>
</label>
<div class="form-group"><select id="report_category" name="report[category]"><option value="Copyright infringement">Copyright infringement</option>
<option value="Sound quality">Sound quality</option>
<option value="Spam">Spam</option></select></div>
<div class="form-group"><label>
Short description of the problem 
<span class="required">* required</span>
</label>
<textarea cols="40" id="report_message" name="report[message]" rows="20"></textarea>
<small>Note: this message will be sent to SoundCloud staff, not to the user</small></div>
<div class="form-buttons"><input class="default" type="Submit" value="Report this track" /><a href="#cancel" class="cancel" onclick="return false;" rel="nofollow">Cancel</a></div>
</form></div></div>

<div class="ad-appstores" id="ad-iphone"><div><a href="http://itunes.apple.com/us/app/soundcloud/id336353151?mt=8" target="itunes_store"><img id="launch-appstore" src="../images/iphone/appstore_high_dpi_2.png" /></a>
<p class="hide-this">Hide this</p></div></div>

<div class="ad-appstores" id="ad-android"><div><a href="market://details?id=com.soundcloud.android"><img id="launch-appstore" src="../images/android/appstore_480x800.png" /></a>
<p class="hide-this">Hide this</p></div></div>

<div class="aural"><div id="unlock-form"><div class="site-login-form-wrapper"><h2>Log In
<a href="/signup">Not a member yet? Sign up here.</a></h2>
<form accept-charset="utf-8" action="https://soundcloud.com/session" id="zoom-login-form" method="post">
<label for="zoom-site-username">Your email address</label>
<input id="login_submitted_via" name="login_submitted_via" type="hidden" value="zoom" />
<input class="title auto-select" id="zoom-site-username" name="username" tabindex="1" type="text" />
<label for="zoom-site-password">Password</label>
<input class="title auto-select" id="zoom-site-password" name="password" tabindex="2" type="password" />
<div class="remember"><div class="checkbox"><input id="zoom-site-remember-me" name="remember_me" tabindex="3" type="checkbox" />
<label for="zoom-site-remember-me">Remember me</label></div></div>
<div class="form-buttons"><input class="default" id="zoom-log-in-submit-button" name="commit" tabindex="4" type="submit" value="Log in" /><a href="#" class="cancel" onclick="return false;" rel="nofollow">Cancel</a></div>
</form>
<div class="forgot-password"><div class="forgot-password-container hidden"><form accept-charset="utf-8" action="http://soundcloud.com/login/forgot" id="forgot-password-form" method="post">
<p>Enter your <strong>email address</strong> and we'll <strong>send you a link</strong> that'll allow you to <strong>change your password</strong>. Problems? Contact <a href="/pages/support">support</a>.</p>
<div><label for="email">Your email address</label>
<input class="title auto-focus" id="email" name="email" type="text" />
<div class="form-buttons"><input class="default" name="commit" type="submit" value="Submit" /></div></div>
</form>
</div><a href="/login/forgot" class="forgot-link" tabindex="5">Forgot password?</a></div></div></div></div></div>
<script src="http://a1.soundcloud.com/javascripts/base.js?c1f0ed" type="text/javascript"></script>

<script type="text/javascript">
var _gaq = _gaq || [];
$.helpers.loadScriptAsync('http://www.google-analytics.com/ga.js', 'https://ssl.google-analytics.com/ga.js');
$.helpers.loadScriptAsync('http://www.google.com/jsapi', 'https://www.google.com/jsapi');
</script>
<script type="text/javascript">
_qoptions = {qacct: "p-47_zcqmJsLHXQ"};
$.helpers.loadScriptAsync('http://edge.quantserve.com/quant.js', 'https://quantserve.com/quant.js', true);
</script>
<noscript>
<img alt="Quantcast" class="hidden" src="http://pixel.quantserve.com/pixel/p-47_zcqmJsLHXQ.gif" />
</noscript>


</body></html>

