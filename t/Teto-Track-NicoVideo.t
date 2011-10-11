use strict;
use utf8;
use Test::More tests => 5;
use Coro;
# use LWPx::Record::DataSection drop_uncommon_headers => 0, keep_cookie_key => [ 'user_session' ];

BEGIN { *CORE::GLOBAL::time = sub { 1298030285 } }

use_ok 'Teto::Track::NicoVideo';

use_ok 'Teto::Track::NicoVideo::sm';

use_ok 'Teto::Track::NicoVideo::nm';

subtest sm => sub {
    pass; return;
    my $track = new_ok 'Teto::Track::NicoVideo::sm', [ url => 'http://www.nicovideo.jp/watch/sm13465059', video_id => 'sm13465059' ];
    $track->user_agent->add_handler(
        request_send => sub {
            my ($req) = @_;
            return undef;
        }
    );
    $track->prepare;
    is $track->title, '【鏡音リン】 Shirley!! 【オリジナル】', 'extract_title_from_res';
};

subtest wait_in_queue => sub {
    my $t1 = Teto::Track::NicoVideo->new(url => 'http://localhost/', video_id => 0);
    my $t2 = Teto::Track::NicoVideo->new(url => 'http://localhost/', video_id => 0);
    my $t3 = Teto::Track::NicoVideo->new(url => 'http://localhost/', video_id => 0);

    my $done = 0;
    my $working;

    async {
        note 't1 entered';
        $t1->wait_in_queue;
        is $working++, 0;
        cede;
        note 't1';
        is $working--, 1;
        $t1->leave_from_queue;
        $done++;
    };

    async {
        note 't2 entered';
        $t2->wait_in_queue;
        is $working++, 0;
        cede;
        note 't2';
        is $working--, 1;
        $t2->leave_from_queue;
        $done++;
    };

    async {
        note 't3 entered';
        $t3->wait_in_queue;
        is $working++, 0;
        cede;
        note 't3';
        is $working--, 1;
        $t3->leave_from_queue;
        $done++;
    };

    cede until $done == 3;
};

__DATA__

@@ GET http://www.nicovideo.jp/watch/sm13465059 cookies=
HTTP/1.1 200 OK
Cache-Control: no-store, no-cache, must-revalidate, post-check=0, pre-check=0
Connection: close
Date: Fri, 18 Feb 2011 11:59:15 GMT
Pragma: no-cache
Server: Apache
Vary: Accept-Encoding
Content-Length: 42046
Content-Type: text/html
Expires: Thu, 01 Dec 1994 16:00:00 GMT
Client-Peer: 202.248.110.243:80
Client-Response-Num: 1
Client-Transfer-Encoding: chunked
Content-Base: http://www.nicovideo.jp/
Content-Script-Type: text/javascript
Content-Style-Type: text/css
Link: <http://nicomoba.jp/watch/sm13465059>; media="handheld"; rel="alternate"; type="application/xhtml+xml"
Link: </watch/sm13465059>; rel="canonical"
Link: <http://res.nimg.jp/img/favicon.ico>; rel="shortcut icon"
Link: <http://res.nimg.jp/css/common.css?110210>; charset="utf-8"; rel="stylesheet"; type="text/css"
Link: <http://res.nimg.jp/css/watch.css?110106>; charset="utf-8"; rel="stylesheet"; type="text/css"
Link: <http://res.nimg.jp/css/watch_ichiba.css?110203>; charset="utf-8"; rel="stylesheet"; type="text/css"
Title: 【鏡音リン】 Shirley!! 【オリジナル】 ‐ ニコニコ動画(原宿)
X-Meta-Copyright: ? niwango, Inc.
X-Meta-Description: ｜ω｀*）＜ステキよね、おんなのこってステキよね！！　　　　...
X-Meta-Keywords: VOCALOID,鏡音リン,新涼れい,π,Ｎ（仮）,iroha(sasaki),Shirley!!,DEBUTANTE4収録楽曲リンク,かわいいリンうた,リンオリジナル曲
X-Niconico-Authflag: 0

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html xmlns:og="http://ogp.me/ns#" xmlns:mixi="http://mixi-platform.com/ns#">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="Content-Script-Type" content="text/javascript">
<meta http-equiv="Content-Style-Type" content="text/css">
<meta name="copyright" content="&copy; niwango, Inc.">

<!---->
<meta name="keywords" content="VOCALOID,鏡音リン,新涼れい,π,Ｎ（仮）,iroha(sasaki),Shirley!!,DEBUTANTE4収録楽曲リンク,かわいいリンうた,リンオリジナル曲">
<meta name="description" content="｜ω｀*）＜ステキよね、おんなのこってステキよね！！　　　　...">
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Cache-Control" content="no-store, no-cache, must-revalidate, post-check=0, pre-check=0">
<meta http-equiv="Expires" content="Thu, 01 Dec 1994 16:00:00 GMT">
<meta property="mixi:device-mobile" content="http://m.nicovideo.jp/watch/sm13465059?cp_webto=mixi_check_pc">
<meta property="mixi:device-docomo" content="http://m.nicovideo.jp/watch/sm13465059?uid=NULLGWDOCOMO&guid=ON&cp_webto=mixi_check_pc">

<link rel="alternate" media="handheld" type="application/xhtml+xml" href="http://nicomoba.jp/watch/sm13465059">
<link rel="canonical" href="/watch/sm13465059">
<title>【鏡音リン】 Shirley!! 【オリジナル】 ‐ ニコニコ動画(原宿)</title>
<base href="http://www.nicovideo.jp/">
<link rel="shortcut icon" href="http://res.nimg.jp/img/favicon.ico">

<link rel="stylesheet" type="text/css" charset="utf-8" href="http://res.nimg.jp/css/common.css?110210">











<link rel="stylesheet" type="text/css" charset="utf-8" href="http://res.nimg.jp/css/watch.css?110106">
<link rel="stylesheet" type="text/css" charset="utf-8" href="http://res.nimg.jp/css/watch_ichiba.css?110203">
<script type="text/javascript" src="http://res.nimg.jp/js/lib/prototype.js?1.5.1.1_2"></script>
<script type="text/javascript" src="http://res.nimg.jp/js/common.js?090905"></script>
<script type="text/javascript" src="http://res.nimg.jp/js/swfobject.js?4"></script>
<script type="text/javascript" src="http://res.nimg.jp/js/nicolib.js?100531"></script>
<script type="text/javascript" src="http://res.nimg.jp/js/ads.js?110210"></script>
<script type="text/javascript" src="http://res.nimg.jp/js/__utm.js?080117"></script>
<script type="text/javascript" src="http://res.nimg.jp/js/watch.js?101227" chatset="utf-8"></script>

<script type="text/javascript"><!--

var User = { id: false, age: false, isPremium: false, isOver18: !!document.cookie.match(/nicoadult\s*=\s*1/), isMan: null };
var q = "";
var country = "jp";





--></script>
</head>

<body id="PAGETOP" class="mode_2">
<div id="PAGEHEADMENU">
<!---->
<div class="bg_headmenu" onmouseout="hideOBJ('headmenu_g1'); hideOBJ('headmenu_g2'); return false;"><div class="headmenu_width">

<table height="24" cellpadding="0" cellspacing="4" summary="" class="headmenu" style="float:left;">
<tr>
<td><a href="http://rd.nicovideo.jp/cc/header/uni">ニコニコTOP</a> -
<a href="http://rd.nicovideo.jp/cc/header/nicovideotop" class="disable">動画</a> |
<a href="http://rd.nicovideo.jp/cc/header/seiga">静画</a> |
<a href="http://rd.nicovideo.jp/cc/header/live">生放送</a> |
<a href="http://rd.nicovideo.jp/cc/header/app">アプリ</a>
 …</td>
<td nowrap onmouseover="showOBJ('headmenu_g1');"><span style="color:#C9CFCF; text-decoration:underline;">その他▼</span>
<div id="headmenu_g1" style="position:relative; display:none;" onmouseover="showOBJ('headmenu_g1'); return false;">
	<div class="headmenu_g" onmouseout="hideOBJ('headmenu_g1'); return false;">
	<table cellpadding="0" cellspacing="0">
	<tr valign="top">
	<td>
	<a href="http://rd.nicovideo.jp/cc/header/ch">チャンネル</a>
	<a href="http://rd.nicovideo.jp/cc/header/ichiba">市場</a>
	<a href="http://rd.nicovideo.jp/cc/header/jk">実況</a>
	<a href="http://rd.nicovideo.jp/cc/header/com">コミュ二ティ</a>
	<a href="http://rd.nicovideo.jp/cc/header/chokuhan">ニコニコ直販</a>
	<a href="http://rd.nicovideo.jp/cc/header/nicom">モバイル</a>
	</td>
	<td>
	<a href="http://rd.nicovideo.jp/cc/header/dic">大百科</a>
	<a href="http://rd.nicovideo.jp/cc/header/uad">ニコニ広告</a>
	<a href="http://rd.nicovideo.jp/cc/header/commons">コモンズ</a>
	<a href="http://rd.nicovideo.jp/cc/header/dvd">ニコニコDVD</a>
	<a href="http://rd.nicovideo.jp/cc/header/nicoga">ニコゲー</a>
	<a href="http://rd.nicovideo.jp/cc/header/news">ニュース</a>
	</td>
	</tr>
	</table>
	</div>
</div>
</td>
</tr>
</table>

<table height="24" cellpadding="0" cellspacing="4" summary="" class="headmenu" style="float:right;">
<tr>
<td style="color:#C9CFCF;">ようこそ ゲスト さん</td>
<td><a href="https://secure.nicovideo.jp/secure/login_form" style="color:#F30;">ログイン</a></td>
<td>
| <a href="my/top">マイページ</a>
| <a href="http://rd.nicovideo.jp/cc/header/upload" target="_blank">動画を投稿</a>
| <a href="/ranking" id="menu-ranking">ランキング</a> …</td>
<td nowrap onmouseover="showOBJ('headmenu_g2');"><span style="color:#C9CFCF; text-decoration:underline;">メニュー▼</span>
<div id="headmenu_g2" style="position:relative; display:none;" onmouseover="showOBJ('headmenu_g2'); return false;">
	<div class="headmenu_g" onmouseout="hideOBJ('headmenu_g2'); return false;" style="right:0;">
	<a href="http://rd.nicovideo.jp/cc/header/mylist">マイリスト</a>
	<a href="http://rd.nicovideo.jp/cc/header/watchlist">ウオッチリスト</a>
	<a href="http://rd.nicovideo.jp/cc/header/myvideo">投稿動画</a>
	<a href="http://rd.nicovideo.jp/cc/header/history">視聴履歴</a>
	<a href="http://rd.nicovideo.jp/cc/header/secure">アカウント設定</a>
	<a href="http://rd.nicovideo.jp/cc/header/help">ヘルプ</a>
		</div>
</div>
</td>
<td id="menu_switch">
<a href="#" title="追従(クリックで固定)" id="menu_switch_fixed"  onclick="$(document.body).removeClassName('mode_2').addClassName('mode_1'); Cookie.set('nofix', 1, 1000*60*60*24*365, '.nicovideo.jp', '/'); return false;"><img src="http://res.nimg.jp/img/base/headmenu/mode_2.png" alt="追従"></a>
<a href="#" title="固定(クリックで追従)" id="menu_switch_scroll" onclick="$(document.body).removeClassName('mode_1').addClassName('mode_2'); Cookie.remove('nofix', '.nicovideo.jp', '/'); return false;"><img src="http://res.nimg.jp/img/base/headmenu/mode_1.png" alt="固定"></a>
</td>
</tr>
</table>

<div style="clear:both;"></div><!---->

</div></div><!---->
</div>

<div id="PAGECONTAINER">
	<div id="PAGEMAIN" class="body_984">
		<div id="PAGEHEADER">
		<table width="984" cellspacing="0" cellpadding="4" summary="" style="clear:both;">
<tr>
<td>

<!--↓通常↓-->
<a href="http://www.nicovideo.jp/search/%E5%8E%9F%E5%AE%BF"><script type="text/javascript" src="http://res.nimg.jp/js/head_icon.js"></script></a>
<!--↑通常↑-->
</td>
<td><a href="http://www.nicovideo.jp/video_top" target="_top"><img src="http://res.nimg.jp/img/base/head/logo/hrjk.png" alt="ニコニコ動画"></a></td>
<td width="100%">
<form id="head_search_form" action="/search" method="get" onsubmit="submitSearch(this.action, false); return false;">
<input type="hidden" name="ref">
<table cellpadding="0" cellspacing="0" summary=""><tr valign="bottom">
<td><a href="#" class="head_ssw_1" onclick="submitSearch('/search', this); return false;"><img src="http://res.nimg.jp/img/x.gif" style="width:57px;" alt="キーワード" /></a></td>
<td style="padding:0 2px;"><a href="#" class="head_ssw_0" onclick="submitSearch('/tag', this); return false;"><img src="http://res.nimg.jp/img/x.gif" style="width:31px; background-position:-57px 0;" alt="タグ"></a></td>
<td><a href="#" class="head_ssw_0" onclick="submitSearch('/mylist_search', this); return false;"><img src="http://res.nimg.jp/img/x.gif" style="width:55px; background-position:-88px 0;" alt="マイリスト"></a></td>
</tr></table>

<div style="background:#393F3F; width:242px; border:solid 1px #999F9F;"><table cellpadding="0" cellspacing="2" summary=""><tr><td><div class="head_search_input"><input type="text" name="s" id="bar_search" value=""></div></td><td><input name="submit" type="image" src="http://res.nimg.jp/img/base/head/search/submit.png" alt="検索"></td></tr></table></div>

</form>
<script type="text/javascript"><!--
function submitSearch(p, e) {
	var f = $('head_search_form'), s = String.interpret(f.s.value).strip().replace(/%20/g, '+');
	if (s != '') location.href = p + "/" + encodeURIComponent(s) + (f.track ? "?track=" + f.track.value : "");
	else if (e) { f.down('a.head_ssw_1').className = 'head_ssw_0'; e.className = 'head_ssw_1'; f.action = p; f.s.focus(); }
}
--></script>
</td>
<td><div class="ads_468"><!--↓表示してもよい↓-->

<div id="web_pc_top"></div>
<script type="text/javascript"><!--

getAds('web_pc_top');


--></script>

<!--↑表示してもよい↑-->

</div></td>
</tr>
</table>		</div>
		<div id="PAGEBODY">
		

<!--↓外部プレーヤー：出せない↓-->

<table cellpadding="4" cellspacing="0" style="margin:0 auto 8px;">
<tr align="center">
<td><a href="https://secure.nicovideo.jp/secure/login_form?next_url=%2Fwatch%2Fsm13465059&site=niconico&time=1298030355&hash_key=68acf288"><img src="http://res.nimg.jp/img/watch_logout/btn_login.png" alt="ログイン画面へ"></a></td>
<td><a href="https://secure.nicovideo.jp/secure/register"><img src="http://res.nimg.jp/img/watch_logout/btn_register.png" alt="アカウント新規登録へ"></a></td>
</tr>
</table>

<div class="content_672_solo">
<!--↓中央寄↓-->

<table width="672" cellpadding="4" cellspacing="0">
<tr valign="top">
<td><img alt="" src="http://tn-skr4.smilevideo.jp/smile?i=13465059" class="img_std128"></td>
<td width="100%">
<p class="font12">
		<strong>2011年02月01日 06:03</strong> 投稿
			</p>
<!-- google_ad_section_start -->
<h1 style="margin:2px 0;">【鏡音リン】 Shirley!! 【オリジナル】</h1>
<p class="font12">｜ω｀*）＜ステキよね、おんなのこってステキよね！！<br /><br />　　　　 　アフターファイヴを元気いっぱいに、そして時にちょっと切なく過ごす、<br />　　　　 　そんな社会人１年生おにゃのこの歌。　HEY!!（・д・ﾉ）☆ﾉ<br /><br />　　　　　 以前、DEBUTANTE Ⅳに収録された曲です。諸々調整、リテイクしました。<br /><br />　　 　　　イラスト：新涼れい / 動画：Ｎ（仮） / 作詞：シリカ【π＋iroha(sasaki)】<br />　　　　 　π【<a href="http://www.nicovideo.jp/mylist/2181673">mylist/2181673</a>】/ 曲：iroha(sasaki)【<a href="http://www.nicovideo.jp/mylist/3001349">mylist/3001349</a>】<br />　　　　　 皆さんお疲れ様っした！！<br /><br />新涼れいさんのかわゆいおっとりリンちゃんこちら⇒http://www.pixiv.net/member_illust.php?mode=medium&illust_id=16323857<br /><br /><font color="blue">◆</font>2/8　カラオケ音源公開しました～。ご入用の方はどうぞッス。⇒http://xiao-sphere.net/data/shirley_oke.mp3</p>
<!-- google_ad_section_end -->
</td>
</tr>
</table>

<table width="672" cellpadding="4" cellspacing="0" summary="">
<tr>
<td><img src="http://res.nimg.jp/img/watch/tag_title.png" alt="登録タグ"></td>
<td width="100%" class="font12">
<!-- google_ad_section_start -->
<nobr><img src="http://res.nimg.jp/img/watch/ctg.png" alt="カテゴリ" style="vertical-align:middle; margin-right:2px;"><a href="/top/vocaloid" rel="tag">VOCALOID</a><a href="http://dic.nicovideo.jp/a/VOCALOID" target="_blank" title="VOCALOIDとは"><img alt="百" class="txticon" src="http://res.nimg.jp/img/common/icon/dic_on.png"></a></nobr>&nbsp;
<nobr><a href="/tag/%E9%8F%A1%E9%9F%B3%E3%83%AA%E3%83%B3" rel="tag">鏡音リン</a><a href="http://dic.nicovideo.jp/a/%E9%8F%A1%E9%9F%B3%E3%83%AA%E3%83%B3" target="_blank" title="鏡音リンとは"><img alt="百" class="txticon" src="http://res.nimg.jp/img/common/icon/dic_on.png"></a></nobr>&nbsp;
<nobr><a href="/tag/%E6%96%B0%E6%B6%BC%E3%82%8C%E3%81%84" rel="tag">新涼れい</a><a href="http://dic.nicovideo.jp/a/%E6%96%B0%E6%B6%BC%E3%82%8C%E3%81%84" target="_blank" title="新涼れいとは"><img alt="百" class="txticon" src="http://res.nimg.jp/img/common/icon/dic_on.png"></a></nobr>&nbsp;
<nobr><a href="/tag/%CF%80" rel="tag">π</a><a href="http://dic.nicovideo.jp/a/%CF%80" target="_blank" title="πとは"><img alt="百" class="txticon" src="http://res.nimg.jp/img/common/icon/dic_on.png"></a></nobr>&nbsp;
<nobr><a href="/tag/%EF%BC%AE%EF%BC%88%E4%BB%AE%EF%BC%89" rel="tag">Ｎ（仮）</a><a href="http://dic.nicovideo.jp/a/%EF%BC%AE%EF%BC%88%E4%BB%AE%EF%BC%89" target="_blank" title="Ｎ（仮）とは"><img alt="百" class="txticon" src="http://res.nimg.jp/img/common/icon/dic_on.png"></a></nobr>&nbsp;
<nobr><a href="/tag/iroha%28sasaki%29" rel="tag">iroha(sasaki)</a><a href="http://dic.nicovideo.jp/a/iroha%28sasaki%29" target="_blank" title="iroha(sasaki)とは"><img alt="百" class="txticon" src="http://res.nimg.jp/img/common/icon/dic_on.png"></a></nobr>&nbsp;
<nobr><a href="/tag/Shirley%21%21" rel="tag">Shirley!!</a><a href="http://dic.nicovideo.jp/a/Shirley%21%21" target="_blank" title="Shirley!!とは"><img alt="百" class="txticon" src="http://res.nimg.jp/img/common/icon/dic_on.png"></a></nobr>&nbsp;
<nobr><a href="/tag/DEBUTANTE4%E5%8F%8E%E9%8C%B2%E6%A5%BD%E6%9B%B2%E3%83%AA%E3%83%B3%E3%82%AF" rel="tag">DEBUTANTE4収録楽曲リンク</a><a href="http://dic.nicovideo.jp/a/DEBUTANTE4%E5%8F%8E%E9%8C%B2%E6%A5%BD%E6%9B%B2%E3%83%AA%E3%83%B3%E3%82%AF" target="_blank" title="DEBUTANTE4収録楽曲リンクとは"><img alt="百" class="txticon" src="http://res.nimg.jp/img/common/icon/dic_on.png"></a></nobr>&nbsp;
<nobr><a href="/tag/%E3%81%8B%E3%82%8F%E3%81%84%E3%81%84%E3%83%AA%E3%83%B3%E3%81%86%E3%81%9F" rel="tag">かわいいリンうた</a><a href="http://dic.nicovideo.jp/a/%E3%81%8B%E3%82%8F%E3%81%84%E3%81%84%E3%83%AA%E3%83%B3%E3%81%86%E3%81%9F" target="_blank" title="かわいいリンうたとは"><img alt="百" class="txticon" src="http://res.nimg.jp/img/common/icon/dic_on.png"></a></nobr>&nbsp;
<nobr><a href="/tag/%E3%83%AA%E3%83%B3%E3%82%AA%E3%83%AA%E3%82%B8%E3%83%8A%E3%83%AB%E6%9B%B2" rel="tag">リンオリジナル曲</a><a href="http://dic.nicovideo.jp/a/%E3%83%AA%E3%83%B3%E3%82%AA%E3%83%AA%E3%82%B8%E3%83%8A%E3%83%AB%E6%9B%B2" target="_blank" title="リンオリジナル曲とは"><img alt="百" class="txticon" src="http://res.nimg.jp/img/common/icon/dic_on.png"></a></nobr>&nbsp;
<!-- google_ad_section_end -->
</td>
</tr>
</table>


<!--↑中央寄↑-->
</div>

<!--↓ニコニコ市場↓-->


<div id="ichiba_placeholder" style="padding:8px 0;">
<div id="showMainVal" style="display:none;">bbe3706555c283be5298ab34bf8831f1</div>
<div id="ichiba_itemA" style="width:100%;">
  	<table border="0" cellpadding="0" cellspacing="4" class="list_table">
		<tr>
		<td><img src="http://res.nicovideo.jp/img/x.gif" class="material mat_utafull" alt="着うたフル"></td>
		<td width="100%" id="ichibaitem_dw1485329"><h3><a href="http://ichiba.nicovideo.jp/item/dw1485329" target="_blank" class="ichiba_item" onmousedown="return ichibaA.item_click('dw1485329')" style="font-size:200%; line-height:1;">炉心融解</a></h3>&nbsp;<strong>iroha feat. 鏡音リン</strong> … <strong style="color:#C00;">2,752人</strong>が購入(前日<strong style="color:#C00;">+2人</strong>)、<strong>1人</strong>がコメント、<strong>12,318人</strong>がクリック(この動画で8人)</td>			</tr>
	<tr><td colspan="3" class="dot_1"><img src="http://res.nicovideo.jp/img/x.gif" alt=""></td></tr>
		<tr>
		<td><img src="http://res.nicovideo.jp/img/x.gif" class="material mat_utafull" alt="着うたフル"></td>
		<td width="100%" id="ichibaitem_dw3215781"><h3><a href="http://ichiba.nicovideo.jp/item/dw3215781" target="_blank" class="ichiba_item" onmousedown="return ichibaA.item_click('dw3215781')" style="font-size:150%; line-height:1;">存在</a></h3>&nbsp;<strong>iroha(sasaki)×黒ねこ with 実谷なな</strong> … <strong style="color:#C00;">12人</strong>が購入、<strong>179人</strong>がクリック(この動画で2人)</td>			</tr>
	<tr><td colspan="3" class="dot_1"><img src="http://res.nicovideo.jp/img/x.gif" alt=""></td></tr>
		<tr>
		<td><img src="http://res.nicovideo.jp/img/x.gif" class="material mat_utafull" alt="着うたフル"></td>
		<td width="100%" id="ichibaitem_dw3215787"><h3><a href="http://ichiba.nicovideo.jp/item/dw3215787" target="_blank" class="ichiba_item" onmousedown="return ichibaA.item_click('dw3215787')"">noctiluca</a></h3>&nbsp;<strong>iroha(sasaki) with ヤマイ</strong> … <strong style="color:#C00;">16人</strong>が購入、<strong>267人</strong>がクリック(この動画で1人)</td>			</tr>
	<tr><td colspan="3" class="dot_1"><img src="http://res.nicovideo.jp/img/x.gif" alt=""></td></tr>
		</table>
</div>
<div id="ichiba_edit_buttonA">
<div class="ichiba_box_center">
	<form><input type="button" disabled class="submit" value="着うた・着メロなどの編集" onclick="ichibaA.showIchibaConsole();"></form></div>
</div>
<div style="display:none;" id="premium_invitationA" class="premium_invitation">
	<div class="ichiba_box_center">
		<p class="ichiba_txt_12"><span style="color:#C00;">他の人が貼った商品の削除は、プレミアム会員のみが行うことができます。</span> <a target="_blank" href="http://www.nicovideo.jp/?p=premium_top&sec=nicomarket" style="color:#09C;">&gt;&gt;プレミアム会員登録</a></p>
	</div>
</div>
<div id="ichiba_editA"></div>


<div id="ichiba_itemB" style="width:100%;">
  <div id="ichiba_adults" style="display:none;"></div>
<div class="bpn_line_472">
	<div style="padding:4px;">
<div id="ichibaitem_azB004IYJI98" class="bpn_frm" style="border:solid 1px #FFF;">
<table border="0" cellpadding="4" cellspacing="0">
<tr>
<td>
<p style="margin-top:4px;">
<div style="width:160px; position:relative;">
  <div style="text-align:center;">
		<img src="http://ecx.images-amazon.com/images/I/41HYqNeGUOL._AA160_.jpg" width="160" height="160" title="ダル/鏡音リン P-128">
	  </div>
  <span id="azB004IYJI98_watch_mq" style="position:absolute; top:0px; z-index:2; width:160px; font-weight: bold; text-decoration:none;">
  </span>
  <a style="cursor:pointer;" href="http://www.amazon.co.jp/dp/B004IYJI98/ref=asc_df_B004IYJI98337091/?tag=nicovideojp-22&amp;creative=380333&amp;creativeASIN=B004IYJI98&amp;linkCode=asn" class="ichiba_item" target="_blank" onmousedown="return ichibaB_az.item_click(&#039;azB004IYJI98&#039;)">
  </a>
</div>
</p>
</td>
<td width="100%">
<p class="ichiba_txt_12"><span class="item_genre">おもちゃ＆ホビー</span></p>
<h3><a href="http://www.amazon.co.jp/dp/B004IYJI98/ref=asc_df_B004IYJI98337091/?tag=nicovideojp-22&amp;creative=380333&amp;creativeASIN=B004IYJI98&amp;linkCode=asn" class="ichiba_item" target="_blank" onmousedown="return ichibaB_az.item_click('azB004IYJI98')">ダル/鏡音リン P-128</a></h3>
<p class="ichiba_txt_12">
<strong>グルーヴ</strong></p>
<p class="ichiba_txt_12" style="margin-top:4px;">
発売日：<strong>2011-04-25</strong>...あと<strong style="color:#C00;">66</strong>日<br>
<strong>804人</strong>がクリック(この動画で66人)<br><nobr class="no_bringup"><a href="http://ichiba.nicovideo.jp/item/azB004IYJI98" target="_blank">コメントする</a></nobr>
</p>
</td>
</tr>
</table>
</div>
</div>					<div style="padding:4px;">
<div id="ichibaitem_azB004BNF796" class="bpn_frm" style="border:solid 1px #FFF;">
<table border="0" cellpadding="4" cellspacing="0">
<tr>
<td>
<p style="margin-top:4px;">
<div style="width:160px; position:relative;">
  <div style="text-align:center;">
		<img src="http://ecx.images-amazon.com/images/I/61ya-E5dUzL._AA160_.jpg" width="160" height="160" title="炉心融解">
	  </div>
  <span id="azB004BNF796_watch_mq" style="position:absolute; top:0px; z-index:2; width:160px; font-weight: bold; text-decoration:none;">
  </span>
  <a style="cursor:pointer;" href="http://www.amazon.co.jp/exec/obidos/ASIN/B004BNF796/nicovideojp-22/ref=nosim" class="ichiba_item" target="_blank" onmousedown="return ichibaB_az.item_click(&#039;azB004BNF796&#039;)">
  </a>
</div>
</p>
</td>
<td width="100%">
<p class="ichiba_txt_12"><span class="item_genre">MP3 ダウンロード</span></p>
<h3><a href="http://www.amazon.co.jp/exec/obidos/ASIN/B004BNF796/nicovideojp-22/ref=nosim" class="ichiba_item" target="_blank" onmousedown="return ichibaB_az.item_click('azB004BNF796')">炉心融解</a></h3>
<p class="ichiba_txt_12">
<strong>iroha(sasaki)</strong></p>
<p class="ichiba_txt_12" style="margin-top:4px;">
発売日：<strong>2010-10-13</strong><br>
<strong style="color:#C00;">3人</strong>が購入、<strong>146人</strong>がクリック(この動画で62人)<br><nobr class="bringup"><a href="http://ichiba.nicovideo.jp/item/azB004BNF796" target="_blank">ムーラン</a> さんが育てています</nobr>
</p>
</td>
</tr>
</table>
</div>
</div>	</div>
	<div class="bpn_line_472">
																	<div style="padding:4px;">
<div id="ichibaitem_azB001AIJXGI" class="bpn_frm" style="border:solid 1px #FFF;">
<table border="0" cellpadding="4" cellspacing="0">
<tr>
<td>
<p style="margin-top:4px;">
<div style="width:76px; position:relative;">
  <div style="text-align:center;">
		<img src="http://ecx.images-amazon.com/images/I/41Ghqbr3RfL._AA76_.jpg" width="76" height="76" title="ねんどろいど 鏡音リン  (ノンスケールABS/PVC塗装済み可動フィギュア)">
	  </div>
  <span id="azB001AIJXGI_watch_mq" style="position:absolute; top:2px; z-index:2; width:76px; font-weight: bold; text-decoration:none;">
  </span>
  <a style="cursor:pointer;" href="http://www.amazon.co.jp/dp/B001AIJXGI/ref=asc_df_B001AIJXGI337091/?tag=nicovideojp-22&amp;creative=380333&amp;creativeASIN=B001AIJXGI&amp;linkCode=asn" class="ichiba_item" target="_blank" onmousedown="return ichibaB_az.item_click('azB001AIJXGI')">
  </a>
 </div>
</p>
</td>
<td width="100%">
<p class="ichiba_txt_12"><span class="item_genre">おもちゃ＆ホビー</span></p>
<h3><a href="http://www.amazon.co.jp/dp/B001AIJXGI/ref=asc_df_B001AIJXGI337091/?tag=nicovideojp-22&amp;creative=380333&amp;creativeASIN=B001AIJXGI&amp;linkCode=asn" class="ichiba_item" target="_blank" onmousedown="return ichibaB_az.item_click('azB001AIJXGI')">ねんどろいど 鏡音リン  (ノンスケールABS/PVC塗装済み可動フィギュア)</a></h3>
<p class="ichiba_txt_12">
<strong>グッドスマイルカンパニー</strong></p>
<p class="ichiba_txt_12" style="margin-top:4px;">
発売日：<strong>2008-11-12</strong><br>
<strong style="color:#C00;">1,571人</strong>が購入、<strong>15人</strong>がコメント、<strong>31,806人</strong>がクリック(この動画で17人)<br><nobr class="bringup"><a href="http://ichiba.nicovideo.jp/item/azB001AIJXGI" target="_blank">OTARU1986</a> さんが育てています</nobr>
</p>
</td>
</tr>
</table>
</div>
</div>										<div style="padding:4px;">
<div id="ichibaitem_azB002YK5TEG" class="bpn_frm" style="border:solid 1px #FFF;">
<table border="0" cellpadding="4" cellspacing="0">
<tr>
<td>
<p style="margin-top:4px;">
<div style="width:76px; position:relative;">
  <div style="text-align:center;">
		<img src="http://ecx.images-amazon.com/images/I/41rqdrghv6L._AA76_.jpg" width="76" height="76" title="ねんどろいどぷらす ボーカロイド 激走プルバックカー リン&amp;ロードローラー(イエロー)">
	  </div>
  <span id="azB002YK5TEG_watch_mq" style="position:absolute; top:2px; z-index:2; width:76px; font-weight: bold; text-decoration:none;">
  </span>
  <a style="cursor:pointer;" href="http://www.amazon.co.jp/dp/B002YK5TEG/ref=asc_df_B002YK5TEG337091/?tag=nicovideojp-22&amp;creative=380333&amp;creativeASIN=B002YK5TEG&amp;linkCode=asn" class="ichiba_item" target="_blank" onmousedown="return ichibaB_az.item_click('azB002YK5TEG')">
  </a>
 </div>
</p>
</td>
<td width="100%">
<p class="ichiba_txt_12"><span class="item_genre">おもちゃ＆ホビー</span></p>
<h3><a href="http://www.amazon.co.jp/dp/B002YK5TEG/ref=asc_df_B002YK5TEG337091/?tag=nicovideojp-22&amp;creative=380333&amp;creativeASIN=B002YK5TEG&amp;linkCode=asn" class="ichiba_item" target="_blank" onmousedown="return ichibaB_az.item_click('azB002YK5TEG')">ねんどろいどぷらす ボーカロイド 激走プルバックカー リン&amp;ロードローラー(イエロー)</a></h3>
<p class="ichiba_txt_12">
<strong>フリーイング</strong></p>
<p class="ichiba_txt_12" style="margin-top:4px;">
発売日：<strong>2010-03-27</strong><br>
<strong style="color:#C00;">119人</strong>が購入、<strong>5人</strong>がコメント、<strong>1,832人</strong>がクリック(この動画で2人)<br><nobr class="bringup"><a href="http://ichiba.nicovideo.jp/item/azB002YK5TEG" target="_blank">OTARU1986</a> さんが育てています</nobr>
</p>
</td>
</tr>
</table>
</div>
</div>										<div style="padding:4px;">
<div id="ichibaitem_azB001F0QAFI" class="bpn_frm" style="border:solid 1px #FFF;">
<table border="0" cellpadding="4" cellspacing="0">
<tr>
<td>
<p style="margin-top:4px;">
<div style="width:76px; position:relative;">
  <div style="text-align:center;">
		<img src="http://ecx.images-amazon.com/images/I/31u3P9JzPCL._AA76_.jpg" width="76" height="76" title="Figma 鏡音リン">
	  </div>
  <span id="azB001F0QAFI_watch_mq" style="position:absolute; top:2px; z-index:2; width:76px; font-weight: bold; text-decoration:none;">
  </span>
  <a style="cursor:pointer;" href="http://www.amazon.co.jp/exec/obidos/ASIN/B001F0QAFI/nicovideojp-22/ref=nosim" class="ichiba_item" target="_blank" onmousedown="return ichibaB_az.item_click('azB001F0QAFI')">
  </a>
 </div>
</p>
</td>
<td width="100%">
<p class="ichiba_txt_12"><span class="item_genre">おもちゃ＆ホビー</span></p>
<h3><a href="http://www.amazon.co.jp/exec/obidos/ASIN/B001F0QAFI/nicovideojp-22/ref=nosim" class="ichiba_item" target="_blank" onmousedown="return ichibaB_az.item_click('azB001F0QAFI')">Figma 鏡音リン</a></h3>
<p class="ichiba_txt_12">
<strong>Max Factory</strong></p>
<p class="ichiba_txt_12" style="margin-top:4px;">
発売日：<strong>2008-11-22</strong><br>
<strong style="color:#C00;">430人</strong>が購入、<strong>8人</strong>がコメント、<strong>13,172人</strong>がクリック(この動画で2人)<br><nobr class="bringup"><a href="http://ichiba.nicovideo.jp/item/azB001F0QAFI" target="_blank">OTARU1986</a> さんが育てています</nobr>
</p>
</td>
</tr>
</table>
</div>
</div>																															</div>
<table border="0" cellpadding="0" cellspacing="4" class="list_table">
																																					<tr>
<td width="100%" id="ichibaitem_azB001BIXLOC"><h3><a href="http://www.amazon.co.jp/dp/B001BIXLOC/ref=asc_df_B001BIXLOC337085/?tag=nicovideojp-22&amp;creative=380333&amp;creativeASIN=B001BIXLOC&amp;linkCode=asn" target="_blank" class="ichiba_item" onmousedown="return ichibaB_az.item_click('azB001BIXLOC')">VOCALOID2 鏡音リン・レン act2</a></h3>&nbsp;<strong>クリプトン・フューチャー・メディア</strong><span class="item_genre">&nbsp;DVD-ROM</span> 発売日：<strong>2008-07-18</strong> … <strong style="color:#C00;">377人</strong>が購入、<strong>27人</strong>がコメント、<strong>45,664人</strong>がクリック(この動画で5人)<nobr class="bringup"><a href="http://ichiba.nicovideo.jp/item/azB001BIXLOC" target="_blank">OTARU1986</a> さんが育てています</nobr></td></tr>
<tr><td colspan="3" class="dot_1"><img src="http://res.nicovideo.jp/img/x.gif" alt=""></td></tr>																		<tr>
<td width="100%" id="ichibaitem_azB002WGIBYM"><h3><a href="http://www.amazon.co.jp/exec/obidos/ASIN/B002WGIBYM/nicovideojp-22/ref=nosim" target="_blank" class="ichiba_item" onmousedown="return ichibaB_az.item_click('azB002WGIBYM')">ねんどろいどぷらす ぬいぐるみシリーズ04 鏡音リン</a></h3>&nbsp;<strong>Gift</strong><span class="item_genre">&nbsp;おもちゃ＆ホビー</span> 発売日：<strong>2009-12-26</strong> … <strong style="color:#C00;">40人</strong>が購入、<strong>3人</strong>がコメント、<strong>1,252人</strong>がクリック(この動画で1人)<nobr class="bringup"><a href="http://ichiba.nicovideo.jp/item/azB002WGIBYM" target="_blank">OTARU1986</a> さんが育てています</nobr></td></tr>
<tr><td colspan="3" class="dot_1"><img src="http://res.nicovideo.jp/img/x.gif" alt=""></td></tr>																		<tr>
<td width="100%" id="ichibaitem_azB001O2SNOI"><h3><a href="http://www.amazon.co.jp/exec/obidos/ASIN/B001O2SNOI/nicovideojp-22/ref=nosim" target="_blank" class="ichiba_item" onmousedown="return ichibaB_az.item_click('azB001O2SNOI')">キャラクターボーカルシリーズ02 鏡音リン (1/8スケール PVC塗装済み完成品)</a></h3>&nbsp;<strong>グッドスマイルカンパニー</strong><span class="item_genre">&nbsp;おもちゃ＆ホビー</span> 発売日：<strong>2009-06-30</strong> … <strong style="color:#C00;">471人</strong>が購入、<strong>24人</strong>がコメント、<strong>22,988人</strong>がクリック(この動画で1人)<nobr class="bringup"><a href="http://ichiba.nicovideo.jp/item/azB001O2SNOI" target="_blank">OTARU1986</a> さんが育てています</nobr></td></tr>
<tr><td colspan="3" class="dot_1"><img src="http://res.nicovideo.jp/img/x.gif" alt=""></td></tr>																		<tr>
<td width="100%" id="ichibaitem_azB004E0ZP8O"><h3><a href="http://www.amazon.co.jp/dp/B004E0ZP8O/ref=asc_df_B004E0ZP8O337085/?tag=nicovideojp-22&amp;creative=380333&amp;creativeASIN=B004E0ZP8O&amp;linkCode=asn" target="_blank" class="ichiba_item" onmousedown="return ichibaB_az.item_click('azB004E0ZP8O')">鏡音リン・レン・アペンド（RIN/LEN APPEND）</a></h3>&nbsp;<strong>クリプトン・フューチャー・メディア</strong><span class="item_genre">&nbsp;DVD-ROM</span> 発売日：<strong>2010-12-27</strong> … <strong style="color:#C00;">49人</strong>が購入、<strong>2人</strong>がコメント、<strong>14,928人</strong>がクリック(この動画で2人)<nobr class="bringup"><a href="http://ichiba.nicovideo.jp/item/azB004E0ZP8O" target="_blank">OTARU1986</a> さんが育てています</nobr></td></tr>
<tr><td colspan="3" class="dot_1"><img src="http://res.nicovideo.jp/img/x.gif" alt=""></td></tr>																		<tr>
<td width="100%" id="ichibaitem_yswcanvas_300004310000"><h3><a href="http://ck.jp.ap.valuecommerce.com/servlet/referral?sid=2466861&amp;pid=876879864&amp;vc_url=http%3A%2F%2Frd.store.yahoo.co.jp%2Fwcanvas%2F300004310000.html&amp;vcptn=yswcanvas_300004310000" target="_blank" class="ichiba_item" onmousedown="return ichibaB_ys.item_click('yswcanvas_300004310000')">VOCALOID FESTAカタログ＜ウッド・ベル＞</a></h3>&nbsp;( ホワイトキャンバス Yahoo!店 ) <span class="item_genre">&nbsp;本</span> … <strong>166人</strong>がクリック(この動画で1人)<nobr class="no_bringup"><a href="http://ichiba.nicovideo.jp/item/yswcanvas_300004310000" target="_blank">コメントする</a></nobr></td></tr>
<tr><td colspan="3" class="dot_1"><img src="http://res.nicovideo.jp/img/x.gif" alt=""></td></tr>										</table>
</div>
<div id="ichiba_edit_buttonB">
<!--↓検索展開ボタン↓-->
<div class="ichiba_box_center">
<form><input type="button" disabled class="submit" value="商品の編集" onclick="ichibaB_az.showIchibaConsole();"></form>
</div>
<!--↑検索展開ボタン↑-->
</div>
<div style="display:none;" id="premium_invitationB" class="premium_invitation">
	<div class="ichiba_box_center">
		<p class="ichiba_txt_12"><span style="color:#C00;">他の人が貼った商品の削除は、プレミアム会員のみが行うことができます。</span> <a target="_blank" href="http://www.nicovideo.jp/?p=premium_top&sec=nicomarket" style="color:#09C;">&gt;&gt;プレミアム会員登録</a></p>
	</div>
</div>
<div id="ichiba_editB"></div>

<style type="text/css">
<!--
/*↓文字定義↓*/
.ichiba_txt_14 { font-size:14px; line-height:1.2; font-weight:bold;}
.ichiba_txt_12 { font-size:12px; line-height:1.375;}
.ichiba_txt_10 { font-size:10px; line-height:1.25;}
/*↑文字定義↑*/

/*↓単独の文字やボタンの配置用↓*/
div.ichiba_box_center { text-align:center; margin:0 0 8px; padding:4px;}
/*↑単独の文字やボタンの配置用↑*/

/*↓リンク定義↓*/
a.ichiba_item { font-weight:bold;}
a.ichiba_item:link, a.ichiba_item:visited { color:#06C; text-decoration:underline;}
a.ichiba_item:hover, a.ichiba_item:active { color:#0CC; text-decoration:none;}
/*↑リンク定義↑*/


span.price_off  { background:#F80; color:#FFF; font-weight:bold; padding:0 2px; margin:0 4px;}/* 割引率 */
span.item_genre { font-size:12px; color:#099;}/* 商品ジャンル */
span.item_lock  { color:#F90;}/* 商品ロック★ */

img.go_ichiba { vertical-align:middle; margin-right:2px;}/* ｢ニコニコ市場へ｣アイコン */

div.search_belt { background:#222; border:solid #666; border-width:2px 0;}
div.search_belt table { font-size:12px; color:#FFF; margin:0 auto;}


/*↓素材・物販テーブル(貼付済)↓*/
table.list_table { font-size:12px; line-height:1.5; margin-left:32px; clear:both; width:912px;}
table.list_table h3 { font-size:12px; line-height:1 !important; display:inline;}
/*↑素材・物販テーブル(貼付済)↑*/


/* ↓素材(10/02/25～)↓ */

.col_music { color:#369 !important;}/* 素材分類＞音楽 */
.col_voice { color:#099 !important;}/* 素材分類＞ボイス */
.col_video { color:#3C6 !important;}/* 素材分類＞ムービー */
.col_enter { color:#F93 !important;}/* 素材分類＞エンターテイメント */
.col_other { color:#666 !important;}/* 素材分類＞その他 */

.material { width:64px; height:21px; background:url('http://res.nicovideo.jp/img/watch/ichiba/material.png');}

	.mat_melo     { background-position:0 0;}/* 素材＞着メロ */
	.mat_uta      { background-position:-64px 0;}/* 素材＞うた */
	.mat_utafull  { background-position:-128px 0;}/* 素材＞うたフル */
	.mat_kashi    { background-position:-192px 0;}/* 素材＞歌詞 */
	.mat_voice    { background-position:0 -21px;}/* 素材＞ボイス */
	.mat_movie    { background-position:0 -42px;}/* 素材＞ムービー */
	.mat_pv       { background-position:-64px -42px;}/* 素材＞PV */
	.mat_pvfull   { background-position:-128px -42px;}/* 素材＞PVフル */
	.mat_douga    { background-position:-192px -42px;}/* 素材＞動画 */
	.mat_machiuke { background-position:0 -63px;}/* 素材＞待受 */
	.mat_decome   { background-position:-64px -63px;}/* 素材＞デコメ */
	.mat_book     { background-position:-128px -63px;}/* 素材＞ブック */
	.mat_game     { background-position:-192px -63px;}/* 素材＞ゲーム */
	.mat_kisekae  { background-position:-256px -63px;}/* 素材＞きせかえ */
	.mat_machicha { background-position:-320px -63px;}/* 素材＞マチキャラ */
	.mat_other    { background-position:0 -84px;}/* 素材＞その他 */


/* ↓物販(09/06/11～)↓ */

div.bpn_line_472 { width:472px; float:left;}/* 1～5商品用の2列 */
div.bpn_frm { width:456px; padding:3px; overflow:hidden;}
div.bpn_frm table { width:456px;}


/*↓物販＞アイコン↓*/
.bpn_from_r18, .bpn_from_amz, .bpn_from_yhj, .bpn_from_gem, .bpn_from_nid, .bpn_from_mms, .bpn_from_rkt {
width:72px; height:15px; background:url('http://res.nicovideo.jp/img/watch/ichiba/bpn_from.png?091021');}
.bpn_from_amz { background-position:0 -15px;}/* amazon */
.bpn_from_yhj { background-position:0 -30px;}/* Yahoo! */
.bpn_from_gem { background-position:0 -45px;}/* ググモ */
.bpn_from_nid { background-position:0 -60px;}/* ニコ直 */
.bpn_from_mms { background-position:0 -75px;}/* ミュウモ */
.bpn_from_rkt { background-position:0 -90px;}/* 楽天 */
/*↑物販＞アイコン↑*/


/*↓物販＞タブ↓*/
div.ichiba_tab { background:url('http://res.nicovideo.jp/img/watch/ichiba/tab/bg.gif') no-repeat bottom; padding:4px; text-align:center;}
div.bg_bpn_tab { background:url('http://res.nicovideo.jp/img/watch/ichiba/bg_bpn_tab.png') no-repeat bottom; margin:4px;}
div.bg_bpn_tab table { margin:0 auto;}
div.bg_bpn_tab img { width:90px; height:30px;}
	.bg_bpn_tab a:link img, .bg_bpn_tab a:visited img {
	background:url('http://res.nicovideo.jp/img/watch/ichiba/bpn_tab_0.png');}
	.bg_bpn_tab a:hover img, .bg_bpn_tab a:active img, td.open_tab img {
	background:url('http://res.nicovideo.jp/img/watch/ichiba/bpn_tab_1.png');}
img.bpn_tab_yhj { background-position:0 -30px !important;}/* Yahoo! */
img.bpn_tab_jpc, img.bpn_tab_gem { background-position:0 -60px !important;}/* JAPANCOOL(ググモ) */
img.bpn_tab_nid { background-position:0 -90px !important;}/* ニコ直 */
img.bpn_tab_mms { background-position:0 -120px !important;}/* ミュウモ */
img.bpn_tab_rkt { background-position:0 -150px !important;}/* 楽天 */
img.bpn_tab_itu { background-position:0 -180px !important;}/* iTunes */
/*↑物販＞タブ↑*/


 td.search_col  { background:#F9F9F9; font-size:12px; line-height:1.25; border:solid 2px #999; padding:6px;}/* 検索結果＞td */
 ul.search_list { line-height:1.5; padding:0; margin:4px 0 0 16px;}/* 検索結果＞素材 */
img.search_item { background:#FFF; width:75px; height:75px; border:solid 1px #999; float:right; margin:0 0 4px 4px; padding:4px;}/* 検索結果＞物販＞画像 */


/*↓育てる↓*/
.bringup,
.bringup a:link, .bringup a:visited { color:#393;}
.no_bringup a:link, .no_bringup a:visited { color:#676;}
.bringup a:hover, .bringup a:active,
.no_bringup a:hover, .no_bringup a:active { color:#C00;}

/*.bringup img { vertical-align:middle; margin-right:4px;}*/
/*↑育てる↑*/
-->
</style>


</div>

<div style="padding:4px;">
<table width="100%" cellpadding="4" cellspacing="0" class="font10" style="background:#EEE; color:#666; border-bottom:solid 1px #CCC;">
<tr>
<td><img src="http://res.nimg.jp/img/watch/ichiba/icon_ichiko.png" alt=""></td>
<td width="100%"><a href="http://ichiba.nicovideo.jp/" target="_blank" style="color:#666;">ニコニコ市場</a> とは、動画に関連した商品を自由に追加することができるサービスです。<a href="http://ichiba.nicovideo.jp/ranking" target="_blank" style="color:#666;">→ ランキングを見る</a></td>
<td nowrap>Amazon.co.jp アソシエイト</td>
</tr>
</table>
</div>

<!--↑ニコニコ市場↑-->

<!--↑外部プレーヤー：出せない↑-->
		</div>
		<div id="PAGEFOOTER">
		<noscript>
<p class="mb8p4 font12" style="color:#C00;">Javascriptが無効になっていると、サイト内の一部機能がご利用いただけません</p>
</noscript>

<p class="mb8p4"><a href="JavaScript:ANCHOR('PAGETOP')"><img src="http://res.nimg.jp/img/base/foot/pagetop_9.gif" alt="ページトップ"></a></p>

<p class="font12" style="padding:4px; color:#C9CFCF;">
<a href="http://www.nicovideo.jp/video_top">動画トップ</a> … <a target="_blank" href="http://info.nicovideo.jp/base/phishing.html" style="color:#C00;">フィッシング詐欺にご注意！</a> |
<a target="_blank" href="http://info.nicovideo.jp/base/rule.html">利用規約</a> |
<a target="_blank" href="http://info.nicovideo.jp/base/declaration.html">宣言</a> |
<a target="_blank" href="http://info.nicovideo.jp/base/award.html">受賞</a> |
<a target="_blank" href="http://bbs.nicovideo.jp/">掲示板</a> |
<a target="_blank" href="http://help.nicovideo.jp/">ヘルプ</a> |
<a target="_blank" href="http://info.nicovideo.jp/smile/handbook/">動画投稿ハンドブック</a> |
<a href="https://secure.nicovideo.jp/secure/ads_form">広告出稿に関するお問い合わせ</a>
</p>

<p style="padding:4px;"><img src="http://res.nimg.jp/img/base/foot/line.png" alt=""></p>

<p class="mb8p4 font12">
総動画数：<strong style="color:#393F3F;">5,509,161</strong> ／
総再生数：<strong style="color:#393F3F;">22,913,333,474</strong> ／
総コメント数：<strong style="color:#393F3F;">2,958,051,976</strong>
</p>

<p style="padding:4px;"><a href="http://niwango.jp/" target="_blank"><img src="http://res.nimg.jp/img/base/foot/incorporated.gif" alt="&copy; niwango, Inc."></a></p>

<p class="mb8p4"><img src="http://res.nimg.jp/img/base/foot/www.png" alt="WWW" usemap="#WORLDWIDE"></p>
<map name="WORLDWIDE">
<area shape="rect" coords="0,0,18,15"  href="http://www.nicovideo.jp/" alt="Japan">
<area shape="rect" coords="20,0,38,15" href="http://tw.nicovideo.jp/" alt="Taiwan">
<area shape="rect" coords="40,0,58,15" href="http://es.nicovideo.jp/" alt="Spain">
<area shape="rect" coords="60,0,78,15" href="http://de.nicovideo.jp/" alt="German">
</map>

<p class="font10" style="padding:4px;">【推奨環境】<br>
OS：<span style="color:#696F6F;">Windows XP, Vista, 7 &amp; Mac OS X Leopard, Snow Leopard</span>　
ブラウザ：<span style="color:#696F6F;">Internet Explorer, Firefox, Safari(Mac版のみ), 各最新版</span><br>
プラグイン：<span style="color:#696F6F;">Adobe Flash Player 10以降</span>　
その他：<span style="color:#696F6F;">クッキー(cookie)制限をしている場合は nicovideo.jp を許可</span>
</p>		</div>
	</div>
</div>



<!--  -->
</body>
</html>
@@ POST https://secure.nicovideo.jp/secure/login?site=niconico cookies=
HTTP/1.1 302 Found
Connection: close
Date: Fri, 18 Feb 2011 11:59:15 GMT
Location: http://www.nicovideo.jp/watch/sm13465059
Server: Apache
Content-Length: 0
Content-Type: text/html
Client-Peer: 202.248.110.180:443
Client-Response-Num: 1
Client-SSL-Cert-Issuer: /C=JP/O=Cybertrust Japan Co., Ltd./CN=Cybertrust Japan EV CA G2
Client-SSL-Cert-Subject: /1.3.6.1.4.1.311.60.2.1.3=JP/serialNumber=0199-01-052628/2.5.4.15=V1.0, Clause 5.(b)/C=JP/ST=Tokyo/L=Chuo-ku/O=DWANGO Co.,Ltd./OU=cert01/CN=secure.nicovideo.jp
Client-SSL-Cipher: AES128-SHA
Client-SSL-Warning: Peer certificate not verified
Set-Cookie: user_session=deleted; expires=Thu, 18-Feb-2010 11:59:14 GMT
Set-Cookie: user_session=deleted; expires=Thu, 18-Feb-2010 11:59:14 GMT; path=/
Set-Cookie: user_session=deleted; expires=Thu, 18-Feb-2010 11:59:14 GMT; path=/; domain=.nicovideo.jp
Set-Cookie: user_session=user_session_811309_905168232123144541; expires=Sun, 20-Mar-2011 11:59:15 GMT; path=/; domain=.nicovideo.jp
X-Niconico-Authflag: 0
X-Powered-By: PHP/5.2.9


@@ GET http://www.nicovideo.jp/watch/sm13465059 cookies=user_session
HTTP/1.1 200 OK
Cache-Control: no-store, no-cache, must-revalidate, post-check=0, pre-check=0
Connection: close
Date: Fri, 18 Feb 2011 11:59:22 GMT
Pragma: no-cache
Server: Apache
Vary: Accept-Encoding
Content-Language: ja
Content-Length: 37173
Content-Type: text/html
Expires: Thu, 01 Dec 1994 16:00:00 GMT
Client-Peer: 202.248.110.243:80
Client-Response-Num: 1
Client-Transfer-Encoding: chunked
Content-Base: http://www.nicovideo.jp/
Content-Script-Type: text/javascript
Content-Style-Type: text/css
Link: </watch/sm13465059>; rel="canonical"
Link: <http://res.nimg.jp/img/favicon.ico>; rel="shortcut icon"
Link: <http://res.nimg.jp/css/common.css?110210>; charset="utf-8"; rel="stylesheet"; type="text/css"
Link: <http://res.nimg.jp/css/watch.css?110106>; charset="utf-8"; rel="stylesheet"; type="text/css"
Link: <http://res.nimg.jp/css/watch_ichiba.css?110203>; charset="utf-8"; rel="stylesheet"; type="text/css"
Set-Cookie: nicohistory=sm13465059%3A1298030362%3A1298030362%3Af3adc28f6d4c8c53%3A1; expires=Sun, 20-Mar-2011 11:59:22 GMT; path=/; domain=.nicovideo.jp
Title: 【鏡音リン】 Shirley!! 【オリジナル】 ‐ ニコニコ動画(原宿)
X-Meta-Copyright: ? niwango, Inc.
X-Meta-Description: ｜ω｀*）＜ステキよね、おんなのこってステキよね！！　　　　...
X-Meta-Keywords: VOCALOID,鏡音リン,新涼れい,π,Ｎ（仮）,iroha(sasaki),Shirley!!,DEBUTANTE4収録楽曲リンク,かわいいリンうた,リンオリジナル曲
X-Niconico-Authflag: 3
X-Niconico-Id: 811309

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="Content-Script-Type" content="text/javascript">
<meta http-equiv="Content-Style-Type" content="text/css">
<meta name="copyright" content="&copy; niwango, Inc.">

<!---->
<meta name="keywords" content="VOCALOID,鏡音リン,新涼れい,π,Ｎ（仮）,iroha(sasaki),Shirley!!,DEBUTANTE4収録楽曲リンク,かわいいリンうた,リンオリジナル曲">
<meta name="description" content="｜ω｀*）＜ステキよね、おんなのこってステキよね！！　　　　...">
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Cache-Control" content="no-store, no-cache, must-revalidate, post-check=0, pre-check=0">
<meta http-equiv="Expires" content="Thu, 01 Dec 1994 16:00:00 GMT">

<link rel="canonical" href="/watch/sm13465059">
<title>【鏡音リン】 Shirley!! 【オリジナル】 ‐ ニコニコ動画(原宿)</title>
<base href="http://www.nicovideo.jp/">
<link rel="shortcut icon" href="http://res.nimg.jp/img/favicon.ico">

<link rel="stylesheet" type="text/css" charset="utf-8" href="http://res.nimg.jp/css/common.css?110210">











<link rel="stylesheet" type="text/css" charset="utf-8" href="http://res.nimg.jp/css/watch.css?110106">
<link rel="stylesheet" type="text/css" charset="utf-8" href="http://res.nimg.jp/css/watch_ichiba.css?110203">
<script type="text/javascript" src="http://res.nimg.jp/js/lib/prototype.js?1.5.1.1_2"></script>
<script type="text/javascript" src="http://res.nimg.jp/js/common.js?090905"></script>
<script type="text/javascript" src="http://res.nimg.jp/js/swfobject.js?4"></script>
<script type="text/javascript" src="http://res.nimg.jp/js/nicolib.js?100531"></script>
<script type="text/javascript" src="http://res.nimg.jp/js/ads.js?110210"></script>
<script type="text/javascript" src="http://res.nimg.jp/js/__utm.js?080117"></script>
<script type="text/javascript" src="http://res.nimg.jp/js/nicommons.js?1" charset="utf-8"></script>
<script type="text/javascript" src="http://res.nimg.jp/js/nicopedia.js?100203" charset="utf-8"></script>
<script type="text/javascript" src="http://res.nimg.jp/js/lib/jarty.js"></script>
<script type="text/javascript" src="http://res.nimg.jp/js/info_detail.js"></script>
<script type="text/javascript" src="http://res.nimg.jp/js/tag_edit.js?091109" charset="utf-8"></script>
<script type="text/javascript" src="http://res.nimg.jp/js/watch.js?101227" chatset="utf-8"></script>

<script type="text/javascript"><!--

var User = { id: 811309, age: 26, isPremium: true, isOver18: true, isMan: true };
var q = "";
var country = "jp";



Event.observe(document, "keydown", function (event) {
	if (event.keyCode != 116) return;
	document.write('<p style="font-size:12px; text-align:center;">キー操作制限：ブラウザの｢戻る｣ボタンでお戻りください</p>');
	Event.stop(event);
}.bindAsEventListener(window));


--></script>
</head>

<body id="PAGETOP" class="mode_2">
<div id="PAGEHEADMENU">
<!---->
<div class="bg_headmenu" onmouseout="hideOBJ('headmenu_g1'); hideOBJ('headmenu_g2'); return false;"><div class="headmenu_width">

<table height="24" cellpadding="0" cellspacing="4" summary="" class="headmenu" style="float:left;">
<tr>
<td><a href="http://rd.nicovideo.jp/cc/header/uni">ニコニコTOP</a> -
<a href="http://rd.nicovideo.jp/cc/header/nicovideotop" class="disable">動画</a> |
<a href="http://rd.nicovideo.jp/cc/header/seiga">静画</a> |
<a href="http://rd.nicovideo.jp/cc/header/live">生放送</a> |
<a href="http://rd.nicovideo.jp/cc/header/app">アプリ</a>
 …</td>
<td nowrap onmouseover="showOBJ('headmenu_g1');"><span style="color:#C9CFCF; text-decoration:underline;">その他▼</span>
<div id="headmenu_g1" style="position:relative; display:none;" onmouseover="showOBJ('headmenu_g1'); return false;">
	<div class="headmenu_g" onmouseout="hideOBJ('headmenu_g1'); return false;">
	<table cellpadding="0" cellspacing="0">
	<tr valign="top">
	<td>
	<a href="http://rd.nicovideo.jp/cc/header/ch">チャンネル</a>
	<a href="http://rd.nicovideo.jp/cc/header/ichiba">市場</a>
	<a href="http://rd.nicovideo.jp/cc/header/jk">実況</a>
	<a href="http://rd.nicovideo.jp/cc/header/com">コミュ二ティ</a>
	<a href="http://rd.nicovideo.jp/cc/header/chokuhan">ニコニコ直販</a>
	<a href="http://rd.nicovideo.jp/cc/header/nicom">モバイル</a>
	</td>
	<td>
	<a href="http://rd.nicovideo.jp/cc/header/dic">大百科</a>
	<a href="http://rd.nicovideo.jp/cc/header/uad">ニコニ広告</a>
	<a href="http://rd.nicovideo.jp/cc/header/commons">コモンズ</a>
	<a href="http://rd.nicovideo.jp/cc/header/dvd">ニコニコDVD</a>
	<a href="http://rd.nicovideo.jp/cc/header/nicoga">ニコゲー</a>
	<a href="http://rd.nicovideo.jp/cc/header/news">ニュース</a>
	</td>
	</tr>
	</table>
	</div>
</div>
</td>
</tr>
</table>

<table height="24" cellpadding="0" cellspacing="4" summary="" class="headmenu" style="float:right;">
<tr>
<td style="color:#C9CFCF;">プレミアム会員 <strong style="color:#F9FFFF;">motemen</strong> さん</td>
	<td>
| <a href="my/top">マイページ</a>
| <a href="http://rd.nicovideo.jp/cc/header/upload" target="_blank">動画を投稿</a>
| <a href="/ranking" id="menu-ranking">ランキング</a> …</td>
<td nowrap onmouseover="showOBJ('headmenu_g2');"><span style="color:#C9CFCF; text-decoration:underline;">メニュー▼</span>
<div id="headmenu_g2" style="position:relative; display:none;" onmouseover="showOBJ('headmenu_g2'); return false;">
	<div class="headmenu_g" onmouseout="hideOBJ('headmenu_g2'); return false;" style="right:0;">
	<a href="http://rd.nicovideo.jp/cc/header/mylist">マイリスト</a>
	<a href="http://rd.nicovideo.jp/cc/header/watchlist">ウオッチリスト</a>
	<a href="http://rd.nicovideo.jp/cc/header/myvideo">投稿動画</a>
	<a href="http://rd.nicovideo.jp/cc/header/history">視聴履歴</a>
	<a href="http://rd.nicovideo.jp/cc/header/secure">アカウント設定</a>
	<a href="http://rd.nicovideo.jp/cc/header/help">ヘルプ</a>
	<a href="https://secure.nicovideo.jp/secure/logout">ログアウト</a>	</div>
</div>
</td>
<td id="menu_switch">
<a href="#" title="追従(クリックで固定)" id="menu_switch_fixed"  onclick="$(document.body).removeClassName('mode_2').addClassName('mode_1'); Cookie.set('nofix', 1, 1000*60*60*24*365, '.nicovideo.jp', '/'); return false;"><img src="http://res.nimg.jp/img/base/headmenu/mode_2.png" alt="追従"></a>
<a href="#" title="固定(クリックで追従)" id="menu_switch_scroll" onclick="$(document.body).removeClassName('mode_1').addClassName('mode_2'); Cookie.remove('nofix', '.nicovideo.jp', '/'); return false;"><img src="http://res.nimg.jp/img/base/headmenu/mode_1.png" alt="固定"></a>
</td>
</tr>
</table>

<div style="clear:both;"></div><!---->

</div></div><!---->
</div>

<div id="PAGECONTAINER">
	<div id="PAGEMAIN" class="body_984">
		<div id="PAGEHEADER">
		<table width="984" cellspacing="0" cellpadding="4" summary="" style="clear:both;">
<tr>
<td>

<!--↓通常↓-->
<a href="http://www.nicovideo.jp/search/%E5%8E%9F%E5%AE%BF"><script type="text/javascript" src="http://res.nimg.jp/js/head_icon.js"></script></a>
<!--↑通常↑-->
</td>
<td><a href="http://www.nicovideo.jp/video_top" target="_top"><img src="http://res.nimg.jp/img/base/head/logo/hrjk.png" alt="ニコニコ動画"></a></td>
<td width="100%">
<form id="head_search_form" action="/search" method="get" onsubmit="submitSearch(this.action, false); return false;">
<input type="hidden" name="ref">
<input type="hidden" name="track" value="videowatch_search_keyword">
<table cellpadding="0" cellspacing="0" summary=""><tr valign="bottom">
<td><a href="#" class="head_ssw_1" onclick="submitSearch('/search', this); return false;"><img src="http://res.nimg.jp/img/x.gif" style="width:57px;" alt="キーワード" /></a></td>
<td style="padding:0 2px;"><a href="#" class="head_ssw_0" onclick="submitSearch('/tag', this); return false;"><img src="http://res.nimg.jp/img/x.gif" style="width:31px; background-position:-57px 0;" alt="タグ"></a></td>
<td><a href="#" class="head_ssw_0" onclick="submitSearch('/mylist_search', this); return false;"><img src="http://res.nimg.jp/img/x.gif" style="width:55px; background-position:-88px 0;" alt="マイリスト"></a></td>
</tr></table>

<div style="background:#393F3F; width:242px; border:solid 1px #999F9F;"><table cellpadding="0" cellspacing="2" summary=""><tr><td><div class="head_search_input"><input type="text" name="s" id="bar_search" value=""></div></td><td><input name="submit" type="image" src="http://res.nimg.jp/img/base/head/search/submit.png" alt="検索"></td></tr></table></div>

</form>
<script type="text/javascript"><!--
function submitSearch(p, e) {
	var f = $('head_search_form'), s = String.interpret(f.s.value).strip().replace(/%20/g, '+');
	if (s != '') location.href = p + "/" + encodeURIComponent(s) + (f.track ? "?track=" + f.track.value : "");
	else if (e) { f.down('a.head_ssw_1').className = 'head_ssw_0'; e.className = 'head_ssw_1'; f.action = p; f.s.focus(); }
}
--></script>
</td>
<td><div class="ads_468"><!--↓表示してもよい↓-->

<!--↓視聴(watch)↓-->
<div style="position:relative;">
<div id="web_pc_watch"></div>
</div>
<script type="text/javascript"><!--

getRotationAdsFor468x60({
	category: 'vocaloid',
	a: '26',
	s: '0',
	pref: '東京都',
	user: '811309',
	video: 'sm13465059',
	location: 'web_pc_watch'
}, {
}, '勝っても負けてもニコニコ出来ればそれでいい。');

--></script>
<!--↑視聴(watch)↑-->

<!--↑表示してもよい↑-->

</div></td>
</tr>
</table>		</div>
		<div id="PAGEBODY">
		<div id="WATCHHEADER">
<!--↓WATCHHEADER↓-->



<table width="984" cellpadding="4" cellspacing="0">
<tr valign="top">
<td rowspan="2"><div style="width:712px; overflow:hidden;">

<div class="des_2" style="display:none;">
<p class="video_date">
<!--↓通常↓-->
<strong>2011年02月01日 06:03</strong> 投稿のユーザー動画
<span style="color:#C9CFCF;">…</span> <strong>VOCALOID</strong> カテゴリ前日総合順位：264位 ( <a href="ranking_graph/fav/daily/vocaloid/sm13465059?watch_ranking">過去最高：7位</a> )
<!--↑通常↑-->
</p>
</div>

<p class="video_title"><!-- google_ad_section_start -->【鏡音リン】 Shirley!! 【オリジナル】<!-- google_ad_section_end --><a id="video_article" href="#" target="_blank"><img src="http://res.nimg.jp/img/common/icon/dic_off.png" alt="大百科"></a><span id="nicommons"></span></p>

<div class="des_1" style="display:block;">
<p class="font12" style="color:#696F6F;">｜ω｀*）＜ステキよね、おんなのこってステキよね！！  　　　　 　アフターファイヴを元気いっぱいに、... <a href="#" onclick="hideOBJs('des_1'); showOBJs('des_2'); Cookie.set('desopen', '1', 1000*60*60*24*365, '.nicovideo.jp', '/'); return false;" style="color:#C00;">続きを読む</a></p>
</div>

<div class="des_2" style="display:none;">

<p class="font12">この動画は
<!---->
	<a href="http://com.nicovideo.jp/post/sm13465059?watch_compost">コミュニティに登録ができます</a>
	<!---->
</p>

<table width="100%" cellpadding="0" cellspacing="0" id="itab"><tr><td>
<a href="#itab_description" class="in"><div>動画の説明文</div></a>
<a href="#itab_mylist" onclick="getinfo('mylistcomment', '1296507839');"><div>マイリストコメント(47)</div></a>
</td></tr></table>

<div class="info_frm">
<!--↓開閉群↓-->

<!--↓動画説明文↓-->
<div id="itab_description" class="info in">
<p class="font12" style="padding:4px;">
<!-- google_ad_section_start -->
｜ω｀*）＜ステキよね、おんなのこってステキよね！！<br /><br />　　　　 　アフターファイヴを元気いっぱいに、そして時にちょっと切なく過ごす、<br />　　　　 　そんな社会人１年生おにゃのこの歌。　HEY!!（・д・ﾉ）☆ﾉ<br /><br />　　　　　 以前、DEBUTANTE Ⅳに収録された曲です。諸々調整、リテイクしました。<br /><br />　　 　　　イラスト：新涼れい / 動画：Ｎ（仮） / 作詞：シリカ【π＋iroha(sasaki)】<br />　　　　 　π【<a href="http://www.nicovideo.jp/mylist/2181673">mylist/2181673</a>】/ 曲：iroha(sasaki)【<a href="http://www.nicovideo.jp/mylist/3001349">mylist/3001349</a>】<br />　　　　　 皆さんお疲れ様っした！！<br /><br />新涼れいさんのかわゆいおっとりリンちゃんこちら⇒http://www.pixiv.net/member_illust.php?mode=medium&illust_id=16323857<br /><br /><font color="blue">◆</font>2/8　カラオケ音源公開しました～。ご入用の方はどうぞッス。⇒http://xiao-sphere.net/data/shirley_oke.mp3
<!-- google_ad_section_end -->
</p>
</div>
<!--↑動画説明文↑-->

<!--↓マイリストコメント↓-->
<div id="itab_mylist" class="info">
<div id="mylist_comments">
<script type="application/x-jarty" id="info_mylistcomment">
{if $mylistcomments}
<table cellpadding="4" cellspacing="0">
{foreach from=$mylistcomments item="comment"}
<tr>
<td><a href="/user/{$comment.user_id}"><img src="{$comment.thumbnail_url}" alt="" class="mylist_usericon"></a></td>
<td class="mylist_detail">{$comment.description|escape} <span>…</span>
<a href="/user/{$comment.user_id}" style="color:#696F6F;"><strong>{$comment.nickname}</strong></a> さん{if $comment.stamp_exp} <a href="/user/{$comment.user_id}/stamp" style="color:#696F6F;">({$comment.stamp_exp}EXP)</a>{/if} <span>-</span>
<nobr style="color:#999F9F;">{$comment.create_time}</nobr>
</td>
</tr>
{/foreach}
</table>
{else}
<p class="font12" style="color:#999F9F; padding:4px;">マイリストコメントはありません。</p>
{/if}
</script></div>
<p class="font12" style="color:#C9CFCF; text-align:right; padding:4px;">
<a href="mylistcomment/video/sm13465059">マイリストコメント一覧</a> |
<a href="/openlist/sm13465059?watch_openlist">この動画を登録している公開マイリスト</a>
</p>
</div>
<!--↑マイリストコメント↑-->


<!--↓コメント編集↓-->
<div id="itab_edit" class="info">
	<div style="padding:4px;">
	<p class="font12">あなたは以下の項目を編集することができます。</p>

	<ul class="font12" style="margin-top:8px; margin-bottom:0;">
		<!--↓上記以外↓-->
						</ul>

	</div>
</div>
<!--↑コメント編集↑-->

<!--↑開閉群↑-->
</div>

</div>

<!--↓登録タグ↓-->
<div class="tag_edit">
<div id="video_controls"><div id="video_tags">
	<p class="font12">
		<!-- google_ad_section_start -->
		<nobr><img src="http://res.nimg.jp/img/watch/ctg.png" alt="カテゴリ" style="vertical-align:middle; margin-right:2px;"><a href="tag/VOCALOID" rel="tag" class="nicopedia">VOCALOID</a>&nbsp;</nobr>
		<nobr><a href="tag/%E9%8F%A1%E9%9F%B3%E3%83%AA%E3%83%B3" rel="tag" class="nicopedia">鏡音リン</a>&nbsp;</nobr>
		<nobr><a href="tag/%E6%96%B0%E6%B6%BC%E3%82%8C%E3%81%84" rel="tag" class="nicopedia">新涼れい</a>&nbsp;</nobr>
		<nobr><a href="tag/%CF%80" rel="tag" class="nicopedia">π</a>&nbsp;</nobr>
		<nobr><a href="tag/%EF%BC%AE%EF%BC%88%E4%BB%AE%EF%BC%89" rel="tag" class="nicopedia">Ｎ（仮）</a>&nbsp;</nobr>
		<nobr><a href="tag/iroha%28sasaki%29" rel="tag" class="nicopedia">iroha(sasaki)</a>&nbsp;</nobr>
		<nobr><a href="tag/Shirley%21%21" rel="tag" class="nicopedia">Shirley!!</a>&nbsp;</nobr>
		<nobr><a href="tag/DEBUTANTE4%E5%8F%8E%E9%8C%B2%E6%A5%BD%E6%9B%B2%E3%83%AA%E3%83%B3%E3%82%AF" rel="tag" class="nicopedia">DEBUTANTE4収録楽曲リンク</a>&nbsp;</nobr>
		<nobr><a href="tag/%E3%81%8B%E3%82%8F%E3%81%84%E3%81%84%E3%83%AA%E3%83%B3%E3%81%86%E3%81%9F" rel="tag" class="nicopedia">かわいいリンうた</a>&nbsp;</nobr>
		<nobr><a href="tag/%E3%83%AA%E3%83%B3%E3%82%AA%E3%83%AA%E3%82%B8%E3%83%8A%E3%83%AB%E6%9B%B2" rel="tag" class="nicopedia">リンオリジナル曲</a>&nbsp;</nobr>
		<!-- google_ad_section_end -->
		<nobr><a href="javascript:startTagEdit('http://www.nicovideo.jp/tag_edit/sm13465059');" style="color:#C00;">【編集】</a></nobr>	</p>
	</div></div>
</div>
<script type="text/javascript"><!--
Nicopedia.WRITTEN_LINK.template =
'<a href="#{link}" target="_blank" title="大百科 #{title} の記事を読む"><img alt="" class="txticon" src="http://res.nimg.jp/img/common/icon/dic_on.png"></a>';
Nicopedia.NONEXIST_LINK.template =
'<a href="#{link}" target="_blank" title="大百科 #{title} の記事を書く"><img alt="" class="txticon" src="http://res.nimg.jp/img/common/icon/dic_off.png"></a>';
--></script>
<!--↑登録タグ↑-->

</div></td>
<td><div style="width:256px; overflow:hidden;">

<div class="des_1" style="display:block;">
<p style="text-align:right;"><a href="#" onclick="hideOBJs('des_1'); showOBJs('des_2'); Cookie.set('desopen', '1', 1000*60*60*24*365, '.nicovideo.jp', '/'); return false;"><img src="http://res.nimg.jp/img/watch/btn_info_open.png" alt="開く"></a></p>
</div>

<div class="des_2" style="display:none;">
<p style="text-align:right;"><a href="#" onclick="showOBJs('des_1'); hideOBJs('des_2'); Cookie.set('desopen', '0', 1000*60*60*24*365, '.nicovideo.jp', '/'); return false;"><img src="http://res.nimg.jp/img/watch/btn_info_close.png" alt="閉じる"></a></p>

<div class="owner_prof">
<!---->
<!---->
<table width="240" cellpadding="0" cellspacing="4">
<tr>
<td>
<a href="user/351409"><img src="http://usericon.nimg.jp/usericon/35/351409.jpg?1297351022" alt="iroha(sasaki)" class="img_sq48"></a>
</td>
<td width="100%">
<p class="font10" style="margin:0 0 2px;">ユーザー：</p>

<!--↓user↓-->
<p class="font12"><a href="user/351409"><strong>iroha(sasaki)</strong></a> <a href="user/351409/stamp">(33EXP)</a></p>
	<!--×本人-->
	<p id="watchitem_mente" style="display:none;">ウオッチリスト登録はメンテナンス中です</p>
	<p id="addWatchlist" style="display:none;"><a href="#" onclick="addWatchlist('351409', '811309-1298033962-fa73b4136f80db4ef897f233b10e7c92fe41979b'); return false;"><img src="http://res.nimg.jp/img/x.gif" alt="ウオッチリストに登録" title="登録すると更新情報が受け取れます"></a></p>
	<p id="addedWatchlist" style="display:none;">ウオッチリスト登録済みです</p>
	<script type="text/javascript"><!--
		$('addWatchlist').style.display = 'block';
		--></script>
	<!--↑user↑-->
</td>
</tr>
</table>
<!---->
</div>

</div>

</div></td>
</tr>
<tr valign="bottom"><td>

<div style="position:relative;"><div id="MSG_deflist" style="display:none;">
	<p id="MSG_deflist_loading">登録中です…</p>
	<p id="MSG_deflist_success"><a href="/my/mylist" style="color:#FFF;">｢とりあえずマイリスト｣ に登録しました</a></p>
	<p id="MSG_deflist_error"></p>
</div></div>

<nobr><a href="http://uad.nicovideo.jp/ads/?vid=sm13465059&video_watch" target="_blank"><img src="http://res.nimg.jp/img/watch/my_btn/uad_1.png" alt="ニコニ広告で宣伝"></a><a href="/mylist_add/video/sm13465059" target="_blank" onclick="return !window.open('/mylist_add/video/sm13465059', 'nicomylistadd', 'width=500,height=360');"><img src="http://res.nimg.jp/img/watch/my_btn/mylist_1.png" alt="マイリスト登録"></a><a href="javascript:void(0);" id="BTN_add_deflist" onclick="addVideoToDeflist(1296507839, '811309-1298116762-0c93f83cf443d6861181a1f5c00286bf23b90def'); return false;"><img src="http://res.nimg.jp/img/watch/my_btn/default_1.png" alt="とりあえず一発登録"></a></nobr>

</td></tr>
</table>

<script type="text/javascript"><!--
checkVideoArticle('sm13465059');
var cont = $$('.info_frm .info'), act = 'in';
$$('#itab td a').each(function(el) {
	el.observe('click', function(e) {
		Event.stop(e);
		var id = el.readAttribute('href').replace('#', '');
		if (el.hasClassName(act)) {
			return;
		}
		$$('#itab td a').each(function(elm) {
			elm.removeClassName(act);
		});
		el.addClassName(act);
		cont.each(function(elm) {
			elm[(elm.id == id ? 'add' : 'remove') + 'ClassName'](act);
		});
	});
});

function showOBJs(class_name) {
	$$('.'+class_name).each(function(el) {
		el.style.display = 'block';
	});
}

function hideOBJs(class_name) {
	$$('.'+class_name).each(function(el) {
		el.style.display = 'none';
	});
}
--></script>

<!--↑WATCHHEADER↑-->
</div>


<!---->

<script type="text/javascript"><!--
var Video = {
	v:		'sm13465059',
	id:		'sm13465059',
	tags:		['VOCALOID' ,'\u93e1\u97f3\u30ea\u30f3' ,'\u65b0\u6dbc\u308c\u3044' ,'\u03c0' ,'\uff2e\uff08\u4eee\uff09' ,'iroha(sasaki)' ,'Shirley!!' ,'DEBUTANTE4\u53ce\u9332\u697d\u66f2\u30ea\u30f3\u30af' ,'\u304b\u308f\u3044\u3044\u30ea\u30f3\u3046\u305f' ,'\u30ea\u30f3\u30aa\u30ea\u30b8\u30ca\u30eb\u66f2' ],
	lockedTags:		['VOCALOID' ,'\u93e1\u97f3\u30ea\u30f3' ,'\u65b0\u6dbc\u308c\u3044' ,'\u03c0' ,'\uff2e\uff08\u4eee\uff09' ],
	title:		'\u3010\u93e1\u97f3\u30ea\u30f3\u3011 Shirley!! \u3010\u30aa\u30ea\u30b8\u30ca\u30eb\u3011',
	description:		'\uff5c\u03c9\uff40*\uff09\uff1c\u30b9\u30c6\u30ad\u3088\u306d\u3001\u304a\u3093\u306a\u306e\u3053\u3063\u3066\u30b9\u30c6\u30ad\u3088\u306d\uff01\uff01<br \/><br \/>\u3000\u3000\u3000\u3000 \u3000\u30a2\u30d5\u30bf\u30fc\u30d5\u30a1\u30a4\u30f4\u3092\u5143\u6c17\u3044\u3063\u3071\u3044\u306b\u3001\u305d\u3057\u3066\u6642\u306b\u3061\u3087\u3063\u3068\u5207\u306a\u304f\u904e\u3054\u3059\u3001<br \/>\u3000\u3000\u3000\u3000 \u3000\u305d\u3093\u306a\u793e\u4f1a\u4eba\uff11\u5e74\u751f\u304a\u306b\u3083\u306e\u3053\u306e\u6b4c\u3002\u3000HEY!!\uff08\u30fb\u0434\u30fb\uff89\uff09\u2606\uff89<br \/><br \/>\u3000\u3000\u3000\u3000\u3000 \u4ee5\u524d\u3001DEBUTANTE \u2163\u306b\u53ce\u9332\u3055\u308c\u305f\u66f2\u3067\u3059\u3002\u8af8\u3005\u8abf\u6574\u3001\u30ea\u30c6\u30a4\u30af\u3057\u307e\u3057\u305f\u3002<br \/><br \/>\u3000\u3000 \u3000\u3000\u3000\u30a4\u30e9\u30b9\u30c8\uff1a\u65b0\u6dbc\u308c\u3044 \/ \u52d5\u753b\uff1a\uff2e\uff08\u4eee\uff09 \/ \u4f5c\u8a5e\uff1a\u30b7\u30ea\u30ab\u3010\u03c0\uff0biroha(sasaki)\u3011<br \/>\u3000\u3000\u3000\u3000 \u3000\u03c0\u3010<a href=\"http:\/\/www.nicovideo.jp\/mylist\/2181673\">mylist\/2181673<\/a>\u3011\/ \u66f2\uff1airoha(sasaki)\u3010<a href=\"http:\/\/www.nicovideo.jp\/mylist\/3001349\">mylist\/3001349<\/a>\u3011<br \/>\u3000\u3000\u3000\u3000\u3000 \u7686\u3055\u3093\u304a\u75b2\u308c\u69d8\u3063\u3057\u305f\uff01\uff01<br \/><br \/>\u65b0\u6dbc\u308c\u3044\u3055\u3093\u306e\u304b\u308f\u3086\u3044\u304a\u3063\u3068\u308a\u30ea\u30f3\u3061\u3083\u3093\u3053\u3061\u3089\u21d2http:\/\/www.pixiv.net\/member_illust.php?mode=medium&illust_id=16323857<br \/><br \/><font color=\"blue\">\u25c6<\/font>2\/8\u3000\u30ab\u30e9\u30aa\u30b1\u97f3\u6e90\u516c\u958b\u3057\u307e\u3057\u305f\uff5e\u3002\u3054\u5165\u7528\u306e\u65b9\u306f\u3069\u3046\u305e\u30c3\u30b9\u3002\u21d2http:\/\/xiao-sphere.net\/data\/shirley_oke.mp3',
	thumbnail:		'http:\/\/tn-skr4.smilevideo.jp\/smile?i=13465059',
	postedAt:		'2011/02/01 06:03:59',
	length:		298,
	viewCount:		35812,
	mylistCount:		4349,
	mainCommunityId:		null,
	communityId:		null,
	channelId:		null,
	isDeleted:		false,
	isMymemory:		false,
	isMonetized:		false,
	isR18:		false};
--></script>

<div id="flvplayer_container">
	<div id="flvplayer_container_loading" style="margin-top:200px; color:#666;">
		<script type="text/javascript"><!--
			document.write('<p class="font14">動画プレーヤーを準備しています…</p>');
			document.write('<p class="font10" style="margin-top:16px;">いつまで経っても再生が始まらない場合は、ページを再読み込みしてください。</p>');
		--></script>
	</div>
	<div id="flvplayer_container_install" style="display:none;">
		<p><img src="http://res.nimg.jp/img/watch/player/install_flashplayer.png" alt="Flash Player のインストールページへ" usemap="#install-map"></p>
		<map name="install-map" id="install-map"><area shape="rect" coords="128,250,848,330" href="http://www.adobe.com/go/getflashplayer"></map>
		<p class="font12" style="margin-top:-30px;">※ Adobe Flash Player の最新版をインストールしているにも関わらず、このご案内が表示され続ける場合は <a href="http://help.nicovideo.jp/cat21/flash_player.html">こちらのヘルプ</a>　をご覧ください。</p>
	</div>
	<div id="flvplayer_container_error_no_swfobject" style="display:none; margin-top:80px;">
		<h3 style="color:#C00;">動画プレーヤーを表示できませんでした</h3>
		<p class="font12">以下の原因が考えられます。ご確認ください。</p>
		<ul class="font12" style="border: 1px solid #CCC; padding: 10px 10px 10px 30px; width:400px; margin: 10px auto; text-align:left;">
			<li>お使いのセキュリティソフト ( アンチウィルスソフトやファイヤーウォールソフト等 ) の設定により、 <strong>http://res.nimg.jp/</strong> への通信がブロックされている可能性がございます。詳しくは <a href="http://info.nicovideo.jp/help/player/faq/?watch_faq#q03">セキュリティソフトについて</a> をご覧ください。</li>
			<li>アクセスが集中しているなどの理由で、ページの読み込みに失敗した可能性がございます。ニコニコ動画の障害情報につきましては、<a href="http://blog.nicovideo.jp/niconews/">ニコニコインフォ</a>をご覧ください。</li>
		</ul>
	</div>
	<noscript>
		<h3 style="color:#C00;">JavaScript が無効になっているため、動画プレーヤーを表示できません</h3>
	</noscript>
</div>

<script type="text/javascript"><!--

if (typeof SWFObject === "undefined") {
	var element;
	if (element = document.getElementById("flvplayer_container_loading")) {
		element.style.display = "none";
		if (element = document.getElementById("flvplayer_container_error_no_swfobject")) {
			element.style.display = "block";
		}
	}
} else {
	var so = new SWFObject("http://res.nimg.jp/swf/player/nicoplayer.swf?ts=1297236531", "flvplayer", "976", "504", 10, "#FFFFFF");

	so.addVariable("button_threshold", "0");
	so.addVariable("thumbTitle", "%E3%80%90%E9%8F%A1%E9%9F%B3%E3%83%AA%E3%83%B3%E3%80%91%20Shirley%21%21%20%E3%80%90%E3%82%AA%E3%83%AA%E3%82%B8%E3%83%8A%E3%83%AB%E3%80%91");
	so.addVariable("thumbDescription", "%EF%BD%9C%CF%89%EF%BD%80%2A%EF%BC%89%EF%BC%9C%E3%82%B9%E3%83%86%E3%82%AD%E3%82%88%E3%81%AD%E3%80%81%E3%81%8A%E3%82%93%E3%81%AA%E3%81%AE%E3%81%93%E3%81%A3%E3%81%A6%E3%82%B9%E3%83%86%E3%82%AD%E3%82%88%E3%81%AD%EF%BC%81%EF%BC%81%E3%80%80%E3%80%80%E3%80%80...");
	so.addVariable("videoTitle", "%E3%80%90%E9%8F%A1%E9%9F%B3%E3%83%AA%E3%83%B3%E3%80%91%20Shirley%21%21%20%E3%80%90%E3%82%AA%E3%83%AA%E3%82%B8%E3%83%8A%E3%83%AB%E3%80%91");
	so.addVariable("player_version_xml", "1297845321");
	so.addVariable("player_info_xml", "1291871766");
	so.addVariable("marqueeVersion", "1294802479");
	so.addVariable("userPrefecture", "13");
	so.addVariable("csrfToken", "811309-1298116762-0c93f83cf443d6861181a1f5c00286bf23b90def");
	so.addVariable("v", "sm13465059");
	so.addVariable("videoId", "sm13465059");
	so.addVariable("deleted", "0");
	so.addVariable("mylist_counter", "4349");
	so.addVariable("mylistcomment_counter", "47");
	so.addVariable("movie_type", "mp4");
	so.addVariable("thumbImage", "http%3A%2F%2Ftn-skr4.smilevideo.jp%2Fsmile%3Fi%3D13465059");
	so.addVariable("videoUserId", "351409");
	so.addVariable("userSex", "0");
	so.addVariable("userAge", "26");
	so.addVariable("us", "0");
	so.addVariable("ad", "web_pc_player_marquee");
	so.addVariable("iee", "1");
	so.addVariable("communityPostURL", "http%3A%2F%2Fcom.nicovideo.jp%2Fpost%2Fsm13465059%3Fplayer_icon");
	so.addVariable("dicArticleURL", "http%3A%2F%2Fdic.nicovideo.jp%2Fv%2Fsm13465059");
	so.addVariable("blogEmbedURL", "%2Fembed%2Fsm13465059%3Fplayer_icon");
	so.addVariable("uadAdvertiseURL", "http%3A%2F%2Fuad.nicovideo.jp%2Fads%2F%3Fvid%3Dsm13465059%26player_icon1");
	so.addVariable("category", "VOCALOID");
	so.addVariable("categoryGroupKey", "g_popular");
	so.addVariable("categoryGroup", "%E6%AE%BF%E5%A0%82%E5%85%A5%E3%82%8A%E3%82%AB%E3%83%86%E3%82%B4%E3%83%AA");
	so.addVariable("isWide", "1");
	so.addVariable("wv_id", "sm13465059");
	so.addVariable("wv_title", "%E3%80%90%E9%8F%A1%E9%9F%B3%E3%83%AA%E3%83%B3%E3%80%91%20Shirley%21%21%20%E3%80%90%E3%82%AA%E3%83%AA%E3%82%B8%E3%83%8A%E3%83%AB%E3%80%91");
	so.addVariable("wv_code", "03a8f9e9");
	so.addVariable("wv_time", "1298030362");
	so.addVariable("leaf_switch", "0");

	so.addParam("allowScriptAccess", "always");
	so.addParam("allowFullScreen", "true");
	if (so.write("flvplayer_container")) {
		
	} else {
		$("flvplayer_container_loading") && $("flvplayer_container_loading").hide();
		$("flvplayer_container_install") && $("flvplayer_container_install").show();
	}
}

--></script>



<div id="WATCHFOOTER">
<!--↓footer↓-->


<!---->
<form action="/mymemory_register" method="post" id="mymemory_add_form" name="mymemory_register">
<input type="hidden" name="thread_id" value="1296507839">
<input type="hidden" name="date" value="">
</form>
<table width="984" cellpadding="4" cellspacing="0">
<tr valign="top">
<td width="100%" class="font12" style="color:#CCC;">
<nobr><a href="http://info.nicovideo.jp/help/player/howto/?watch_howto" target="_blank">プレーヤーの使い方</a></nobr>
| <nobr><a href="http://info.nicovideo.jp/help/player/faq/?watch_faq" target="_blank">よくあるご質問</a></nobr>
| <nobr><a href="http://bbs.nicovideo.jp/delete/comment/"  target="_blank">コメントを報告</a></nobr>
| <nobr><a href="http://www.smilevideo.jp/view/13465059/811309" target="_blank">この動画を報告</a></nobr>
| <nobr><a href="watch/sm13465059?lo=1">一般回線で視聴</a></nobr>
</td>
<td id="outside" nowrap><a href="/mymemory_register" onClick="document.mymemory_register.submit(); return false;" style="margin-right:4px;"><img src="http://res.nimg.jp/img/watch/outside/mymemory.png" alt="マイメモリー保存"></a><!----><a href="http://profile.live.com/badge/?url=http%3A%2F%2Fnico.ms%2Fsm13465059&title=%E3%80%90%E9%8F%A1%E9%9F%B3%E3%83%AA%E3%83%B3%E3%80%91%20Shirley%21%21%20%E3%80%90%E3%82%AA%E3%83%AA%E3%82%B8%E3%83%8A%E3%83%AB%E3%80%91&description=%E3%83%8B%E3%82%B3%E3%83%8B%E3%82%B3%E5%8B%95%E7%94%BB%E3%81%AE%E5%8B%95%E7%94%BB%E3%81%A7%E3%81%99&screenshot=http%3A%2F%2Ftn-skr4.smilevideo.jp%2Fsmile%3Fi%3D13465059" target="_blank" style="margin-right:4px;"><img src="http://res.nimg.jp/img/watch/outside/messenger2.png" alt="Live Messenger で共有"></a><a href="/embed/sm13465059" target="_blank" style="margin-right:4px;"><img src="http://res.nimg.jp/img/watch/outside/blog.png" alt="外部サイトに貼付"></a><!--↓mixicheck↓--><a href="http://mixi.jp/share.pl" class="mixi-check-button" data-key="c5b8be882b1493e926aaf35decf85acd6e51dc72" style="margin-right:4px;">Check</a><script type="text/javascript" src="http://static.mixi.jp/js/share.js"></script><!--↑mixicheck↑--><a href="http://twitter.com/share" class="twitter-share-button" data-text="【鏡音リン】 Shirley!! 【オリジナル】 (4:58) #nicovideo #sm13465059" data-url="http://nico.ms/sm13465059" data-counturl="http://www.nicovideo.jp/watch/sm13465059" data-count="none">Tweet</a></td>
</tr>
</table>
<!---->

<!---->
<div class="tag_sync"><!--10-->
<!---->

<!---->


<!---->
<!---->


<!---->
<!---->


<!---->
<!---->


<!---->
<!---->


<!---->
<!---->


<!---->
<!---->


<!---->
<!---->


<!---->
<!---->


<!---->
<!---->


<!---->

<!---->

<!---->
<p class="watch_tag_sync"><a href="http://rd.nicovideo.jp/cc/tag/mikupa" target="blank"><img src="/img/watch/tag_sync/600-40_bana.jpg" alt="ミクパ♪"></a></p>


<!---->

<!---->
</div>
<!---->




<!---->
<script type="text/javascript"><!--
var user_id  = User.id.toString();
var video_id = 'sm13465059';
--></script>
<script type="text/javascript" charset="utf-8" defer="defer" src="http://res.nimg.jp/js/ichiba.js?rev=20100805"></script>

<div id="ichiba_placeholder" style="padding:8px 0;">
<h3 style="color:#F60; text-align:center; padding:4px;">ニコニコ市場を読み込んでいます…</h3>
</div>

<div style="padding:4px;">
<table width="100%" cellpadding="4" cellspacing="0" class="font10" style="background:#EEE; color:#666; border-bottom:solid 1px #CCC;">
<tr>
<td><img src="http://res.nimg.jp/img/watch/ichiba/icon_ichiko.png" alt=""></td>
<td width="100%"><a href="http://ichiba.nicovideo.jp/" target="_blank" style="color:#666;">ニコニコ市場</a> とは、動画に関連した商品を自由に追加することができるサービスです。<a href="http://ichiba.nicovideo.jp/ranking" target="_blank" style="color:#666;">→ ランキングを見る</a></td>
<td nowrap>Amazon.co.jp アソシエイト</td>
</tr>
</table>
</div>



<!---->
<!--↓視聴↓--><!--↑視聴↑-->


<div class="ads_728_google">
<script type="text/javascript"><!--
google_language = 'ja';
google_encoding = 'utf-8';
google_ad_client = "pub-1828667301391598";
google_ad_slot = "4832070754";
google_ad_width = 728;
google_ad_height = 90;

if (User && User.isMan !== null) {
	google_cust_gender = User.isMan ? 1 : 2;
}
if (User && User.age !== false) {
	var ageRanges = { 1000:17, 1001:24, 1002:34, 1003:44, 1004:54, 1005:64, 1006:Infinity };
	google_cust_age = $H(ageRanges).find(function (p) { return User.age <= p[1] }).key;
}

--></script>
<script type="text/javascript" src="http://pagead2.googlesyndication.com/pagead/show_ads.js"></script>
</div>
<!---->

<!--↑footer↑-->
</div>

<script async="async" defer="defer" type="text/javascript" src="http://platform.twitter.com/widgets.js"></script>		</div>
		<div id="PAGEFOOTER">
		<noscript>
<p class="mb8p4 font12" style="color:#C00;">Javascriptが無効になっていると、サイト内の一部機能がご利用いただけません</p>
</noscript>

<p class="mb8p4"><a href="JavaScript:ANCHOR('PAGETOP')"><img src="http://res.nimg.jp/img/base/foot/pagetop_9.gif" alt="ページトップ"></a></p>

<p class="font12" style="padding:4px; color:#C9CFCF;">
<a href="http://www.nicovideo.jp/video_top">動画トップ</a> … <a target="_blank" href="http://info.nicovideo.jp/base/phishing.html" style="color:#C00;">フィッシング詐欺にご注意！</a> |
<a target="_blank" href="http://info.nicovideo.jp/base/rule.html">利用規約</a> |
<a target="_blank" href="http://info.nicovideo.jp/base/declaration.html">宣言</a> |
<a target="_blank" href="http://info.nicovideo.jp/base/award.html">受賞</a> |
<a target="_blank" href="http://bbs.nicovideo.jp/">掲示板</a> |
<a target="_blank" href="http://help.nicovideo.jp/">ヘルプ</a> |
<a target="_blank" href="http://info.nicovideo.jp/smile/handbook/">動画投稿ハンドブック</a> |
<a href="https://secure.nicovideo.jp/secure/ads_form">広告出稿に関するお問い合わせ</a>
</p>

<p style="padding:4px;"><img src="http://res.nimg.jp/img/base/foot/line.png" alt=""></p>

<p class="mb8p4 font12">
総動画数：<strong style="color:#393F3F;">5,509,161</strong> ／
総再生数：<strong style="color:#393F3F;">22,913,333,474</strong> ／
総コメント数：<strong style="color:#393F3F;">2,958,051,976</strong>
</p>

<p style="padding:4px;"><a href="http://niwango.jp/" target="_blank"><img src="http://res.nimg.jp/img/base/foot/incorporated.gif" alt="&copy; niwango, Inc."></a></p>

<p class="mb8p4"><img src="http://res.nimg.jp/img/base/foot/www.png" alt="WWW" usemap="#WORLDWIDE"></p>
<map name="WORLDWIDE">
<area shape="rect" coords="0,0,18,15"  href="http://www.nicovideo.jp/" alt="Japan">
<area shape="rect" coords="20,0,38,15" href="http://tw.nicovideo.jp/" alt="Taiwan">
<area shape="rect" coords="40,0,58,15" href="http://es.nicovideo.jp/" alt="Spain">
<area shape="rect" coords="60,0,78,15" href="http://de.nicovideo.jp/" alt="German">
</map>

<p class="font10" style="padding:4px;">【推奨環境】<br>
OS：<span style="color:#696F6F;">Windows XP, Vista, 7 &amp; Mac OS X Leopard, Snow Leopard</span>　
ブラウザ：<span style="color:#696F6F;">Internet Explorer, Firefox, Safari(Mac版のみ), 各最新版</span><br>
プラグイン：<span style="color:#696F6F;">Adobe Flash Player 10以降</span>　
その他：<span style="color:#696F6F;">クッキー(cookie)制限をしている場合は nicovideo.jp を許可</span>
</p>		</div>
	</div>
</div>



<!-- 811309:1298030362:{"site":"nicovideo"}:1:4f70c5948683ef2752944878dd253800ac16ddfe -->
</body>
</html>
@@ GET http://flapi.nicovideo.jp/api/getflv?v=sm13465059&ts=1298030285&as3=1 cookies=user_session
HTTP/1.1 200 OK
Connection: close
Date: Fri, 18 Feb 2011 11:59:22 GMT
Server: Apache
Vary: negotiate
Content-Length: 1035
Content-Location: getflv.php
Content-Type: text/plain
Access-Control-Allow-Credentials: true
Client-Peer: 202.248.110.159:80
Client-Response-Num: 1
TCN: choice
X-Niconico-Authflag: 3
X-Niconico-Id: 811309
X-Powered-By: PHP/5.2.9

thread_id=1296507839&l=298&url=http%3A%2F%2Fsmile-pow41.nicovideo.jp%2Fsmile%3Fm%3D13465059.59687&link=http%3A%2F%2Fwww.smilevideo.jp%2Fview%2F13465059%2F811309&ms=http%3A%2F%2Fmsg.nicovideo.jp%2F25%2Fapi%2F&user_id=811309&is_premium=1&nickname=motemen&time=1298030362&done=true&hms=hiroba04.nicovideo.jp&hmsp=2529&hmst=1000000065&hmstk=1298030422.Qvg3QcHn7QsUORXEZzbgvIM4v4g&rpu=%7B%22count%22%3A1142827%2C%22users%22%3A%5B%22%5Cu30de%5Cu30b0%5Cu30ca%22%2C%22%5Cu3059%5Cu3089%5Cu3044%5Cu3059%22%2C%22%5Cu65b0%5Cu8c37%5Cu30d7%5Cu30ea%5Cu30f3%22%2C%22Sek%40i%22%2C%22zukki%22%2C%22%5Cu308a%5Cu3087%5Cu3046%22%2C%22%5Cu685c%5Cu4e59%5Cu91cc%22%2C%22%5Cu307f%5Cu3075%22%2C%22%5Cu30ad%5Cu30e2%5Cu30f3%5Cuff1d%5Cu30ab%5Cu30c3%5Cu30b7%5Cu30e5%22%2C%22punch%22%2C%22PonTime%21%21%22%2C%22yamamama%22%2C%22meinl2000%22%2C%22crushman%22%2C%22%5Cu3072%5Cu308d%5Cu307f%22%2C%22%5Cu306a%5Cu3064%5Cu3081%5Cu3050%22%2C%22%5Cu30a6%5Cu30a4%5Cu30f3%5Cu30c1%22%2C%22%5Cu30de%5Cu30ea%5Cu30e2%22%2C%22%5Cu3057%5Cu3043%22%2C%22mai%22%5D%2C%22extra%22%3A6%7D
