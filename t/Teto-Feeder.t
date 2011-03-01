use strict;
use utf8;
use Test::More;
use LWPx::Record::DataSection record_response_header => [ 'Content-Base' ];

use_ok 'Teto::Feeder';

subtest 'Hatena Bookmark' => sub {
    my $feeder = new_ok 'Teto::Feeder', [ url => 'http://b.hatena.ne.jp/motemen/?url=http://www.nicovideo.jp/', autopagerize => 0 ];
    $feeder->feed;

    is $feeder->title, q(はてなブックマーク - en.vio.us - www.nicovideo.jp), 'title';
    is $feeder->image, q(http://www.st-hatena.com/users/mo/motemen/profile.gif), 'image';
};

subtest 'SoundCloud' => sub {
    my $feeder = new_ok 'Teto::Feeder', [ url => 'http://soundcloud.com/kkshow', autopagerize => 0 ];
    $feeder->feed;

    is $feeder->title, q(kkshow's sounds on SoundCloud - Create, record and share your sounds for free), 'title';
    like $feeder->image, qr(^http://i1\.soundcloud\.com/avatars-000000654375-agqsuw-large\.jpg), 'image';
};

subtest 'Nicovideo tag' => sub { TODO: {
    my $feeder = new_ok 'Teto::Feeder', [ url => 'http://www.nicovideo.jp/tag/VOCALOID', autopagerize => 0 ];
    $feeder->feed;
    is scalar @{$feeder->tracks}, 31;
} };

done_testing;

__DATA__

@@ GET http://b.hatena.ne.jp/motemen/?url=http://www.nicovideo.jp/
HTTP/1.1 200 OK
Connection: close
Date: Sun, 27 Feb 2011 14:59:27 GMT
Server: Apache/2.2.3 (CentOS)
Vary: Accept-Encoding
Content-Length: 213014
Content-Type: text/html; charset=utf-8

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ja" lang="ja">
<head>
<script type="text/javascript">
var __rendering_time = (new Date).getTime();
</script>
<title>はてなブックマーク - en.vio.us - www.nicovideo.jp</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Script-Type" content="text/javascript" />
<meta http-equiv="Content-Style-Type" content="text/css" />
<meta name="msapplication-navbutton-color" content="#2C6EBD" />
<meta name="msapplication-task" content="name=はてなブックマーク; action-uri=/; icon-uri=/images/icons/bookmark.ico" />
<meta name="msapplication-task" content="name=マイブックマーク; action-uri=/my; icon-uri=/images/icons/my-bookmark.ico" />
<meta name="msapplication-task" content="name=お気に入りのブックマーク; action-uri=/my/favorite; icon-uri=/images/icons/favorite-bookmark.ico" />
<meta name="msapplication-task" content="name=人気エントリー; action-uri=/hotentry; icon-uri=/images/icons/hotentry.ico" />
<link rel="shortcut icon" type="image/x-icon" href="http://b.hatena.ne.jp/favicon.ico" />
<link rel="search" type="application/opensearchdescription+xml" title="はてなブックマーク検索" href="/opensearch.xml" />
<link rel="stylesheet" href="http://cdn-ak.b.st-hatena.com/css/common.css?4aa794135721d197f627c1abd16644ce06770359" type="text/css" media="all" />
<link rel="search" type="application/opensearchdescription+xml" title="en.vio.us / www.nicovideo.jp (162)内検索" href="/motemen/opensearch.xml" />
<link rel="stylesheet" href="http://cdn-ak.b.st-hatena.com/css/users.css?c8befab3c03bffec98a1ce28523fb781eaa2d7ae" type="text/css" media="all" />
<link rel="stylesheet" href="http://cdn-ak.b.st-hatena.com/css/bookmark.css?4aa794135721d197f627c1abd16644ce06770359" type="text/css" media="all" />
<link rel="stylesheet" href="http://cdn-ak.b.st-hatena.com/css/user_design.css?4aa794135721d197f627c1abd16644ce06770359" type="text/css" media="all" />
<link rel="stylesheet" href="http://cdn-ak.b.st-hatena.com/css/theme/gray.css?4aa794135721d197f627c1abd16644ce06770359" type="text/css" media="all" />
<link rel="next" href="?url=http%3A%2F%2Fwww.nicovideo.jp%2F&amp;of=20" title="次のページ" />
  <script type="text/javascript" src="http://cdn-ak.b.st-hatena.com/js/HatenaStar.js?53d1420e56d821515db9f9b2a7a80324f5b6a6e4"></script>
<link rel="alternate" type="application/rss+xml" title="RSS" href="http://b.hatena.ne.jp/motemen/rss" />
<link rel="alternate" type="text/html" media="handheld" href="http://b.hatena.ne.jp/motemen/bookmarkmobile" />
<style type="text/css">

       body {
         background-repeat:repeat;
background-position:top left;
background-image:none;

       }
    .comment-background-color,
#bookmarked_user  li div.curvebox-body,
ul.menu li a {
    background-color: #36403C; 
}

.link-color-visited,
#hatena-body a:visited {
    color: #14CCA9; 
}

.link-color,
#hatena-body a,
ul.menu li a:link,
ul.menu li a:visited,
ul.menu li a:hover,
#hatena-body ul.threshold li a,
#hatena-body ul.watch-term-list li a:visited {
    color: #14CCA9; 
}

div.hatena-module-body ul.watch-term-list li.selected {
    background: #36403C; 
}

.sidebar-background-color,
#hatena-body ul.threshold li.selected a,
#hatena-body div.sidebar div.hatena-module-title h3,
#hatena-bookmark-user-module.photo #tags li.selected a,
#hatena-bookmark-user-module.video #tags li.selected a {
    background-color: #36403C; 
}

.sidebar-color,
#hatena-body ul.threshold li.selected a,
#hatena-body div.sidebar div.hatena-module-title h3,
#hatena-bookmark-user-module.photo #tags li.selected a,
#hatena-bookmark-user-module.video #tags li.selected a,
#hatena-body div.hatena-module-body ul.watch-term-list li.selected a {
    color: #A3E3D7; 
}

.link-color-hover,
#hatena-body a:hover {
    color: #14CCA9; 
}

.title-color,
#user-header h2,
#user-header h2 a,
#user-header div.user-message,
body div.breadcrumbs,
body div.breadcrumbs a,
body div.breadcrumbs a:visited,
div.user-message a {
    color: #A3E3D7; 
}

body {
    background-color: #060808; 
}

.text-color,
#bookmarked_user li ul.comment li span.timestamp,
#user-header,
#hatena-body,
#hatena-body #bookmarked_user li ul.comment li,
ul.menu li.current-menu a:link,
ul.menu li.current-menu a:visited,
ul.menu li.current-menu a:hover,
#hatena-body a.domain,
#hatena-body a.category-link,
#hatena-body a.category-link:visited {
    color: #A3E3D7; 
}

body#hatena-bookmark-user.search ul.threshold li.separated span.separater {
    background: #A3E3D7; 
}

.tag-color,
#hatena-body #bookmarked_user span.tags,
#hatena-body #bookmarked_user a.user-tag,
#hatena-body a.tag {
    color: #14CCA9; 
}

.show-tweet-comment span.twitter .retweet-count,
.bookmark-background-color,
div.sidebar div.hatena-module,
ul.menu li.current-menu a,
div.main {
    background-color: #273632; 
}

/*
body {
font-size: 120%
}
*/  
</style>
<script type="text/javascript" charset="utf-8" src="http://cdn-ak.b.st-hatena.com/js/Hatena/Bookmark.js?baf2f55616c99c11c7a93a9fc02c7076054bf894"></script>
<script type="text/javascript">
  if (typeof Hatena == 'undefined')
      var Hatena = { };
  
  




  Hatena.CSSChangeTable =  [
          { key: ''  , name: '青'                , src: ''},
          { key: 'bt', name: '青(透明)'          , src: '/css/color/bt.css'},
          { key: 'gr', name: '緑'                , src: '/css/color/gr.css'},
          { key: 'gt', name: '緑(透明)'          , src: '/css/color/gt.css'},
          { key: 'pk', name: 'ピンク'            , src: '/css/color/pk.css'},
          { key: 'pt', name: 'ピンク(透明)'      , src: '/css/color/pt.css'},
          { key: 'lb', name: 'ライトブルー'      , src: '/css/color/lb.css'},
          { key: 'lt', name: 'ライトブルー(透明)', src: '/css/color/lt.css'},
          { key: 'mt', name: 'グレー'            , src: '/css/color/mt.css'},
          { key: 'tr', name: 'グレー(透明)'      , src: '/css/color/tr.css'},
          { key: 'dk', name: 'ダーク(透明)'      , src: '/css/color/dk.css'},
          { key: 'fx', name: 'Firefox'           , src: '/css/color/fx.css'},
          { key: 'ev', name: 'Evangelion'        , src: '/css/color/ev.css'}

      ]
  Hatena.CSSChanger.registerFiles(Hatena.CSSChangeTable);
  
    
      Hatena.CSSChanger.setFixedColor('mt');
    
  
  Hatena.CSSChanger.init();

  Hatena.Bookmark.entry = {};
  
  Hatena.Bookmark.author = new Hatena.Bookmark.User('motemen');
  Hatena.Bookmark.AfterHeader.addEventListener('onload', function() {
    Hatena.Bookmark.navigator = new Hatena.Bookmark.Navigator([]);
    var nav = new Hatena.Bookmark.Navigator.Global(Hatena.Bookmark.user);
    
  });

  Ten.DOM.addEventListener('onload', function() {
    Hatena.Bookmark.navigator.setElementsBySelector(["h3.entry","div.pager:last-child a:last-child"]);
    Hatena.Bookmark.navigator.registerEventListeners();
      
        Hatena.Bookmark.Star.loadStar('ul.comment li');

    Hatena.Bookmark.ShortURL.TweetInfoLoader.getInstance().init();
    Hatena.Bookmark.ShortURL.ClickCounterLoader.getInstance().init();
    Hatena.Bookmark.ShortURL.RetweetCounterLoader.getInstance().init();
    Hatena.Bookmark.JumpList.setup();

    
      
    //var tags = ;
    window.searchInterface = new Hatena.Bookmark.UserBookmarks.SearchInterface(
    Hatena.Bookmark.author, 
    document.getElementById('user-search-form')
    //, tags
    );
  
      
      new Hatena.Bookmark.UserCalendar();
      
      
        var tagCloudSetting = new Hatena.Bookmark.Toggle.TagCloudSetting(document.getElementById('tags'));
      
        var tagSearch = new Hatena.Bookmark.TagSearch(document.getElementById('tag-search-form'), document.getElementById('tags').getElementsByTagName('li'), 'http://b.hatena.ne.jp/motemen/');
      
        tagSearch.showLink(document.getElementById('tag-more-show'));
        if (tagCloudSetting) tagSearch.setToggle(tagCloudSetting);
       
Hatena.Bookmark.UserNavigator.registerOnLoadBySelector('h2');
Hatena.Bookmark.UserNavigator.registerOnLoadBySelector('ul.comment');
Hatena.Bookmark.UserNavigator.registerOnLoadBySelector('ul li.followers');
(function () {
  var selector = 'ul.comment > li';
  Hatena.Bookmark.ShortURL.TwitterNavigator.registerBySelector(selector);
  Hatena.Bookmark.ShortURL.TwitterNavigator.initAutoPagerize(selector);
})();
new Hatena.Bookmark.AutoPagerize('ul.bookmarked_user', 'div.main div.pager:last-child');


  });
  new Ten.Observer(window, 'onload', function() {
      if (location.hash.length > 2) {
          var pos = Ten.Geometry.getScroll();
          var de = document.documentElement; 
          var b = document.body;
          de.scrollTop  = b.scrollTop  = (pos.y - 40);
      }
  });

  

</script>

</head>
<body id="hatena-bookmark-user" class="fixed-header ">
        
        <div id="header">
            <h1><a href="http://www.hatena.ne.jp/"><img id="logo1" src="/images/logo1.gif" class="csschanger" alt="Hatena"  /></a><a href="/"><img id="logo2" src="/images/logo2.gif" class="csschanger" alt="Bookmark"  /></a></h1>
            <script type="text/javascript">Hatena.CSSChanger.replaceDefault();</script><div id="navigation">
              <form id="search" action="/search">
                <div>
                    <input type="text" id="searchtext" name="q" value=""  /><input type="submit" src="/images/searchbutton.gif" id="searchbutton" value="" />
                    <script type="text/javascript">Hatena.CSSChanger.replaceDefault();</script>
                    </div>
                </form>
                <ul id="header-navigation">
                  <li class="guest"><a id="start_link" href="/guide">はてなブックマークって？</a></li>
                  <li class="guest"><a id="login_link" href="https://www.hatena.ne.jp/login?location=http%3A%2F%2Fb.hatena.ne.jp%2Fmotemen%2F%3Furl%3Dhttp%3A%2F%2Fwww.nicovideo.jp%2F">ログイン</a></li>
                  <li><a href="/help">ヘルプ</a></li>
                  <li id="pin-header"><img src="/images/fixed-off.png" width="16" height="16" title="スクロールの固定" alt="スクロールの固定" /></li>
                <li class="colorselecter"><span id="colorselecter"><img src="/images/spacer.gif" width="17" height="10" alt="" /></span></li>
                </ul>
                <script type="text/javascript">
                    new Hatena.DropDownSelector({
                        button  : document.getElementById('colorselecter'),
                        onclick : function(i){Hatena.CSSChanger.change(i)},
                        data    : Hatena.CSSChangeTable,
                        selectedKey: new Ten.Cookie().get('_hatena_csschanger_name')
                    });
                </script>
            </div>
        </div>
        
        <script type="text/javascript">
             Hatena.Bookmark.AfterHeader.init();
        </script>
        <div class="breadcrumbs"><a href="/" title="はてなブックマーク">はてなブックマーク</a> &gt; <a href="/motemen/" title="en.vio.us">en.vio.us</a> &gt; www.nicovideo.jp
        
        <div id="guest-message">
          <h2>motemenさんも「はてなブックマーク」を使っています。</h2>
          <p>
          <div id="guest-message-button-container">
          <a id="guest-message-button" href="https://www.hatena.ne.jp/register?location=http%3A%2F%2Fb.hatena.ne.jp%2Fmotemen%2F%3Furl%3Dhttp%3A%2F%2Fwww.nicovideo.jp%2F"><img src="/images/guide/guest-message-button.gif" alt="はてなブックマークを使ってみる(無料)" width="198" height="65" /></a><br />
          <a href="/guide">はてなブックマークって？</a>

        </div>
          はてなブックマークはオンラインでブックマークを管理・共有できる無料サービス。自宅、職場、外出先、どこからでも同じブックマークにアクセスできます。ユーザーはみんなでブックマークを共有して効率良く情報収集しています。はてなブックマークを始めて<strong>motemen</strong>さんのブックマークを追いかけてみましょう!
          </p>
        </div>
        
        </div>
            
        <div id="user-header">
  <h2><a href="/motemen/" class="profile-icon"><img src="http://www.st-hatena.com/users/mo/motemen/profile.gif" class="profile-image" alt="motemen" title="motemen" width="32" height="32" /></a>
    en.vio.us / www.nicovideo.jp (162)  </h2>
  <div class="user-message"></div>
    
  <div class="user-search"><form id="user-search-form"><div id="user-search-area"><input autocomplete="off" type="text" class="text" name="q" value=""/><input type="submit" value="検索" style="display:none" /></div></form></div><div id="user-search-result-container"></div>
  
  <ul class="menu">
    <li class="user-module-bookmark user-module current-menu"><a href="/motemen/">ブックマーク</a></li>
    <li class="user-module-favorite user-module"><a href="/motemen/favorite">お気に入り</a></li>

            <li class="user-module-group user-module"><a href="/motemen/group"><img src="/images/user-tab-icon-group.gif" alt="グループ" title="グループ" width="19" height="18" /></a></li>        <li class="user-module-twitter user-module"><a href="/motemen/twitter"><img src="/images/user-tab-icon-twitter.gif" alt="Twitter" title="Twitter" width="19" height="18" /></a></li>        <li class="user-module-video user-module"><a href="/motemen/video"><img src="/images/user-tab-icon-video.gif" alt="動画" title="動画" width="19" height="18" /></a></li>        <li class="user-module-photo user-module"><a href="/motemen/photo"><img src="/images/user-tab-icon-photo.gif" alt="写真" title="写真" width="19" height="18" /></a></li>        <li class="user-module-stocktaking user-module"><a href="/motemen/stocktaking"><img src="/images/user-tab-icon-stocktaking.gif" alt="○年前" title="○年前" width="19" height="18" /></a></li>        <li class="user-module-wordwatch user-module"><a href="/motemen/wordwatch"><img src="/images/user-tab-icon-wordwatch.gif" alt="気になる言葉" title="気になる言葉" /></a></li>
  </ul>

</div>
  <div id="hatena-body">    <div class="main">
    <div class="pager">
     <strong>1</strong> <a href="?url=http%3A%2F%2Fwww.nicovideo.jp%2F&of=20">2</a> <a href="?url=http%3A%2F%2Fwww.nicovideo.jp%2F&of=40">3</a> <a href="?url=http%3A%2F%2Fwww.nicovideo.jp%2F&of=60">4</a> <a href="?url=http%3A%2F%2Fwww.nicovideo.jp%2F&of=80">5</a> <a href="?url=http%3A%2F%2Fwww.nicovideo.jp%2F&of=100">6</a> <a href="?url=http%3A%2F%2Fwww.nicovideo.jp%2F&of=120">7</a> <a href="?url=http%3A%2F%2Fwww.nicovideo.jp%2F&of=140">8</a> <a href="?url=http%3A%2F%2Fwww.nicovideo.jp%2F&of=160">9</a> <a class="pager-next" href="?url=http%3A%2F%2Fwww.nicovideo.jp%2F&of=20">&gt;次の20件</a>
    </div>


    <ul class="threshold">
      <li><span>お気に入り：</span></li>
      <li class="selected"><a href="/motemen/?with_favorites=1">表示</a></li>
      <li><a href="/motemen/?with_favorites=0">非表示</a></li>
    </ul>
    <ul class="threshold">
      <li><span>RT：</span></li>
      <li class="selected" id="show-tweet-comment"><a href="javascript:void(0)">表示</a></li>
      <li id="hide-tweet-comment"><a href="javascript:void(0)">非表示</a></li>
    </ul>

      <ul id="bookmarked_user" class="bookmarked_user">
    <li data-eid="27571114">
  <h3 class="entry" id="bookmark-27571114" style="background-image:url(http://cdn-ak.favicon.st-hatena.com/?url=http%3A%2F%2Fwww.nicovideo.jp%2F)">
  <a href="http://www.nicovideo.jp/watch/sm13098915" class="entry-link">【合作】キーボード傑壊選【天皇陛下万歳祭'10】 ‐ ニコニコ動画(原宿)</a> 
  <a class="domain" href="/motemen/?url=http://www.nicovideo.jp/">www.nicovideo.jp</a>
</h3>
<ul>
  
  <li class="category"><a href="/hotentry/game" title="ゲーム、アニメ、漫画、ライトノベル" class="category-link">ゲーム・アニメ</a></li>
  
  <li class="users"><strong><a href="/entry/www.nicovideo.jp/watch/sm13098915" title="はてなブックマーク - 【合作】キーボード傑壊選【天皇陛下万歳祭'10】 ‐ ニコニコ動画(原宿) (32ブックマーク)">32 users</a></strong></li>
  
</ul>

<div class="curvebox-header"><div></div></div>
<div class="curvebox-body comment">
<span class="thumbnail"><a href="http://www.nicovideo.jp/watch/sm13098915"><img onerror="Hatena.Bookmark.Video.rescueThumbnail(this);" src="http://tn-skr4.smilevideo.jp/smile?i=13098915" alt="【合作】キーボード傑壊選【天皇陛下万歳祭'10】" title="【合作】キーボード傑壊選【天皇陛下万歳祭'10】" width="80" height="60" class="nicovideo" /></a></span>
  <ul class="comment with-thumbnail">
    
    <li data-user="motemen" class="mine">      <a href="/motemen/"><img src="http://cdn-ak.www.st-hatena.com/users/mo/motemen/profile_s.gif" class="profile-image" alt="motemen" title="motemen" width="16" height="16" /></a>
    <a class="username" href="/motemen/20110225#bookmark-27571114">motemen</a>
    <span class="tags"></span>
    <span class="comment"></span>
    <span class="timestamp">2011/02/25 </span>
    

</li>
  </ul>
</div>
<div class="curvebox-bottom"><div>
</div></div>

</li>

    <li data-eid="28110534">
  <h3 class="entry" id="bookmark-28110534" style="background-image:url(http://cdn-ak.favicon.st-hatena.com/?url=http%3A%2F%2Fwww.nicovideo.jp%2F)">
  <a href="http://www.nicovideo.jp/watch/sm13271898" class="entry-link">【1本満足】ヘルシー先進国イッポンッポン【サンドキャニオン】 ‐ ニコニコ動画(原宿)</a> 
  <a class="domain" href="/motemen/?url=http://www.nicovideo.jp/">www.nicovideo.jp</a>
</h3>
<ul>
  
  <li class="category"><a href="/hotentry/game" title="ゲーム、アニメ、漫画、ライトノベル" class="category-link">ゲーム・アニメ</a></li>
  
  <li class="users"><em><a href="/entry/www.nicovideo.jp/watch/sm13271898" title="はてなブックマーク - 【1本満足】ヘルシー先進国イッポンッポン【サンドキャニオン】 ‐ ニコニコ動画(原宿) (8ブックマーク)">8 users</a></em></li>
  
</ul>

<div class="curvebox-header"><div></div></div>
<div class="curvebox-body comment">
<span class="thumbnail"><a href="http://www.nicovideo.jp/watch/sm13271898"><img onerror="Hatena.Bookmark.Video.rescueThumbnail(this);" src="http://tn-skr3.smilevideo.jp/smile?i=13271898" alt="【1本満足】ヘルシー先進国イッポンッポン【サンドキャニオン】" title="【1本満足】ヘルシー先進国イッポンッポン【サンドキャニオン】" width="80" height="60" class="nicovideo" /></a></span>
  <ul class="comment with-thumbnail">
    
    <li data-user="motemen" class="mine">      <a href="/motemen/"><img src="http://cdn-ak.www.st-hatena.com/users/mo/motemen/profile_s.gif" class="profile-image" alt="motemen" title="motemen" width="16" height="16" /></a>
    <a class="username" href="/motemen/20110224#bookmark-28110534">motemen</a>
    <span class="tags"><a rel="tag" class="user-tag" href="/motemen/%E3%82%B5%E3%83%B3%E3%83%89%E3%82%AD%E3%83%A3%E3%83%8B%E3%82%AA%E3%83%B3/">サンドキャニオン</a></span>
    <span class="comment"></span>
    <span class="timestamp">2011/02/24 </span>
    

</li>
  </ul>
</div>
<div class="curvebox-bottom"><div>
</div></div>

</li>

    <li data-eid="28702047">
  <h3 class="entry" id="bookmark-28702047" style="background-image:url(http://cdn-ak.favicon.st-hatena.com/?url=http%3A%2F%2Fwww.nicovideo.jp%2F)">
  <a href="http://www.nicovideo.jp/watch/sm13465059" class="entry-link">【鏡音リン】 Shirley!! 【オリジナル】 ‐ ニコニコ動画(原宿)</a> 
  <a class="domain" href="/motemen/?url=http://www.nicovideo.jp/">www.nicovideo.jp</a>
</h3>
<ul>
  
  <li class="category"><a href="/hotentry/game" title="ゲーム、アニメ、漫画、ライトノベル" class="category-link">ゲーム・アニメ</a></li>
  
  <li class="users"><strong><a href="/entry/www.nicovideo.jp/watch/sm13465059" title="はてなブックマーク - 【鏡音リン】 Shirley!! 【オリジナル】 ‐ ニコニコ動画(原宿) (21ブックマーク)">21 users</a></strong></li>
  
</ul>

<div class="curvebox-header"><div></div></div>
<div class="curvebox-body comment">
<span class="thumbnail"><a href="http://www.nicovideo.jp/watch/sm13465059"><img onerror="Hatena.Bookmark.Video.rescueThumbnail(this);" src="http://tn-skr4.smilevideo.jp/smile?i=13465059" alt="【鏡音リン】 Shirley!! 【オリジナル】" title="【鏡音リン】 Shirley!! 【オリジナル】" width="80" height="60" class="nicovideo" /></a></span>
  <ul class="comment with-thumbnail">
    
    <li data-user="motemen" class="mine">      <a href="/motemen/"><img src="http://cdn-ak.www.st-hatena.com/users/mo/motemen/profile_s.gif" class="profile-image" alt="motemen" title="motemen" width="16" height="16" /></a>
    <a class="username" href="/motemen/20110204#bookmark-28702047">motemen</a>
    <span class="tags"></span>
    <span class="comment"></span>
    <span class="timestamp">2011/02/04 </span>
    

</li>
  </ul>
</div>
<div class="curvebox-bottom"><div>
</div></div>

</li>

    <li data-eid="26894697">
  <h3 class="entry" id="bookmark-26894697" style="background-image:url(http://cdn-ak.favicon.st-hatena.com/?url=http%3A%2F%2Fwww.nicovideo.jp%2F)">
  <a href="http://www.nicovideo.jp/watch/sm12889716" class="entry-link">【キネクト】Dance EvolutionでA Geisha's Dream踊ってみました【ダンエボ】 ‐ ニコニコ動画(原宿)</a> 
  <a class="domain" href="/motemen/?url=http://www.nicovideo.jp/">www.nicovideo.jp</a>
</h3>
<ul>
  
  <li class="category"><a href="/hotentry/entertainment" title="スポーツ、芸能、音楽、映画、エンタメ" class="category-link">スポーツ・芸能・音楽</a></li>
  
  <li class="users"><em><a href="/entry/www.nicovideo.jp/watch/sm12889716" title="はてなブックマーク - 【キネクト】Dance EvolutionでA Geisha's Dream踊ってみました【ダンエボ】 ‐ ニコニコ動画(原宿) (7ブックマーク)">7 users</a></em></li>
  
</ul>

<div class="curvebox-header"><div></div></div>
<div class="curvebox-body comment">
<span class="thumbnail"><a href="http://www.nicovideo.jp/watch/sm12889716"><img onerror="Hatena.Bookmark.Video.rescueThumbnail(this);" src="http://tn-skr1.smilevideo.jp/smile?i=12889716" alt="【キネクト】Dance EvolutionでA Geisha's Dream踊ってみました【ダンエボ】" title="【キネクト】Dance EvolutionでA Geisha's Dream踊ってみました【ダンエボ】" width="80" height="60" class="nicovideo" /></a></span>
  <ul class="comment with-thumbnail">
    
    <li data-user="kusigahama" class="others">      <a href="/kusigahama/"><img src="http://cdn-ak.www.st-hatena.com/users/ku/kusigahama/profile_s.gif" class="profile-image" alt="kusigahama" title="kusigahama" width="16" height="16" /></a>
    <a class="username" href="/kusigahama/20101203#bookmark-26894697">kusigahama</a>
    <span class="tags"></span>
    <span class="comment"></span>
    <span class="timestamp">2010/12/03 </span>
    

</li>
    
    <li data-user="motemen" class="mine">      <a href="/motemen/"><img src="http://cdn-ak.www.st-hatena.com/users/mo/motemen/profile_s.gif" class="profile-image" alt="motemen" title="motemen" width="16" height="16" /></a>
    <a class="username" href="/motemen/20101203#bookmark-26894697">motemen</a>
    <span class="tags"></span>
    <span class="comment">うまい…</span>
    <span class="timestamp">2010/12/03 </span>
    <span class="twitter"><a href="http://twitter.com/motemen/status/10359984822943744" class="with-short-url"><img src="/images/icon-twitter.png" alt="Twitterでのツイートを閲覧" title="Twitterでのツイートを閲覧" /></a><span class="retweet-count require-retweet-count no-retweet-tree" style="display: none"></span></span>

</li>
  </ul>
</div>
<div class="curvebox-bottom"><div>
</div></div>

</li>

    <li data-eid="21988956">
  <h3 class="entry" id="bookmark-21988956" style="background-image:url(http://cdn-ak.favicon.st-hatena.com/?url=http%3A%2F%2Fwww.nicovideo.jp%2F)">
  <a href="http://www.nicovideo.jp/watch/nm10877222" class="entry-link">ふしぎなくすり　のまされて　▼‐ニコニコ動画(9)</a> 
  <a class="domain" href="/motemen/?url=http://www.nicovideo.jp/">www.nicovideo.jp</a>
</h3>
<ul>
  
  <li class="category"><a href="/hotentry/it" title="PC、インターネット、IT、ケータイ、ウェブデザイン、デジタル、ネットコミュニティ" class="category-link">コンピュータ・IT</a></li>
  
  <li class="users"><strong><a href="/entry/www.nicovideo.jp/watch/nm10877222" title="はてなブックマーク - ふしぎなくすり　のまされて　▼‐ニコニコ動画(9) (61ブックマーク)">61 users</a></strong></li>
  
</ul>

<div class="curvebox-header"><div></div></div>
<div class="curvebox-body comment">
  <ul class="comment ">
    
    <li data-user="motemen" class="mine">      <a href="/motemen/"><img src="http://cdn-ak.www.st-hatena.com/users/mo/motemen/profile_s.gif" class="profile-image" alt="motemen" title="motemen" width="16" height="16" /></a>
    <a class="username" href="/motemen/20101201#bookmark-21988956">motemen</a>
    <span class="tags"></span>
    <span class="comment"></span>
    <span class="timestamp">2010/12/01 </span>
    

</li>
  </ul>
</div>
<div class="curvebox-bottom"><div>
</div></div>

</li>

    <li data-eid="25706351">
  <h3 class="entry" id="bookmark-25706351" style="background-image:url(http://cdn-ak.favicon.st-hatena.com/?url=http%3A%2F%2Fwww.nicovideo.jp%2F)">
  <a href="http://www.nicovideo.jp/watch/sm12441199" class="entry-link">【初音ミク】ネトゲ廃人シュプレヒコール【ボトラー】‐ニコニコ動画(9)</a> <img src="/images/camera.gif" alt="このエントリーには写真が掲載されています" title="このエントリーには写真が掲載されています" />
  <a class="domain" href="/motemen/?url=http://www.nicovideo.jp/">www.nicovideo.jp</a>
</h3>
<ul>
  
  <li class="category"><a href="/hotentry/it" title="PC、インターネット、IT、ケータイ、ウェブデザイン、デジタル、ネットコミュニティ" class="category-link">コンピュータ・IT</a></li>
  
  <li class="users"><strong><a href="/entry/www.nicovideo.jp/watch/sm12441199" title="はてなブックマーク - 【初音ミク】ネトゲ廃人シュプレヒコール【ボトラー】‐ニコニコ動画(9) (63ブックマーク)">63 users</a></strong></li>
  
</ul>

<div class="curvebox-header"><div></div></div>
<div class="curvebox-body comment">
<span class="thumbnail"><a href="http://www.nicovideo.jp/watch/sm12441199"><img onerror="Hatena.Bookmark.Video.rescueThumbnail(this);" src="http://tn-skr4.smilevideo.jp/smile?i=12441199" alt="【初音ミク】ネトゲ廃人シュプレヒコール【ボトラー】" title="【初音ミク】ネトゲ廃人シュプレヒコール【ボトラー】" width="80" height="60" class="nicovideo" /></a></span>
  <ul class="comment with-thumbnail">
    
    <li data-user="motemen" class="mine">      <a href="/motemen/"><img src="http://cdn-ak.www.st-hatena.com/users/mo/motemen/profile_s.gif" class="profile-image" alt="motemen" title="motemen" width="16" height="16" /></a>
    <a class="username" href="/motemen/20101112#bookmark-25706351">motemen</a>
    <span class="tags"></span>
    <span class="comment"></span>
    <span class="timestamp">2010/11/12 </span>
    

</li>
    
    <li data-user="yuiseki" class="others">      <a href="/yuiseki/"><img src="http://cdn-ak.www.st-hatena.com/users/yu/yuiseki/profile_s.gif" class="profile-image" alt="yuiseki" title="yuiseki" width="16" height="16" /></a>
    <a class="username" href="/yuiseki/20101018#bookmark-25706351">yuiseki</a>
    <span class="tags"></span>
    <span class="comment"></span>
    <span class="timestamp">2010/10/18 </span>
    

</li>
  </ul>
</div>
<div class="curvebox-bottom"><div>
</div></div>

</li>

    <li data-eid="24208929">
  <h3 class="entry" id="bookmark-24208929" style="background-image:url(http://cdn-ak.favicon.st-hatena.com/?url=http%3A%2F%2Fwww.nicovideo.jp%2F)">
  <a href="http://www.nicovideo.jp/watch/sm11809611" class="entry-link">【オリジナル曲PV】マトリョシカ【初音ミク・GUMI】‐ニコニコ動画(9)</a> 
  <a class="domain" href="/motemen/?url=http://www.nicovideo.jp/">www.nicovideo.jp</a>
</h3>
<ul>
  
  <li class="category"><a href="/hotentry/it" title="PC、インターネット、IT、ケータイ、ウェブデザイン、デジタル、ネットコミュニティ" class="category-link">コンピュータ・IT</a></li>
  
  <li class="users"><strong><a href="/entry/www.nicovideo.jp/watch/sm11809611" title="はてなブックマーク - 【オリジナル曲PV】マトリョシカ【初音ミク・GUMI】‐ニコニコ動画(9) (102ブックマーク)">102 users</a></strong></li>
  
</ul>

<div class="curvebox-header"><div></div></div>
<div class="curvebox-body comment">
<span class="thumbnail"><a href="http://www.nicovideo.jp/watch/sm11809611"><img onerror="Hatena.Bookmark.Video.rescueThumbnail(this);" src="http://tn-skr4.smilevideo.jp/smile?i=11809611" alt="【オリジナル曲PV】マトリョシカ【初音ミク・GUMI】" title="【オリジナル曲PV】マトリョシカ【初音ミク・GUMI】" width="80" height="60" class="nicovideo" /></a></span>
  <ul class="comment with-thumbnail">
    
    <li data-user="motemen" class="mine">      <a href="/motemen/"><img src="http://cdn-ak.www.st-hatena.com/users/mo/motemen/profile_s.gif" class="profile-image" alt="motemen" title="motemen" width="16" height="16" /></a>
    <a class="username" href="/motemen/20101112#bookmark-24208929">motemen</a>
    <span class="tags"></span>
    <span class="comment"></span>
    <span class="timestamp">2010/11/12 </span>
    

</li>
    
    <li data-user="penchan119" class="others">      <a href="/penchan119/"><img src="http://cdn-ak.www.st-hatena.com/users/pe/penchan119/profile_s.gif" class="profile-image" alt="penchan119" title="penchan119" width="16" height="16" /></a>
    <a class="username" href="/penchan119/20100819#bookmark-24208929">penchan119</a>
    <span class="tags"></span>
    <span class="comment">ハチさん　凄いね、コレ程色が強い音も無いよねぇ。　PV可愛い。　文字って力有るんだなぁ。って改めて思う動画</span>
    <span class="timestamp">2010/08/19 </span>
    

</li>
  </ul>
</div>
<div class="curvebox-bottom"><div>
</div></div>

</li>

    <li data-eid="21823790">
  <h3 class="entry" id="bookmark-21823790" style="background-image:url(http://cdn-ak.favicon.st-hatena.com/?url=http%3A%2F%2Fwww.nicovideo.jp%2F)">
  <a href="http://www.nicovideo.jp/watch/sm10851396" class="entry-link">【初音ミク】くたばれPTA【オリジナル曲】‐ニコニコ動画(9)</a> 
  <a class="domain" href="/motemen/?url=http://www.nicovideo.jp/">www.nicovideo.jp</a>
</h3>
<ul>
  
  <li class="category"><a href="/hotentry/game" title="ゲーム、アニメ、漫画、ライトノベル" class="category-link">ゲーム・アニメ</a></li>
  
  <li class="users"><strong><a href="/entry/www.nicovideo.jp/watch/sm10851396" title="はてなブックマーク - 【初音ミク】くたばれPTA【オリジナル曲】‐ニコニコ動画(9) (39ブックマーク)">39 users</a></strong></li>
  
</ul>

<div class="curvebox-header"><div></div></div>
<div class="curvebox-body comment">
<span class="thumbnail"><a href="http://www.nicovideo.jp/watch/sm10851396"><img onerror="Hatena.Bookmark.Video.rescueThumbnail(this);" src="http://tn-skr1.smilevideo.jp/smile?i=10851396" alt="【初音ミク】くたばれPTA【オリジナル曲】" title="【初音ミク】くたばれPTA【オリジナル曲】" width="80" height="60" class="nicovideo" /></a></span>
  <ul class="comment with-thumbnail">
    
    <li data-user="motemen" class="mine">      <a href="/motemen/"><img src="http://cdn-ak.www.st-hatena.com/users/mo/motemen/profile_s.gif" class="profile-image" alt="motemen" title="motemen" width="16" height="16" /></a>
    <a class="username" href="/motemen/20101112#bookmark-21823790">motemen</a>
    <span class="tags"></span>
    <span class="comment"></span>
    <span class="timestamp">2010/11/12 </span>
    

</li>
    
    <li data-user="penchan119" class="others">      <a href="/penchan119/"><img src="http://cdn-ak.www.st-hatena.com/users/pe/penchan119/profile_s.gif" class="profile-image" alt="penchan119" title="penchan119" width="16" height="16" /></a>
    <a class="username" href="/penchan119/20100526#bookmark-21823790">penchan119</a>
    <span class="tags"></span>
    <span class="comment">梨本ういさん</span>
    <span class="timestamp">2010/05/26 </span>
    

</li>
  </ul>
</div>
<div class="curvebox-bottom"><div>
</div></div>

</li>

    <li data-eid="26130579">
  <h3 class="entry" id="bookmark-26130579" style="background-image:url(http://cdn-ak.favicon.st-hatena.com/?url=http%3A%2F%2Fwww.nicovideo.jp%2F)">
  <a href="http://www.nicovideo.jp/watch/sm12607047" class="entry-link">【ミクオリジナル曲】パンプキンヘッドスプーキィダンス【ハロウィン】 ‐ ニコニコ動画(原宿)</a> 
  <a class="domain" href="/motemen/?url=http://www.nicovideo.jp/">www.nicovideo.jp</a>
</h3>
<ul>
  
  <li class="category"><a href="/hotentry/game" title="ゲーム、アニメ、漫画、ライトノベル" class="category-link">ゲーム・アニメ</a></li>
  
  <li class="users"><strong><a href="/entry/www.nicovideo.jp/watch/sm12607047" title="はてなブックマーク - 【ミクオリジナル曲】パンプキンヘッドスプーキィダンス【ハロウィン】 ‐ ニコニコ動画(原宿) (26ブックマーク)">26 users</a></strong></li>
  
</ul>

<div class="curvebox-header"><div></div></div>
<div class="curvebox-body comment">
<span class="thumbnail"><a href="http://www.nicovideo.jp/watch/sm12607047"><img onerror="Hatena.Bookmark.Video.rescueThumbnail(this);" src="http://tn-skr4.smilevideo.jp/smile?i=12607047" alt="【ミクオリジナル曲】パンプキンヘッドスプーキィダンス【ハロウィン】" title="【ミクオリジナル曲】パンプキンヘッドスプーキィダンス【ハロウィン】" width="80" height="60" class="nicovideo" /></a></span>
  <ul class="comment with-thumbnail">
    
    <li data-user="motemen" class="mine">      <a href="/motemen/"><img src="http://cdn-ak.www.st-hatena.com/users/mo/motemen/profile_s.gif" class="profile-image" alt="motemen" title="motemen" width="16" height="16" /></a>
    <a class="username" href="/motemen/20101112#bookmark-26130579">motemen</a>
    <span class="tags"></span>
    <span class="comment"></span>
    <span class="timestamp">2010/11/12 </span>
    

</li>
  </ul>
</div>
<div class="curvebox-bottom"><div>
</div></div>

</li>

    <li data-eid="26201128">
  <h3 class="entry" id="bookmark-26201128" style="background-image:url(http://cdn-ak.favicon.st-hatena.com/?url=http%3A%2F%2Fwww.nicovideo.jp%2F)">
  <a href="http://www.nicovideo.jp/watch/sm12632608" class="entry-link">てってってー　なんでですかー　【ミルキィホームズ】 ‐ ニコニコ動画(原宿)</a> 
  <a class="domain" href="/motemen/?url=http://www.nicovideo.jp/">www.nicovideo.jp</a>
</h3>
<ul>
  
  <li class="category"><a href="/hotentry/game" title="ゲーム、アニメ、漫画、ライトノベル" class="category-link">ゲーム・アニメ</a></li>
  
  <li class="users"><strong><a href="/entry/www.nicovideo.jp/watch/sm12632608" title="はてなブックマーク - てってってー　なんでですかー　【ミルキィホームズ】 ‐ ニコニコ動画(原宿) (52ブックマーク)">52 users</a></strong></li>
  
</ul>

<div class="curvebox-header"><div></div></div>
<div class="curvebox-body comment">
<span class="thumbnail"><a href="http://www.nicovideo.jp/watch/sm12632608"><img onerror="Hatena.Bookmark.Video.rescueThumbnail(this);" src="http://tn-skr1.smilevideo.jp/smile?i=12632608" alt="てってってー　なんでですかー　【ミルキィホームズ】" title="てってってー　なんでですかー　【ミルキィホームズ】" width="80" height="60" class="nicovideo" /></a></span>
  <ul class="comment with-thumbnail">
    
    <li data-user="motemen" class="mine">      <a href="/motemen/"><img src="http://cdn-ak.www.st-hatena.com/users/mo/motemen/profile_s.gif" class="profile-image" alt="motemen" title="motemen" width="16" height="16" /></a>
    <a class="username" href="/motemen/20101109#bookmark-26201128">motemen</a>
    <span class="tags"></span>
    <span class="comment"></span>
    <span class="timestamp">2010/11/09 </span>
    

</li>
    
    <li data-user="secondlife" class="others">      <a href="/secondlife/"><img src="http://cdn-ak.www.st-hatena.com/users/se/secondlife/profile_s.gif" class="profile-image" alt="secondlife" title="secondlife" width="16" height="16" /></a>
    <a class="username" href="/secondlife/20101109#bookmark-26201128">secondlife</a>
    <span class="tags"><a rel="tag" class="user-tag" href="/secondlife/culture/">culture</a>, <a rel="tag" class="user-tag" href="/secondlife/anime/">anime</a></span>
    <span class="comment"></span>
    <span class="timestamp">2010/11/09 </span>
    

</li>
  </ul>
</div>
<div class="curvebox-bottom"><div>
</div></div>

</li>

    <li data-eid="10470297">
  <h3 class="entry" id="bookmark-10470297" style="background-image:url(http://cdn-ak.favicon.st-hatena.com/?url=http%3A%2F%2Fwww.nicovideo.jp%2F)">
  <a href="http://www.nicovideo.jp/watch/sm1577871" class="entry-link">【初音ミク】still alive【修正？】‐ニコニコ動画(秋)</a> 
  <a class="domain" href="/motemen/?url=http://www.nicovideo.jp/">www.nicovideo.jp</a>
</h3>
<ul>
  
  <li class="category"><a href="/hotentry/entertainment" title="スポーツ、芸能、音楽、映画、エンタメ" class="category-link">スポーツ・芸能・音楽</a></li>
  
  <li class="users"><a href="/entry/www.nicovideo.jp/watch/sm1577871" title="はてなブックマーク - 【初音ミク】still alive【修正？】‐ニコニコ動画(秋) (2ブックマーク)">2 users</a></li>
  
</ul>

<div class="curvebox-header"><div></div></div>
<div class="curvebox-body comment">
<span class="thumbnail"><a href="http://www.nicovideo.jp/watch/sm1577871"><img onerror="Hatena.Bookmark.Video.rescueThumbnail(this);" src="http://tn-skr2.smilevideo.jp/smile?i=1577871" alt="【初音ミク】still alive【修正？】" title="【初音ミク】still alive【修正？】" width="80" height="60" class="nicovideo" /></a></span>
  <ul class="comment with-thumbnail">
    
    <li data-user="motemen" class="mine">      <a href="/motemen/"><img src="http://cdn-ak.www.st-hatena.com/users/mo/motemen/profile_s.gif" class="profile-image" alt="motemen" title="motemen" width="16" height="16" /></a>
    <a class="username" href="/motemen/20101025#bookmark-10470297">motemen</a>
    <span class="tags"></span>
    <span class="comment"></span>
    <span class="timestamp">2010/10/25 </span>
    

</li>
  </ul>
</div>
<div class="curvebox-bottom"><div>
</div></div>

</li>

    <li data-eid="25432261">
  <h3 class="entry" id="bookmark-25432261" style="background-image:url(http://cdn-ak.favicon.st-hatena.com/?url=http%3A%2F%2Fwww.nicovideo.jp%2F)">
  <a href="http://www.nicovideo.jp/watch/sm12331189" class="entry-link">イカ娘でサンドキャニオン‐ニコニコ動画(9)</a> 
  <a class="domain" href="/motemen/?url=http://www.nicovideo.jp/">www.nicovideo.jp</a>
</h3>
<ul>
  
  <li class="category"><a href="/hotentry/life" title="生活、人生、衣食住、恋愛、人間関係、悩み" class="category-link">生活・人生</a></li>
  
  <li class="users"><strong><a href="/entry/www.nicovideo.jp/watch/sm12331189" title="はてなブックマーク - イカ娘でサンドキャニオン‐ニコニコ動画(9) (41ブックマーク)">41 users</a></strong></li>
  
</ul>

<div class="curvebox-header"><div></div></div>
<div class="curvebox-body comment">
<span class="thumbnail"><a href="http://www.nicovideo.jp/watch/sm12331189"><img onerror="Hatena.Bookmark.Video.rescueThumbnail(this);" src="http://tn-skr2.smilevideo.jp/smile?i=12331189" alt="イカ娘でサンドキャニオン" title="イカ娘でサンドキャニオン" width="80" height="60" class="nicovideo" /></a></span>
  <ul class="comment with-thumbnail">
    
    <li data-user="motemen" class="mine">      <a href="/motemen/"><img src="http://cdn-ak.www.st-hatena.com/users/mo/motemen/profile_s.gif" class="profile-image" alt="motemen" title="motemen" width="16" height="16" /></a>
    <a class="username" href="/motemen/20101006#bookmark-25432261">motemen</a>
    <span class="tags"><a rel="tag" class="user-tag" href="/motemen/_playlist/">_playlist</a></span>
    <span class="comment"></span>
    <span class="timestamp">2010/10/06 </span>
    

</li>
  </ul>
</div>
<div class="curvebox-bottom"><div>
</div></div>

</li>

    <li data-eid="21994000">
  <h3 class="entry" id="bookmark-21994000" style="background-image:url(http://cdn-ak.favicon.st-hatena.com/?url=http%3A%2F%2Fwww.nicovideo.jp%2F)">
  <a href="http://www.nicovideo.jp/watch/sm10924943" class="entry-link">初音ミクアペンド総出撃オリジナル組曲 「初音ミクの分裂→破壊」‐ニコニコ動画(9)</a> 
  <a class="domain" href="/motemen/?url=http://www.nicovideo.jp/">www.nicovideo.jp</a>
</h3>
<ul>
  
  <li class="category"><a href="/hotentry/game" title="ゲーム、アニメ、漫画、ライトノベル" class="category-link">ゲーム・アニメ</a></li>
  
  <li class="users"><strong><a href="/entry/www.nicovideo.jp/watch/sm10924943" title="はてなブックマーク - 初音ミクアペンド総出撃オリジナル組曲 「初音ミクの分裂→破壊」‐ニコニコ動画(9) (83ブックマーク)">83 users</a></strong></li>
  
</ul>

<div class="curvebox-header"><div></div></div>
<div class="curvebox-body comment">
<span class="thumbnail"><a href="http://www.nicovideo.jp/watch/sm10924943"><img onerror="Hatena.Bookmark.Video.rescueThumbnail(this);" src="http://tn-skr4.smilevideo.jp/smile?i=10924943" alt="初音ミクアペンド総出撃オリジナル組曲 「初音ミクの分裂→破壊」" title="初音ミクアペンド総出撃オリジナル組曲 「初音ミクの分裂→破壊」" width="80" height="60" class="nicovideo" /></a></span>
  <ul class="comment with-thumbnail">
    
    <li data-user="motemen" class="mine">      <a href="/motemen/"><img src="http://cdn-ak.www.st-hatena.com/users/mo/motemen/profile_s.gif" class="profile-image" alt="motemen" title="motemen" width="16" height="16" /></a>
    <a class="username" href="/motemen/20100818#bookmark-21994000">motemen</a>
    <span class="tags"><a rel="tag" class="user-tag" href="/motemen/_playlist/">_playlist</a></span>
    <span class="comment"></span>
    <span class="timestamp">2010/08/18 </span>
    

</li>
    
    <li data-user="penchan119" class="others">      <a href="/penchan119/"><img src="http://cdn-ak.www.st-hatena.com/users/pe/penchan119/profile_s.gif" class="profile-image" alt="penchan119" title="penchan119" width="16" height="16" /></a>
    <a class="username" href="/penchan119/20100602#bookmark-21994000">penchan119</a>
    <span class="tags"></span>
    <span class="comment">こすも（cosMo）さん　組曲なんだ。　Appendの声の種類を見せる工夫良いなぁ。　メッチャ解り易い。　さすがの速さ！</span>
    <span class="timestamp">2010/06/02 </span>
    

</li>
  </ul>
</div>
<div class="curvebox-bottom"><div>
</div></div>

</li>

    <li data-eid="9413322">
  <h3 class="entry" id="bookmark-9413322" style="background-image:url(http://cdn-ak.favicon.st-hatena.com/?url=http%3A%2F%2Fwww.nicovideo.jp%2F)">
  <a href="http://www.nicovideo.jp/watch/sm4059885" class="entry-link">スーパーかがみんデラック酢ぅ～♪ 【らき☆すた�スカイハイ】‐ニコニコ動画(夏)</a> 
  <a class="domain" href="/motemen/?url=http://www.nicovideo.jp/">www.nicovideo.jp</a>
</h3>
<ul>
  
  <li class="category"><a href="/hotentry/social" title="社会、文化、事件、時事" class="category-link">社会</a></li>
  
  <li class="users"><strong><a href="/entry/www.nicovideo.jp/watch/sm4059885" title="はてなブックマーク - スーパーかがみんデラック酢ぅ～♪ 【らき☆すた�スカイハイ】‐ニコニコ動画(夏) (16ブックマーク)">16 users</a></strong></li>
  
</ul>

<div class="curvebox-header"><div></div></div>
<div class="curvebox-body comment">
<span class="thumbnail"><a href="http://www.nicovideo.jp/watch/sm4059885"><img onerror="Hatena.Bookmark.Video.rescueThumbnail(this);" src="http://tn-skr2.smilevideo.jp/smile?i=4059885" alt="スーパーかがみんデラック酢ぅ～♪　【らき☆すた×スカイハイ】" title="スーパーかがみんデラック酢ぅ～♪　【らき☆すた×スカイハイ】" width="80" height="60" class="nicovideo" /></a></span>
  <ul class="comment with-thumbnail">
    
    <li data-user="motemen" class="mine">      <a href="/motemen/"><img src="http://cdn-ak.www.st-hatena.com/users/mo/motemen/profile_s.gif" class="profile-image" alt="motemen" title="motemen" width="16" height="16" /></a>
    <a class="username" href="/motemen/20100809#bookmark-9413322">motemen</a>
    <span class="tags"><a rel="tag" class="user-tag" href="/motemen/mad/">mad</a>, <a rel="tag" class="user-tag" href="/motemen/_playlist/">_playlist</a></span>
    <span class="comment"></span>
    <span class="timestamp">2010/08/09 </span>
    

</li>
  </ul>
</div>
<div class="curvebox-bottom"><div>
</div></div>

</li>

    <li data-eid="16726084">
  <h3 class="entry" id="bookmark-16726084" style="background-image:url(http://cdn-ak.favicon.st-hatena.com/?url=http%3A%2F%2Fwww.nicovideo.jp%2F)">
  <a href="http://www.nicovideo.jp/watch/sm8516883" class="entry-link">佐天・ド・キャニオン‐ニコニコ動画(ββ)</a> 
  <a class="domain" href="/motemen/?url=http://www.nicovideo.jp/">www.nicovideo.jp</a>
</h3>
<ul>
  
  <li class="category"><a href="/hotentry/game" title="ゲーム、アニメ、漫画、ライトノベル" class="category-link">ゲーム・アニメ</a></li>
  
  <li class="users"><strong><a href="/entry/www.nicovideo.jp/watch/sm8516883" title="はてなブックマーク - 佐天・ド・キャニオン‐ニコニコ動画(ββ) (24ブックマーク)">24 users</a></strong></li>
  
</ul>

<div class="curvebox-header"><div></div></div>
<div class="curvebox-body comment">
<span class="thumbnail"><a href="http://www.nicovideo.jp/watch/sm8516883"><img onerror="Hatena.Bookmark.Video.rescueThumbnail(this);" src="http://tn-skr4.smilevideo.jp/smile?i=8516883" alt="佐天・ド・キャニオン" title="佐天・ド・キャニオン" width="80" height="60" class="nicovideo" /></a></span>
  <ul class="comment with-thumbnail">
    
    <li data-user="motemen" class="mine">      <a href="/motemen/"><img src="http://cdn-ak.www.st-hatena.com/users/mo/motemen/profile_s.gif" class="profile-image" alt="motemen" title="motemen" width="16" height="16" /></a>
    <a class="username" href="/motemen/20100809#bookmark-16726084">motemen</a>
    <span class="tags"><a rel="tag" class="user-tag" href="/motemen/%E3%82%B5%E3%83%B3%E3%83%89%E3%82%AD%E3%83%A3%E3%83%8B%E3%82%AA%E3%83%B3/">サンドキャニオン</a>, <a rel="tag" class="user-tag" href="/motemen/mad/">mad</a>, <a rel="tag" class="user-tag" href="/motemen/_playlist/">_playlist</a></span>
    <span class="comment"></span>
    <span class="timestamp">2010/08/09 </span>
    

</li>
  </ul>
</div>
<div class="curvebox-bottom"><div>
</div></div>

</li>

    <li data-eid="17228203">
  <h3 class="entry" id="bookmark-17228203" style="background-image:url(http://cdn-ak.favicon.st-hatena.com/?url=http%3A%2F%2Fwww.nicovideo.jp%2F)">
  <a href="http://www.nicovideo.jp/watch/sm8755361" class="entry-link">変態先進国 黒子キャニオン【とある科学の超電磁砲】‐ニコニコ動画(9)</a> 
  <a class="domain" href="/motemen/?url=http://www.nicovideo.jp/">www.nicovideo.jp</a>
</h3>
<ul>
  
  <li class="category"><a href="/hotentry/game" title="ゲーム、アニメ、漫画、ライトノベル" class="category-link">ゲーム・アニメ</a></li>
  
  <li class="users"><strong><a href="/entry/www.nicovideo.jp/watch/sm8755361" title="はてなブックマーク - 変態先進国 黒子キャニオン【とある科学の超電磁砲】‐ニコニコ動画(9) (24ブックマーク)">24 users</a></strong></li>
  
</ul>

<div class="curvebox-header"><div></div></div>
<div class="curvebox-body comment">
<span class="thumbnail"><a href="http://www.nicovideo.jp/watch/sm8755361"><img onerror="Hatena.Bookmark.Video.rescueThumbnail(this);" src="http://tn-skr2.smilevideo.jp/smile?i=8755361" alt="変態先進国 黒子キャニオン【とある科学の超電磁砲】" title="変態先進国 黒子キャニオン【とある科学の超電磁砲】" width="80" height="60" class="nicovideo" /></a></span>
  <ul class="comment with-thumbnail">
    
    <li data-user="motemen" class="mine">      <a href="/motemen/"><img src="http://cdn-ak.www.st-hatena.com/users/mo/motemen/profile_s.gif" class="profile-image" alt="motemen" title="motemen" width="16" height="16" /></a>
    <a class="username" href="/motemen/20100809#bookmark-17228203">motemen</a>
    <span class="tags"><a rel="tag" class="user-tag" href="/motemen/%E3%82%B5%E3%83%B3%E3%83%89%E3%82%AD%E3%83%A3%E3%83%8B%E3%82%AA%E3%83%B3/">サンドキャニオン</a>, <a rel="tag" class="user-tag" href="/motemen/mad/">mad</a>, <a rel="tag" class="user-tag" href="/motemen/_playlist/">_playlist</a></span>
    <span class="comment"></span>
    <span class="timestamp">2010/08/09 </span>
    

</li>
  </ul>
</div>
<div class="curvebox-bottom"><div>
</div></div>

</li>

    <li data-eid="23833836">
  <h3 class="entry" id="bookmark-23833836" style="background-image:url(http://cdn-ak.favicon.st-hatena.com/?url=http%3A%2F%2Fwww.nicovideo.jp%2F)">
  <a href="http://www.nicovideo.jp/watch/sm11641089" class="entry-link">【鏡音リンオリジナル曲】タイガーランペイジ【PV付】‐ニコニコ動画(9)</a> 
  <a class="domain" href="/motemen/?url=http://www.nicovideo.jp/">www.nicovideo.jp</a>
</h3>
<ul>
  
  <li class="category"><a href="/hotentry/it" title="PC、インターネット、IT、ケータイ、ウェブデザイン、デジタル、ネットコミュニティ" class="category-link">コンピュータ・IT</a></li>
  
  <li class="users"><strong><a href="/entry/www.nicovideo.jp/watch/sm11641089" title="はてなブックマーク - 【鏡音リンオリジナル曲】タイガーランペイジ【PV付】‐ニコニコ動画(9) (66ブックマーク)">66 users</a></strong></li>
  
</ul>

<div class="curvebox-header"><div></div></div>
<div class="curvebox-body comment">
<span class="thumbnail"><a href="http://www.nicovideo.jp/watch/sm11641089"><img onerror="Hatena.Bookmark.Video.rescueThumbnail(this);" src="http://tn-skr2.smilevideo.jp/smile?i=11641089" alt="【鏡音リンオリジナル曲】タイガーランペイジ【PV付】" title="【鏡音リンオリジナル曲】タイガーランペイジ【PV付】" width="80" height="60" class="nicovideo" /></a></span>
  <ul class="comment with-thumbnail">
    
    <li data-user="motemen" class="mine">      <a href="/motemen/"><img src="http://cdn-ak.www.st-hatena.com/users/mo/motemen/profile_s.gif" class="profile-image" alt="motemen" title="motemen" width="16" height="16" /></a>
    <a class="username" href="/motemen/20100806#bookmark-23833836">motemen</a>
    <span class="tags"></span>
    <span class="comment"></span>
    <span class="timestamp">2010/08/06 </span>
    

</li>
  </ul>
</div>
<div class="curvebox-bottom"><div>
</div></div>

</li>

    <li data-eid="10275603">
  <h3 class="entry" id="bookmark-10275603" style="background-image:url(http://cdn-ak.favicon.st-hatena.com/?url=http%3A%2F%2Fwww.nicovideo.jp%2F)">
  <a href="http://www.nicovideo.jp/watch/sm4830399" class="entry-link">フレンズ・オブ・かがみ【らき☆すた×ナイト・オブ・ナイツ】‐ニコニコ動画(秋)</a> 
  <a class="domain" href="/motemen/?url=http://www.nicovideo.jp/">www.nicovideo.jp</a>
</h3>
<ul>
  
  <li class="category"><a href="/hotentry/game" title="ゲーム、アニメ、漫画、ライトノベル" class="category-link">ゲーム・アニメ</a></li>
  
  <li class="users"><strong><a href="/entry/www.nicovideo.jp/watch/sm4830399" title="はてなブックマーク - フレンズ・オブ・かがみ【らき☆すた×ナイト・オブ・ナイツ】‐ニコニコ動画(秋) (37ブックマーク)">37 users</a></strong></li>
  
</ul>

<div class="curvebox-header"><div></div></div>
<div class="curvebox-body comment">
<span class="thumbnail"><a href="http://www.nicovideo.jp/watch/sm4830399"><img onerror="Hatena.Bookmark.Video.rescueThumbnail(this);" src="http://tn-skr2.smilevideo.jp/smile?i=4830399" alt="フレンズ・オブ・かがみ【らき☆すた×ナイト・オブ・ナイツ】" title="フレンズ・オブ・かがみ【らき☆すた×ナイト・オブ・ナイツ】" width="80" height="60" class="nicovideo" /></a></span>
  <ul class="comment with-thumbnail">
    
    <li data-user="motemen" class="mine">      <a href="/motemen/"><img src="http://cdn-ak.www.st-hatena.com/users/mo/motemen/profile_s.gif" class="profile-image" alt="motemen" title="motemen" width="16" height="16" /></a>
    <a class="username" href="/motemen/20100804#bookmark-10275603">motemen</a>
    <span class="tags"><a rel="tag" class="user-tag" href="/motemen/mad/">mad</a>, <a rel="tag" class="user-tag" href="/motemen/_playlist/">_playlist</a></span>
    <span class="comment"></span>
    <span class="timestamp">2010/08/04 </span>
    

</li>
  </ul>
</div>
<div class="curvebox-bottom"><div>
</div></div>

</li>

    <li data-eid="20195030">
  <h3 class="entry" id="bookmark-20195030" style="background-image:url(http://cdn-ak.favicon.st-hatena.com/?url=http%3A%2F%2Fwww.nicovideo.jp%2F)">
  <a href="http://www.nicovideo.jp/watch/sm10111236" class="entry-link">【ニコニコメドレー】 ニコってる？！ 【第4弾】‐ニコニコ動画(9)</a> 
  <a class="domain" href="/motemen/?url=http://www.nicovideo.jp/">www.nicovideo.jp</a>
</h3>
<ul>
  
  <li class="category"><a href="/hotentry/it" title="PC、インターネット、IT、ケータイ、ウェブデザイン、デジタル、ネットコミュニティ" class="category-link">コンピュータ・IT</a></li>
  
  <li class="users"><strong><a href="/entry/www.nicovideo.jp/watch/sm10111236" title="はてなブックマーク - 【ニコニコメドレー】 ニコってる？！ 【第4弾】‐ニコニコ動画(9) (52ブックマーク)">52 users</a></strong></li>
  
</ul>

<div class="curvebox-header"><div></div></div>
<div class="curvebox-body comment">
<span class="thumbnail"><a href="http://www.nicovideo.jp/watch/sm10111236"><img onerror="Hatena.Bookmark.Video.rescueThumbnail(this);" src="http://tn-skr1.smilevideo.jp/smile?i=10111236" alt="【ニコニコメドレー】 ニコってる？！ 【第4弾】" title="【ニコニコメドレー】 ニコってる？！ 【第4弾】" width="80" height="60" class="nicovideo" /></a></span>
  <ul class="comment with-thumbnail">
    
    <li data-user="motemen" class="mine">      <a href="/motemen/"><img src="http://cdn-ak.www.st-hatena.com/users/mo/motemen/profile_s.gif" class="profile-image" alt="motemen" title="motemen" width="16" height="16" /></a>
    <a class="username" href="/motemen/20100722#bookmark-20195030">motemen</a>
    <span class="tags"><a rel="tag" class="user-tag" href="/motemen/_playlist/">_playlist</a></span>
    <span class="comment"></span>
    <span class="timestamp">2010/07/22 </span>
    

</li>
  </ul>
</div>
<div class="curvebox-bottom"><div>
</div></div>

</li>

    <li data-eid="6849690">
  <h3 class="entry" id="bookmark-6849690" style="background-image:url(http://cdn-ak.favicon.st-hatena.com/?url=http%3A%2F%2Fwww.nicovideo.jp%2F)">
  <a href="http://www.nicovideo.jp/watch/sm1810054" class="entry-link">ニコニコ動画(RC2)‐【初音ミク】ミクがスペランカー略して「ミクランカー」</a> 
  <a class="domain" href="/motemen/?url=http://www.nicovideo.jp/">www.nicovideo.jp</a>
</h3>
<ul>
  
  <li class="category"><a href="/hotentry/entertainment" title="スポーツ、芸能、音楽、映画、エンタメ" class="category-link">スポーツ・芸能・音楽</a></li>
  
  <li class="users"><strong><a href="/entry/www.nicovideo.jp/watch/sm1810054" title="はてなブックマーク - ニコニコ動画(RC2)‐【初音ミク】ミクがスペランカー略して「ミクランカー」 (101ブックマーク)">101 users</a></strong></li>
  
</ul>

<div class="curvebox-header"><div></div></div>
<div class="curvebox-body comment">
<span class="thumbnail"><a href="http://www.nicovideo.jp/watch/sm1810054"><img onerror="Hatena.Bookmark.Video.rescueThumbnail(this);" src="http://tn-skr.smilevideo.jp/smile?i=1810054" alt="【初音ミク】ミクがスペランカー略して「ミクランカー」" title="【初音ミク】ミクがスペランカー略して「ミクランカー」" width="80" height="60" class="nicovideo" /></a></span>
  <ul class="comment with-thumbnail">
    
    <li data-user="motemen" class="mine">      <a href="/motemen/"><img src="http://cdn-ak.www.st-hatena.com/users/mo/motemen/profile_s.gif" class="profile-image" alt="motemen" title="motemen" width="16" height="16" /></a>
    <a class="username" href="/motemen/20100713#bookmark-6849690">motemen</a>
    <span class="tags"></span>
    <span class="comment"></span>
    <span class="timestamp">2010/07/13 </span>
    

</li>
    
    <li data-user="UBE_pener" class="others">      <a href="/UBE_pener/"><img src="http://cdn-ak.www.st-hatena.com/users/UB/UBE_pener/profile_s.gif" class="profile-image" alt="UBE_pener" title="UBE_pener" width="16" height="16" /></a>
    <a class="username" href="/UBE_pener/20100713#bookmark-6849690">UBE_pener</a>
    <span class="tags"><a rel="tag" class="user-tag" href="/UBE_pener/%E3%83%8B%E3%82%B3%E3%83%8B%E3%82%B3%E5%8B%95%E7%94%BB/">ニコニコ動画</a>, <a rel="tag" class="user-tag" href="/UBE_pener/%E3%81%93%E3%82%8C%E3%81%AF%E3%81%99%E3%81%94%E3%81%84/">これはすごい</a>, <a rel="tag" class="user-tag" href="/UBE_pener/game/">game</a>, <a rel="tag" class="user-tag" href="/UBE_pener/%E5%88%9D%E9%9F%B3%E3%83%9F%E3%82%AF/">初音ミク</a>, <a rel="tag" class="user-tag" href="/UBE_pener/vocaloid/">vocaloid</a></span>
    <span class="comment">Wiiのバーコンで買ってる方は是非見よう</span>
    <span class="timestamp">2010/07/13 </span>
    

</li>
    
    <li data-user="quao" class="others">      <a href="/quao/"><img src="http://cdn-ak.www.st-hatena.com/users/qu/quao/profile_s.gif" class="profile-image" alt="quao" title="quao" width="16" height="16" /></a>
    <a class="username" href="/quao/20080402#bookmark-6849690">quao</a>
    <span class="tags"><a rel="tag" class="user-tag" href="/quao/*%E3%83%8B%E3%82%B3%E5%8B%95/">*ニコ動</a>, <a rel="tag" class="user-tag" href="/quao/*artist(works)/">*artist(works)</a>, <a rel="tag" class="user-tag" href="/quao/%2B%E2%98%85%E2%98%85%E2%98%85%E2%98%85%E2%98%85/">+★★★★★</a></span>
    <span class="comment">SEまですべて初音ミクで再現</span>
    <span class="timestamp">2008/04/02 </span>
    

</li>
    
    <li data-user="faerie" class="others">      <a href="/faerie/"><img src="http://cdn-ak.www.st-hatena.com/users/fa/faerie/profile_s.gif" class="profile-image" alt="faerie" title="faerie" width="16" height="16" /></a>
    <a class="username" href="/faerie/20071222#bookmark-6849690">faerie</a>
    <span class="tags"><a rel="tag" class="user-tag" href="/faerie/%E5%88%9D%E9%9F%B3%E3%83%9F%E3%82%AF/">初音ミク</a></span>
    <span class="comment">ふんぐるい</span>
    <span class="timestamp">2007/12/22 </span>
    

</li>
  </ul>
</div>
<div class="curvebox-bottom"><div>
</div></div>

</li>

    </ul>  
    <div class="pager">
     <strong>1</strong> <a href="?url=http%3A%2F%2Fwww.nicovideo.jp%2F&of=20">2</a> <a href="?url=http%3A%2F%2Fwww.nicovideo.jp%2F&of=40">3</a> <a href="?url=http%3A%2F%2Fwww.nicovideo.jp%2F&of=60">4</a> <a href="?url=http%3A%2F%2Fwww.nicovideo.jp%2F&of=80">5</a> <a href="?url=http%3A%2F%2Fwww.nicovideo.jp%2F&of=100">6</a> <a href="?url=http%3A%2F%2Fwww.nicovideo.jp%2F&of=120">7</a> <a href="?url=http%3A%2F%2Fwww.nicovideo.jp%2F&of=140">8</a> <a href="?url=http%3A%2F%2Fwww.nicovideo.jp%2F&of=160">9</a> <a class="pager-next" href="?url=http%3A%2F%2Fwww.nicovideo.jp%2F&of=20">&gt;次の20件</a>
    </div>
    <div class="feed">
      <a class="feed" href="/motemen/rss">RSS</a>
    </div>
  </div>    
      <div class="sidebar">

    <div class="hatena-module hatena-module-profile">
      <div class="hatena-module-title">
        <h3><img src="http://cdn-ak.www.st-hatena.com/users/mo/motemen/profile_s.gif" class="profile-image" alt="motemen" title="motemen" width="16" height="16" />motemen</h3>
      </div>
      <div class="hatena-module-body">
        <ul>
          <li><span class="label">サイト</span>
            <a href="http://subtech.g.hatena.ne.jp/motemen/" title="NaN days">NaN days</a>
            <a href="/bookmarklist?url=http://subtech.g.hatena.ne.jp/motemen/"><img src="/images/bm_home.gif" title="NaN daysの新着ブックマーク" alt="NaN daysの新着ブックマーク" /></a>
          </li>
          <li><span class="label">ブックマーク数</span> 5,790</li>
          
          <li><span class="label">お気に入り</span> <a href="/motemen/favorite">93</a></li>
          <li><span class="label">お気に入られ</span>  <a href="/motemen/follower">136</a></li>
          <li class="followers"><a href="/lliorzill/"><img src="http://www.st-hatena.com/users/ll/lliorzill/profile.gif" class="profile-image" alt="lliorzill" title="lliorzill" width="24" height="24" /></a><a href="/antipop/"><img src="http://www.st-hatena.com/users/an/antipop/profile.gif" class="profile-image" alt="antipop" title="antipop" width="24" height="24" /></a><a href="/wideangle/"><img src="http://www.st-hatena.com/users/wi/wideangle/profile.gif" class="profile-image" alt="wideangle" title="wideangle" width="24" height="24" /></a><a href="/yuiseki/"><img src="http://www.st-hatena.com/users/yu/yuiseki/profile.gif" class="profile-image" alt="yuiseki" title="yuiseki" width="24" height="24" /></a><a href="/masa138/"><img src="http://www.st-hatena.com/users/ma/masa138/profile.gif" class="profile-image" alt="masa138" title="masa138" width="24" height="24" /></a><a href="/moridai/"><img src="http://www.st-hatena.com/users/mo/moridai/profile.gif" class="profile-image" alt="moridai" title="moridai" width="24" height="24" /></a><a href="/toya/"><img src="http://www.st-hatena.com/users/to/toya/profile.gif" class="profile-image" alt="toya" title="toya" width="24" height="24" /></a><a href="/shiba_yu36/"><img src="http://www.st-hatena.com/users/sh/shiba_yu36/profile.gif" class="profile-image" alt="shiba_yu36" title="shiba_yu36" width="24" height="24" /></a><a href="/htomine/"><img src="http://www.st-hatena.com/users/ht/htomine/profile.gif" class="profile-image" alt="htomine" title="htomine" width="24" height="24" /></a><a href="/YAK/"><img src="http://www.st-hatena.com/users/YA/YAK/profile.gif" class="profile-image" alt="YAK" title="YAK" width="24" height="24" /></a><a href="/ueday/"><img src="http://www.st-hatena.com/users/ue/ueday/profile.gif" class="profile-image" alt="ueday" title="ueday" width="24" height="24" /></a><a href="/mooz/"><img src="http://www.st-hatena.com/users/mo/mooz/profile.gif" class="profile-image" alt="mooz" title="mooz" width="24" height="24" /></a><a href="/advblog/"><img src="http://www.st-hatena.com/users/ad/advblog/profile.gif" class="profile-image" alt="advblog" title="advblog" width="24" height="24" /></a><a href="/whirl/"><img src="http://www.st-hatena.com/users/wh/whirl/profile.gif" class="profile-image" alt="whirl" title="whirl" width="24" height="24" /></a><a href="/kshimo69/"><img src="http://www.st-hatena.com/users/ks/kshimo69/profile.gif" class="profile-image" alt="kshimo69" title="kshimo69" width="24" height="24" /></a><a href="/colombo/"><img src="http://www.st-hatena.com/users/co/colombo/profile.gif" class="profile-image" alt="colombo" title="colombo" width="24" height="24" /></a><a href="/hitode909/"><img src="http://www.st-hatena.com/users/hi/hitode909/profile.gif" class="profile-image" alt="hitode909" title="hitode909" width="24" height="24" /></a><a href="/daichan330/"><img src="http://www.st-hatena.com/users/da/daichan330/profile.gif" class="profile-image" alt="daichan330" title="daichan330" width="24" height="24" /></a><a href="/mrorii/"><img src="http://www.st-hatena.com/users/mr/mrorii/profile.gif" class="profile-image" alt="mrorii" title="mrorii" width="24" height="24" /></a><a href="/hxmasaki/"><img src="http://www.st-hatena.com/users/hx/hxmasaki/profile.gif" class="profile-image" alt="hxmasaki" title="hxmasaki" width="24" height="24" /></a><a href="/natsumesouxx/"><img src="http://www.st-hatena.com/users/na/natsumesouxx/profile.gif" class="profile-image" alt="natsumesouxx" title="natsumesouxx" width="24" height="24" /></a></li>
        </ul>
      </div>
    </div>


      <div class="hatena-module hatena-module-profile">
      <div id="user-sidebar-calendar">
        
<div class="hatena-module-title">
  <h3>カレンダー</h3>
</div>
<div class="hatena-module-body">
  <div class="user-sidebar-calendar-inner">
    <table class="calendar" summary="calendar">
      <tr>
        <td class="calendar-prev-month" colspan="2"><span class="calendar-201101" id="user-calendar-prev" title="prev" rel="nofollow">&lt;&lt;</span></td>
        <td class="calendar-current-month" colspan="3">2011/02</td>
        <td class="calendar-next-month" colspan="2"><span class="calendar-201103"id="user-calendar-next" title="next" rel="nofollow">&gt;&gt;</span></td>
      </tr>
      <tr>
        <td class="calendar-sunday">日</td>
        <td class="calendar-weekday">月</td>
        <td class="calendar-weekday">火</td>
        <td class="calendar-weekday">水</td>
        <td class="calendar-weekday">木</td>
        <td class="calendar-weekday">金</td>
        <td class="calendar-saturday">土</td>
      </tr>
      <tr>
        <td class="calendar-day">
        </td>
        <td class="calendar-day">
        </td>
        <td class="calendar-day">
          <a class="tanaka-inner-link" href="/motemen/20110201">1</a>
        </td>
        <td class="calendar-day">
          <a class="tanaka-inner-link" href="/motemen/20110202">2</a>
        </td>
        <td class="calendar-day">
          <a class="tanaka-inner-link" href="/motemen/20110203">3</a>
        </td>
        <td class="calendar-day">
          <a class="tanaka-inner-link" href="/motemen/20110204">4</a>
        </td>
        <td class="calendar-day">
          <span class="tanaka-inner-span">5</span>
        </td>
      </tr>
      <tr>
        <td class="calendar-day">
          <a class="tanaka-inner-link" href="/motemen/20110206">6</a>
        </td>
        <td class="calendar-day">
          <a class="tanaka-inner-link" href="/motemen/20110207">7</a>
        </td>
        <td class="calendar-day">
          <a class="tanaka-inner-link" href="/motemen/20110208">8</a>
        </td>
        <td class="calendar-day">
          <a class="tanaka-inner-link" href="/motemen/20110209">9</a>
        </td>
        <td class="calendar-day">
          <a class="tanaka-inner-link" href="/motemen/20110210">10</a>
        </td>
        <td class="calendar-day">
          <span class="tanaka-inner-span">11</span>
        </td>
        <td class="calendar-day">
          <span class="tanaka-inner-span">12</span>
        </td>
      </tr>
      <tr>
        <td class="calendar-day">
          <span class="tanaka-inner-span">13</span>
        </td>
        <td class="calendar-day">
          <a class="tanaka-inner-link" href="/motemen/20110214">14</a>
        </td>
        <td class="calendar-day">
          <a class="tanaka-inner-link" href="/motemen/20110215">15</a>
        </td>
        <td class="calendar-day">
          <a class="tanaka-inner-link" href="/motemen/20110216">16</a>
        </td>
        <td class="calendar-day">
          <a class="tanaka-inner-link" href="/motemen/20110217">17</a>
        </td>
        <td class="calendar-day">
          <a class="tanaka-inner-link" href="/motemen/20110218">18</a>
        </td>
        <td class="calendar-day">
          <span class="tanaka-inner-span">19</span>
        </td>
      </tr>
      <tr>
        <td class="calendar-day">
          <a class="tanaka-inner-link" href="/motemen/20110220">20</a>
        </td>
        <td class="calendar-day">
          <a class="tanaka-inner-link" href="/motemen/20110221">21</a>
        </td>
        <td class="calendar-day">
          <a class="tanaka-inner-link" href="/motemen/20110222">22</a>
        </td>
        <td class="calendar-day">
          <a class="tanaka-inner-link" href="/motemen/20110223">23</a>
        </td>
        <td class="calendar-day">
          <a class="tanaka-inner-link" href="/motemen/20110224">24</a>
        </td>
        <td class="calendar-day">
          <a class="tanaka-inner-link" href="/motemen/20110225">25</a>
        </td>
        <td class="calendar-day">
          <span class="tanaka-inner-span">26</span>
        </td>
      </tr>
      <tr>
        <td class="calendar-day">
          <a class="tanaka-inner-link" href="/motemen/20110227">27</a>
        </td>
        <td class="calendar-day">
          <span class="tanaka-inner-span">28</span>
        </td>
        <td class="calendar-day">
        </td>
        <td class="calendar-day">
        </td>
        <td class="calendar-day">
        </td>
        <td class="calendar-day">
        </td>
        <td class="calendar-day">
        </td>
      </tr>
    </table>
  </div>
</div>

      </div>
      </div>
      

    <div class="hatena-module hatena-module-tags">
      <div class="hatena-module-title">
        <div id="tag-cloud-setting">
          <span id="flat-setting-button"><img src="/images/tag-list.gif?v=2" alt="cloud" title="リスト表示に切り替え" /></span><span id="cloud-setting-button"><img src="/images/tag-cloud.gif?v=2" alt="flat" title="クラウド表示に切り替え"  /></span>
        </div>
        <h3>タグ (816)</h3>
      </div>
      <div class="hatena-module-body">
        <form class="tag-search" id="tag-search-form">
          <input class="inputtext" autocomplete="off" type="text" name="word" />
          <input type="submit" style="display:none" />
        </form>
        
        <ul id="tags">
          <li class="tag-cloud-size-7 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/(%20%EF%BC%9B%E2%88%80%EF%BC%9B)/">( ；∀；)</a><span class="count">(3)</span></li>
          <li class="tag-cloud-size-4 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/*/">*</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-4 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/.net/">.net</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-9 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/2ch/">2ch</a><span class="count">(20)</span></li>
          <li class="tag-cloud-size-4 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/2k/">2k</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-8 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/3d/">3d</a><span class="count">(9)</span></li>
          <li class="tag-cloud-size-4 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/8tracks/">8tracks</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-6 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/a*/">a*</a><span class="count">(2)</span></li>
          <li class="tag-cloud-size-6 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/aa/">aa</a><span class="count">(2)</span></li>
          <li class="tag-cloud-size-4 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/aaron/">aaron</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-6 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/achievement/">achievement</a><span class="count">(2)</span></li>
          <li class="tag-cloud-size-4 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/ack/">ack</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-7 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/actionscript/">actionscript</a><span class="count">(4)</span></li>
          <li class="tag-cloud-size-4 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/adom/">adom</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-4 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/advertising/">advertising</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-4 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/ai/">ai</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-7 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/air/">air</a><span class="count">(3)</span></li>
          <li class="tag-cloud-size-4 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/ajaja/">ajaja</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-9 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/ajax/">ajax</a><span class="count">(15)</span></li>
          <li class="tag-cloud-size-7 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/algebra/">algebra</a><span class="count">(3)</span></li>
          <li class="tag-cloud-size-9 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/algorithm/">algorithm</a><span class="count">(17)</span></li>
          <li class="tag-cloud-size-4 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/alloy/">alloy</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-7 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/amachang/">amachang</a><span class="count">(3)</span></li>
          <li class="tag-cloud-size-8 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/amazon/">amazon</a><span class="count">(10)</span></li>
          <li class="tag-cloud-size-6 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/angband/">angband</a><span class="count">(2)</span></li>
          <li class="tag-cloud-size-4 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/angelos/">angelos</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-9"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/anime/">anime</a><span class="count">(33)</span></li>
          <li class="tag-cloud-size-4 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/anos/">anos</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-4 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/ansi/">ansi</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-4 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/antipop/">antipop</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-8 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/apache/">apache</a><span class="count">(5)</span></li>
          <li class="tag-cloud-size-9"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/api/">api</a><span class="count">(36)</span></li>
          <li class="tag-cloud-size-7 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/apollo/">apollo</a><span class="count">(4)</span></li>
          <li class="tag-cloud-size-4 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/apple/">apple</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-4 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/appli/">appli</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-8 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/ar/">ar</a><span class="count">(9)</span></li>
          <li class="tag-cloud-size-4 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/arc/">arc</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-7 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/arrow/">arrow</a><span class="count">(4)</span></li>
          <li class="tag-cloud-size-9 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/art/">art</a><span class="count">(12)</span></li>
          <li class="tag-cloud-size-6 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/artoolkit/">artoolkit</a><span class="count">(2)</span></li>
          <li class="tag-cloud-size-9"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/as3/">as3</a><span class="count">(27)</span></li>
          <li class="tag-cloud-size-4 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/ascii/">ascii</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-4 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/asimov/">asimov</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-7 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/assassins_creed/">assassins_creed</a><span class="count">(4)</span></li>
          <li class="tag-cloud-size-4 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/asymptote/">asymptote</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-4 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/atok/">atok</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-8 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/atom/">atom</a><span class="count">(6)</span></li>
          <li class="tag-cloud-size-4 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/atrain/">atrain</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-4 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/au/">au</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-4 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/audioscrobbler/">audioscrobbler</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-4 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/autoconf/">autoconf</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-4 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/autodiscovery/">autodiscovery</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-4 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/autohotkey/">autohotkey</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-4 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/automake/">automake</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-4 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/automaton/">automaton</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-4 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/b-reps/">b-reps</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-4 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/bag/">bag</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-4 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/bash/">bash</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-4 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/batch/">batch</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-6 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/bcc/">bcc</a><span class="count">(2)</span></li>
          <li class="tag-cloud-size-4 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/beamer/">beamer</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-4 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/befunge/">befunge</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-4 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/belgariad/">belgariad</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-4 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/beyond/">beyond</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-8 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/bho/">bho</a><span class="count">(5)</span></li>
          <li class="tag-cloud-size-4 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/bibliography/">bibliography</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-4 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/bind/">bind</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-9 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/bioshock/">bioshock</a><span class="count">(22)</span></li>
          <li class="tag-cloud-size-4 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/blender/">blender</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-7 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/blog/">blog</a><span class="count">(3)</span></li>
          <li class="tag-cloud-size-4 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/bloglines/">bloglines</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-8 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/blosxom/">blosxom</a><span class="count">(5)</span></li>
          <li class="tag-cloud-size-4 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/bom/">bom</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-9"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/book/">book</a><span class="count">(75)</span></li>
          <li class="tag-cloud-size-8 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/bookmark/">bookmark</a><span class="count">(6)</span></li>
          <li class="tag-cloud-size-8 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/bookmarklet/">bookmarklet</a><span class="count">(10)</span></li>
          <li class="tag-cloud-size-7 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/bot/">bot</a><span class="count">(3)</span></li>
          <li class="tag-cloud-size-4 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/boyer-moore/">boyer-moore</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-4 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/brainfuck/">brainfuck</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-6 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/brazil/">brazil</a><span class="count">(2)</span></li>
          <li class="tag-cloud-size-4 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/brew/">brew</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-8 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/browser/">browser</a><span class="count">(9)</span></li>
          <li class="tag-cloud-size-4 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/building/">building</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-9 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/c/">c</a><span class="count">(12)</span></li>
          <li class="tag-cloud-size-4 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/c%23/">c#</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-9 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/c%2B%2B/">c++</a><span class="count">(21)</span></li>
          <li class="tag-cloud-size-4 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/c10k/">c10k</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-4 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/cafeobj/">cafeobj</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-8 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/calendar/">calendar</a><span class="count">(5)</span></li>
          <li class="tag-cloud-size-4 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/canon/">canon</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-8 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/canvas/">canvas</a><span class="count">(8)</span></li>
          <li class="tag-cloud-size-7 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/capistrano/">capistrano</a><span class="count">(4)</span></li>
          <li class="tag-cloud-size-7 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/cat/">cat</a><span class="count">(3)</span></li>
          <li class="tag-cloud-size-9 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/category/">category</a><span class="count">(18)</span></li>
          <li class="tag-cloud-size-4 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/chaos/">chaos</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-4 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/chat/">chat</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-6 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/cheat/">cheat</a><span class="count">(2)</span></li>
          <li class="tag-cloud-size-4 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/cheatsheet/">cheatsheet</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-8 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/cho45/">cho45</a><span class="count">(5)</span></li>
          <li class="tag-cloud-size-6 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/chord/">chord</a><span class="count">(2)</span></li>
          <li class="tag-cloud-size-7 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/cinnamon/">cinnamon</a><span class="count">(3)</span></li>
          <li class="tag-cloud-size-4 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/cipher/">cipher</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-4 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/cite/">cite</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-9 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/clannad/">clannad</a><span class="count">(15)</span></li>
          <li class="tag-cloud-size-4 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/client/">client</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-7 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/clisp/">clisp</a><span class="count">(3)</span></li>
          <li class="tag-cloud-size-4 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/clock/">clock</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-4 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/clojure/">clojure</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-6 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/clr/">clr</a><span class="count">(2)</span></li>
          <li class="tag-cloud-size-6 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/cm/">cm</a><span class="count">(2)</span></li>
          <li class="tag-cloud-size-4 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/cmd.exe/">cmd.exe</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-4 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/cocolo/">cocolo</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-4 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/cod4/">cod4</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-7 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/code/">code</a><span class="count">(3)</span></li>
          <li class="tag-cloud-size-8 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/colinux/">colinux</a><span class="count">(5)</span></li>
          <li class="tag-cloud-size-8 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/color/">color</a><span class="count">(12)</span></li>
          <li class="tag-cloud-size-6 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/comet/">comet</a><span class="count">(2)</span></li>
          <li class="tag-cloud-size-9 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/comic/">comic</a><span class="count">(17)</span></li>
          <li class="tag-cloud-size-4 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/common/">common</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-7 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/communication/">communication</a><span class="count">(3)</span></li>
          <li class="tag-cloud-size-4 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/comonad/">comonad</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-7 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/compiler/">compiler</a><span class="count">(4)</span></li>
          <li class="tag-cloud-size-9"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/compsci/">compsci</a><span class="count">(42)</span></li>
          <li class="tag-cloud-size-4 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/concept/">concept</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-6 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/configuration/">configuration</a><span class="count">(2)</span></li>
          <li class="tag-cloud-size-4 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/coninuation/">coninuation</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-7 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/console/">console</a><span class="count">(3)</span></li>
          <li class="tag-cloud-size-8 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/continuation/">continuation</a><span class="count">(6)</span></li>
          <li class="tag-cloud-size-6 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/cookbook/">cookbook</a><span class="count">(2)</span></li>
          <li class="tag-cloud-size-8 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/cookie/">cookie</a><span class="count">(5)</span></li>
          <li class="tag-cloud-size-7 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/coq/">coq</a><span class="count">(3)</span></li>
          <li class="tag-cloud-size-4 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/coro/">coro</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-8 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/cpan/">cpan</a><span class="count">(5)</span></li>
          <li class="tag-cloud-size-4 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/crawl/">crawl</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-9"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/css/">css</a><span class="count">(30)</span></li>
          <li class="tag-cloud-size-4 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/ctags/">ctags</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-4 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/cthulhu/">cthulhu</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-10"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/culture/">culture</a><span class="count">(710)</span></li>
          <li class="tag-cloud-size-6 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/curl/">curl</a><span class="count">(2)</span></li>
          <li class="tag-cloud-size-4 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/curses/">curses</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-8 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/cv/">cv</a><span class="count">(7)</span></li>
          <li class="tag-cloud-size-3 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/cvs/">cvs</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-7 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/cygwin/">cygwin</a><span class="count">(3)</span></li>
          <li class="tag-cloud-size-9 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/d/">d</a><span class="count">(13)</span></li>
          <li class="tag-cloud-size-6 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/daapd/">daapd</a><span class="count">(2)</span></li>
          <li class="tag-cloud-size-7 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/dankogai/">dankogai</a><span class="count">(3)</span></li>
          <li class="tag-cloud-size-7 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/darcs/">darcs</a><span class="count">(3)</span></li>
          <li class="tag-cloud-size-3 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/darkknight/">darkknight</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-3 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/data/">data</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-3 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/db/">db</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-3 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/dbd/">dbd</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-3 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/dbic/">dbic</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-8 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/deadrising/">deadrising</a><span class="count">(7)</span></li>
          <li class="tag-cloud-size-3 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/deadspace/">deadspace</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-8 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/debian/">debian</a><span class="count">(6)</span></li>
          <li class="tag-cloud-size-6 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/debug/">debug</a><span class="count">(2)</span></li>
          <li class="tag-cloud-size-3 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/deflate/">deflate</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-8 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/del.icio.us/">del.icio.us</a><span class="count">(12)</span></li>
          <li class="tag-cloud-size-3 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/delivery/">delivery</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-9"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/design/">design</a><span class="count">(30)</span></li>
          <li class="tag-cloud-size-3 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/desktop/">desktop</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-9"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/development/">development</a><span class="count">(45)</span></li>
          <li class="tag-cloud-size-6 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/diagram/">diagram</a><span class="count">(2)</span></li>
          <li class="tag-cloud-size-3 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/diary/">diary</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-6 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/dictionary/">dictionary</a><span class="count">(2)</span></li>
          <li class="tag-cloud-size-7 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/digg/">digg</a><span class="count">(3)</span></li>
          <li class="tag-cloud-size-6 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/directx/">directx</a><span class="count">(2)</span></li>
          <li class="tag-cloud-size-3 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/dlc/">dlc</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-6 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/dlna/">dlna</a><span class="count">(2)</span></li>
          <li class="tag-cloud-size-3 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/dns/">dns</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-6 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/docomo/">docomo</a><span class="count">(2)</span></li>
          <li class="tag-cloud-size-7 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/docs/">docs</a><span class="count">(3)</span></li>
          <li class="tag-cloud-size-3 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/document/">document</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-8 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/documentation/">documentation</a><span class="count">(9)</span></li>
          <li class="tag-cloud-size-3 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/dojo/">dojo</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-3 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/dolls/">dolls</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-9 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/dom/">dom</a><span class="count">(13)</span></li>
          <li class="tag-cloud-size-8 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/drawing/">drawing</a><span class="count">(11)</span></li>
          <li class="tag-cloud-size-3 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/dropbox/">dropbox</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-3 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/ds/">ds</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-6 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/dsi/">dsi</a><span class="count">(2)</span></li>
          <li class="tag-cloud-size-3 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/dungeon/">dungeon</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-3 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/dvd/">dvd</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-3 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/dvorak/">dvorak</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-3 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/e/">e</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-7 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/e4x/">e4x</a><span class="count">(3)</span></li>
          <li class="tag-cloud-size-7 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/ecmascript/">ecmascript</a><span class="count">(4)</span></li>
          <li class="tag-cloud-size-3 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/edf3/">edf3</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-6 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/editor/">editor</a><span class="count">(2)</span></li>
          <li class="tag-cloud-size-3 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/emacs/">emacs</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-7 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/email/">email</a><span class="count">(3)</span></li>
          <li class="tag-cloud-size-6 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/emulator/">emulator</a><span class="count">(2)</span></li>
          <li class="tag-cloud-size-3 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/encyclopedia/">encyclopedia</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-3 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/engine/">engine</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-8 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/english/">english</a><span class="count">(5)</span></li>
          <li class="tag-cloud-size-7 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/environment/">environment</a><span class="count">(3)</span></li>
          <li class="tag-cloud-size-3 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/envy/">envy</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-6 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/episode/">episode</a><span class="count">(2)</span></li>
          <li class="tag-cloud-size-6 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/erlang/">erlang</a><span class="count">(2)</span></li>
          <li class="tag-cloud-size-6 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/ero/">ero</a><span class="count">(2)</span></li>
          <li class="tag-cloud-size-3 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/eroge/">eroge</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-3 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/evaluation/">evaluation</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-8 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/event/">event</a><span class="count">(6)</span></li>
          <li class="tag-cloud-size-3 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/excel/">excel</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-9"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/extension/">extension</a><span class="count">(34)</span></li>
          <li class="tag-cloud-size-3 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/face/">face</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-8 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/fantasy/">fantasy</a><span class="count">(10)</span></li>
          <li class="tag-cloud-size-3 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/fastcgi/">fastcgi</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-3 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/fcwrap/">fcwrap</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-3 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/featuretracking/">featuretracking</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-7 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/feed/">feed</a><span class="count">(3)</span></li>
          <li class="tag-cloud-size-6 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/fez/">fez</a><span class="count">(2)</span></li>
          <li class="tag-cloud-size-3 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/ff8/">ff8</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-3 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/figures/">figures</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-3 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/fileformat/">fileformat</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-7 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/firebug/">firebug</a><span class="count">(4)</span></li>
          <li class="tag-cloud-size-3 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/firefly/">firefly</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-10"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/firefox/">firefox</a><span class="count">(102)</span></li>
          <li class="tag-cloud-size-9"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/flash/">flash</a><span class="count">(52)</span></li>
          <li class="tag-cloud-size-3 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/flets/">flets</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-8 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/flex/">flex</a><span class="count">(9)</span></li>
          <li class="tag-cloud-size-7 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/flickr/">flickr</a><span class="count">(3)</span></li>
          <li class="tag-cloud-size-3 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/fold/">fold</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-9 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/font/">font</a><span class="count">(17)</span></li>
          <li class="tag-cloud-size-8 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/foobar2000/">foobar2000</a><span class="count">(6)</span></li>
          <li class="tag-cloud-size-8 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/food/">food</a><span class="count">(8)</span></li>
          <li class="tag-cloud-size-6 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/fotolife/">fotolife</a><span class="count">(2)</span></li>
          <li class="tag-cloud-size-3 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/fps/">fps</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-7 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/fractal/">fractal</a><span class="count">(3)</span></li>
          <li class="tag-cloud-size-3 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/framework/">framework</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-6 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/frp/">frp</a><span class="count">(2)</span></li>
          <li class="tag-cloud-size-6 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/fuba/">fuba</a><span class="count">(2)</span></li>
          <li class="tag-cloud-size-9 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/fun/">fun</a><span class="count">(23)</span></li>
          <li class="tag-cloud-size-9 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/functional/">functional</a><span class="count">(14)</span></li>
          <li class="tag-cloud-size-10"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/game/">game</a><span class="count">(203)</span></li>
          <li class="tag-cloud-size-9 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/gauche/">gauche</a><span class="count">(18)</span></li>
          <li class="tag-cloud-size-3 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/gba/">gba</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-6 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/gdi%2B/">gdi+</a><span class="count">(2)</span></li>
          <li class="tag-cloud-size-3 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/gearman/">gearman</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-3 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/gecko/">gecko</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-3 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/ged/">ged</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-3 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/geek/">geek</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-7 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/generator/">generator</a><span class="count">(3)</span></li>
          <li class="tag-cloud-size-3 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/genetic/">genetic</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-6 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/ghc/">ghc</a><span class="count">(2)</span></li>
          <li class="tag-cloud-size-3 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/ghibli/">ghibli</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-7 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/gif/">gif</a><span class="count">(3)</span></li>
          <li class="tag-cloud-size-8 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/girl/">girl</a><span class="count">(5)</span></li>
          <li class="tag-cloud-size-6 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/gist/">gist</a><span class="count">(2)</span></li>
          <li class="tag-cloud-size-9"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/git/">git</a><span class="count">(39)</span></li>
          <li class="tag-cloud-size-7 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/glitch/">glitch</a><span class="count">(3)</span></li>
          <li class="tag-cloud-size-8 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/gmail/">gmail</a><span class="count">(8)</span></li>
          <li class="tag-cloud-size-6 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/gnu/">gnu</a><span class="count">(2)</span></li>
          <li class="tag-cloud-size-3 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/gnuplot/">gnuplot</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-3 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/god/">god</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-6 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/golf/">golf</a><span class="count">(2)</span></li>
          <li class="tag-cloud-size-3 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/goo/">goo</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-9"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/google/">google</a><span class="count">(36)</span></li>
          <li class="tag-cloud-size-8 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/googlechrome/">googlechrome</a><span class="count">(5)</span></li>
          <li class="tag-cloud-size-3 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/googlegears/">googlegears</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-6 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/gow/">gow</a><span class="count">(2)</span></li>
          <li class="tag-cloud-size-3 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/gps/">gps</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-6 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/graph/">graph</a><span class="count">(2)</span></li>
          <li class="tag-cloud-size-8 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/graphics/">graphics</a><span class="count">(5)</span></li>
          <li class="tag-cloud-size-3 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/grass/">grass</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-9"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/greasemonkey/">greasemonkey</a><span class="count">(46)</span></li>
          <li class="tag-cloud-size-3 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/gta4/">gta4</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-3 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/gtalk/">gtalk</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-3 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/guid/">guid</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-8 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/guide/">guide</a><span class="count">(5)</span></li>
          <li class="tag-cloud-size-8 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/guitar/">guitar</a><span class="count">(9)</span></li>
          <li class="tag-cloud-size-3 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/gundam/">gundam</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-5 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/hack/">hack</a><span class="count">(2)</span></li>
          <li class="tag-cloud-size-3 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/hackpact/">hackpact</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-8 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/hacks/">hacks</a><span class="count">(5)</span></li>
          <li class="tag-cloud-size-3 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/haiku/">haiku</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-5 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/halo/">halo</a><span class="count">(2)</span></li>
          <li class="tag-cloud-size-9"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/haskell/">haskell</a><span class="count">(88)</span></li>
          <li class="tag-cloud-size-9"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/hatena/">hatena</a><span class="count">(91)</span></li>
          <li class="tag-cloud-size-8 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/hatena2009/">hatena2009</a><span class="count">(5)</span></li>
          <li class="tag-cloud-size-3 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/hatenastar/">hatenastar</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-3 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/hdd/">hdd</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-7 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/health/">health</a><span class="count">(4)</span></li>
          <li class="tag-cloud-size-8 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/hengband/">hengband</a><span class="count">(6)</span></li>
          <li class="tag-cloud-size-3 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/here-document/">here-document</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-8 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/hexic/">hexic</a><span class="count">(7)</span></li>
          <li class="tag-cloud-size-3 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/hideoki/">hideoki</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-5 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/hitode909/">hitode909</a><span class="count">(2)</span></li>
          <li class="tag-cloud-size-3 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/homebrew/">homebrew</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-5 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/horaguchi/">horaguchi</a><span class="count">(2)</span></li>
          <li class="tag-cloud-size-5 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/hosting/">hosting</a><span class="count">(2)</span></li>
          <li class="tag-cloud-size-3 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/hown/">hown</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-9"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/howto/">howto</a><span class="count">(70)</span></li>
          <li class="tag-cloud-size-3 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/hrhm/">hrhm</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-3 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/hsp/">hsp</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-9 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/html/">html</a><span class="count">(14)</span></li>
          <li class="tag-cloud-size-8 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/http/">http</a><span class="count">(11)</span></li>
          <li class="tag-cloud-size-7 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/iappli/">iappli</a><span class="count">(3)</span></li>
          <li class="tag-cloud-size-3 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/ico/">ico</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-7 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/icon/">icon</a><span class="count">(4)</span></li>
          <li class="tag-cloud-size-3 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/icpc/">icpc</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-3 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/id3/">id3</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-3 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/idea/">idea</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-3 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/identicon/">identicon</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-3 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/idiom/">idiom</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-3 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/idioms/">idioms</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-9 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/idolm%40ster/">idolm@ster</a><span class="count">(20)</span></li>
          <li class="tag-cloud-size-9 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/ie/">ie</a><span class="count">(22)</span></li>
          <li class="tag-cloud-size-3 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/iir/">iir</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-3 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/illust/">illust</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-3 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/im/">im</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-8 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/image/">image</a><span class="count">(11)</span></li>
          <li class="tag-cloud-size-7 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/ime/">ime</a><span class="count">(3)</span></li>
          <li class="tag-cloud-size-3 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/imode/">imode</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-5 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/incursion/">incursion</a><span class="count">(2)</span></li>
          <li class="tag-cloud-size-3 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/input/">input</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-2 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/inspircd/">inspircd</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-2 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/interface/">interface</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-5 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/intern/">intern</a><span class="count">(2)</span></li>
          <li class="tag-cloud-size-8 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/internet/">internet</a><span class="count">(5)</span></li>
          <li class="tag-cloud-size-5 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/interpreter/">interpreter</a><span class="count">(2)</span></li>
          <li class="tag-cloud-size-2 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/ip/">ip</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-2 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/ipad/">ipad</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-8 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/iphone/">iphone</a><span class="count">(12)</span></li>
          <li class="tag-cloud-size-8 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/ipod/">ipod</a><span class="count">(9)</span></li>
          <li class="tag-cloud-size-2 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/iptables/">iptables</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-2 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/ipv6/">ipv6</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-2 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/irb/">irb</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-8 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/irc/">irc</a><span class="count">(9)</span></li>
          <li class="tag-cloud-size-5 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/ita/">ita</a><span class="count">(2)</span></li>
          <li class="tag-cloud-size-2 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/iterator/">iterator</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-7 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/itunes/">itunes</a><span class="count">(4)</span></li>
          <li class="tag-cloud-size-2 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/j/">j</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-6 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/japan/">japan</a><span class="count">(3)</span></li>
          <li class="tag-cloud-size-8 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/japanese/">japanese</a><span class="count">(11)</span></li>
          <li class="tag-cloud-size-8 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/java/">java</a><span class="count">(6)</span></li>
          <li class="tag-cloud-size-10"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/javascript/">javascript</a><span class="count">(269)</span></li>
          <li class="tag-cloud-size-2 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/jojo/">jojo</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-2 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/journalism/">journalism</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-5 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/joy/">joy</a><span class="count">(2)</span></li>
          <li class="tag-cloud-size-6 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/jquery/">jquery</a><span class="count">(3)</span></li>
          <li class="tag-cloud-size-2 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/jsan/">jsan</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-6 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/json/">json</a><span class="count">(3)</span></li>
          <li class="tag-cloud-size-2 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/kansai.pm/">kansai.pm</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-5 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/kawasaki/">kawasaki</a><span class="count">(2)</span></li>
          <li class="tag-cloud-size-5 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/kayac/">kayac</a><span class="count">(2)</span></li>
          <li class="tag-cloud-size-2 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/kemuri/">kemuri</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-2 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/key/">key</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-2 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/keybind/">keybind</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-5 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/keyboard/">keyboard</a><span class="count">(2)</span></li>
          <li class="tag-cloud-size-7 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/keyconfig/">keyconfig</a><span class="count">(4)</span></li>
          <li class="tag-cloud-size-6 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/king-gainer/">king-gainer</a><span class="count">(3)</span></li>
          <li class="tag-cloud-size-2 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/king-show/">king-show</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-2 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/kiyohero/">kiyohero</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-5 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/klt/">klt</a><span class="count">(2)</span></li>
          <li class="tag-cloud-size-5 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/knowledge/">knowledge</a><span class="count">(2)</span></li>
          <li class="tag-cloud-size-6 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/kyoto/">kyoto</a><span class="count">(3)</span></li>
          <li class="tag-cloud-size-2 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/l4u/">l4u</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-7 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/lambda/">lambda</a><span class="count">(4)</span></li>
          <li class="tag-cloud-size-9 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/language/">language</a><span class="count">(21)</span></li>
          <li class="tag-cloud-size-9 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/ldr/">ldr</a><span class="count">(22)</span></li>
          <li class="tag-cloud-size-9 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/lecture/">lecture</a><span class="count">(19)</span></li>
          <li class="tag-cloud-size-2 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/lemmings/">lemmings</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-9 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/library/">library</a><span class="count">(17)</span></li>
          <li class="tag-cloud-size-7 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/license/">license</a><span class="count">(4)</span></li>
          <li class="tag-cloud-size-10"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/life/">life</a><span class="count">(123)</span></li>
          <li class="tag-cloud-size-8 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/lifehack/">lifehack</a><span class="count">(7)</span></li>
          <li class="tag-cloud-size-7 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/lighttpd/">lighttpd</a><span class="count">(4)</span></li>
          <li class="tag-cloud-size-5 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/lilypond/">lilypond</a><span class="count">(2)</span></li>
          <li class="tag-cloud-size-6 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/limechat/">limechat</a><span class="count">(3)</span></li>
          <li class="tag-cloud-size-5 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/lingr/">lingr</a><span class="count">(2)</span></li>
          <li class="tag-cloud-size-9"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/linux/">linux</a><span class="count">(45)</span></li>
          <li class="tag-cloud-size-9"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/lisp/">lisp</a><span class="count">(33)</span></li>
          <li class="tag-cloud-size-8 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/livedoor/">livedoor</a><span class="count">(6)</span></li>
          <li class="tag-cloud-size-8 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/logic/">logic</a><span class="count">(11)</span></li>
          <li class="tag-cloud-size-7 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/lostplanet/">lostplanet</a><span class="count">(5)</span></li>
          <li class="tag-cloud-size-7 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/lotr/">lotr</a><span class="count">(5)</span></li>
          <li class="tag-cloud-size-8 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/lua/">lua</a><span class="count">(7)</span></li>
          <li class="tag-cloud-size-2 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/lzh/">lzh</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-2 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/ma.la/">ma.la</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-2 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/mac/">mac</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-7 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/machine_learning/">machine_learning</a><span class="count">(5)</span></li>
          <li class="tag-cloud-size-5 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/macro/">macro</a><span class="count">(2)</span></li>
          <li class="tag-cloud-size-7 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/mad/">mad</a><span class="count">(4)</span></li>
          <li class="tag-cloud-size-2 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/magazine/">magazine</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-2 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/maid/">maid</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-2 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/makefile/">makefile</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-7 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/mala/">mala</a><span class="count">(4)</span></li>
          <li class="tag-cloud-size-2 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/malloreon/">malloreon</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-5 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/man/">man</a><span class="count">(2)</span></li>
          <li class="tag-cloud-size-5 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/mandelbrot/">mandelbrot</a><span class="count">(2)</span></li>
          <li class="tag-cloud-size-2 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/manner/">manner</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-8 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/manual/">manual</a><span class="count">(7)</span></li>
          <li class="tag-cloud-size-7 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/map/">map</a><span class="count">(4)</span></li>
          <li class="tag-cloud-size-6 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/maps/">maps</a><span class="count">(3)</span></li>
          <li class="tag-cloud-size-5 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/markdown/">markdown</a><span class="count">(2)</span></li>
          <li class="tag-cloud-size-2 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/matching/">matching</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-9"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/math/">math</a><span class="count">(56)</span></li>
          <li class="tag-cloud-size-7 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/mathml/">mathml</a><span class="count">(4)</span></li>
          <li class="tag-cloud-size-2 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/matome/">matome</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-2 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/mayu/">mayu</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-2 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/mechanize/">mechanize</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-2 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/media/">media</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-5 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/mediacenter/">mediacenter</a><span class="count">(2)</span></li>
          <li class="tag-cloud-size-2 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/megane/">megane</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-7 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/messenger/">messenger</a><span class="count">(5)</span></li>
          <li class="tag-cloud-size-2 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/meta/">meta</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-5 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/metal/">metal</a><span class="count">(2)</span></li>
          <li class="tag-cloud-size-2 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/metapost/">metapost</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-2 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/metaprogramming/">metaprogramming</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-2 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/mht/">mht</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-7 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/microformats/">microformats</a><span class="count">(5)</span></li>
          <li class="tag-cloud-size-2 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/microsoft/">microsoft</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-6 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/migemo/">migemo</a><span class="count">(3)</span></li>
          <li class="tag-cloud-size-6 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/minesweeper/">minesweeper</a><span class="count">(3)</span></li>
          <li class="tag-cloud-size-5 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/mingw/">mingw</a><span class="count">(2)</span></li>
          <li class="tag-cloud-size-5 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/mixi/">mixi</a><span class="count">(2)</span></li>
          <li class="tag-cloud-size-2 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/mmc/">mmc</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-5 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/mml/">mml</a><span class="count">(2)</span></li>
          <li class="tag-cloud-size-6 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/mobile/">mobile</a><span class="count">(3)</span></li>
          <li class="tag-cloud-size-5 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/mochikit/">mochikit</a><span class="count">(2)</span></li>
          <li class="tag-cloud-size-2 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/moco/">moco</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-2 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/mojo/">mojo</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-2 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/mom/">mom</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-8 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/monad/">monad</a><span class="count">(12)</span></li>
          <li class="tag-cloud-size-5 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/motemen/">motemen</a><span class="count">(2)</span></li>
          <li class="tag-cloud-size-8 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/movie/">movie</a><span class="count">(11)</span></li>
          <li class="tag-cloud-size-9"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/mozilla/">mozilla</a><span class="count">(44)</span></li>
          <li class="tag-cloud-size-6 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/mozrepl/">mozrepl</a><span class="count">(3)</span></li>
          <li class="tag-cloud-size-2 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/mp3/">mp3</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-2 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/msdn/">msdn</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-2 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/msdos/">msdos</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-7 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/msn/">msn</a><span class="count">(5)</span></li>
          <li class="tag-cloud-size-2 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/mtg/">mtg</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-2 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/mud/">mud</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-9"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/music/">music</a><span class="count">(41)</span></li>
          <li class="tag-cloud-size-8 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/mysql/">mysql</a><span class="count">(8)</span></li>
          <li class="tag-cloud-size-5 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/mzscheme/">mzscheme</a><span class="count">(2)</span></li>
          <li class="tag-cloud-size-2 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/n-gram/">n-gram</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-2 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/name/">name</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-7 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/naoya/">naoya</a><span class="count">(4)</span></li>
          <li class="tag-cloud-size-2 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/nasa/">nasa</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-2 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/neet/">neet</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-9"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/neta/">neta</a><span class="count">(56)</span></li>
          <li class="tag-cloud-size-7 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/nethack/">nethack</a><span class="count">(4)</span></li>
          <li class="tag-cloud-size-5 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/netradio/">netradio</a><span class="count">(2)</span></li>
          <li class="tag-cloud-size-5 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/netwatch/">netwatch</a><span class="count">(2)</span></li>
          <li class="tag-cloud-size-8 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/network/">network</a><span class="count">(7)</span></li>
          <li class="tag-cloud-size-2 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/neuralnetwork/">neuralnetwork</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-2 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/news/">news</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-2 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/nhk/">nhk</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-9 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/nicomas/">nicomas</a><span class="count">(25)</span></li>
          <li class="tag-cloud-size-9"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/nicovideo/">nicovideo</a><span class="count">(39)</span></li>
          <li class="tag-cloud-size-6 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/ninjinkun/">ninjinkun</a><span class="count">(3)</span></li>
          <li class="tag-cloud-size-7 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/nlp/">nlp</a><span class="count">(4)</span></li>
          <li class="tag-cloud-size-7 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/oblivion/">oblivion</a><span class="count">(5)</span></li>
          <li class="tag-cloud-size-6 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/ocaml/">ocaml</a><span class="count">(3)</span></li>
          <li class="tag-cloud-size-5 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/occult/">occult</a><span class="count">(2)</span></li>
          <li class="tag-cloud-size-2 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/ogg/">ogg</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-2 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/omake/">omake</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-6 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/oop/">oop</a><span class="count">(3)</span></li>
          <li class="tag-cloud-size-6 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/opencv/">opencv</a><span class="count">(3)</span></li>
          <li class="tag-cloud-size-2 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/opengl/">opengl</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-2 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/openid/">openid</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-2 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/opensocial/">opensocial</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-6 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/opera/">opera</a><span class="count">(3)</span></li>
          <li class="tag-cloud-size-5 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/opml/">opml</a><span class="count">(2)</span></li>
          <li class="tag-cloud-size-2 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/orm/">orm</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-2 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/orz/">orz</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-2 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/otune/">otune</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-7 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/p2p/">p2p</a><span class="count">(5)</span></li>
          <li class="tag-cloud-size-9 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/paper/">paper</a><span class="count">(17)</span></li>
          <li class="tag-cloud-size-6 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/parser/">parser</a><span class="count">(3)</span></li>
          <li class="tag-cloud-size-8 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/parsing/">parsing</a><span class="count">(9)</span></li>
          <li class="tag-cloud-size-2 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/password/">password</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-8 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/pattern/">pattern</a><span class="count">(6)</span></li>
          <li class="tag-cloud-size-2 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/pda/">pda</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-6 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/pdf/">pdf</a><span class="count">(3)</span></li>
          <li class="tag-cloud-size-2 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/people/">people</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-10"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/perl/">perl</a><span class="count">(133)</span></li>
          <li class="tag-cloud-size-8 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/person/">person</a><span class="count">(11)</span></li>
          <li class="tag-cloud-size-5 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/pfi/">pfi</a><span class="count">(2)</span></li>
          <li class="tag-cloud-size-8 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/photo/">photo</a><span class="count">(10)</span></li>
          <li class="tag-cloud-size-2 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/photograph/">photograph</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-6 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/php/">php</a><span class="count">(3)</span></li>
          <li class="tag-cloud-size-2 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/physics/">physics</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-2 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/pic/">pic</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-2 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/picbbs/">picbbs</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-2 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/picture/">picture</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-2 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/pipes/">pipes</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-2 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/piro/">piro</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-5 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/pixiv/">pixiv</a><span class="count">(2)</span></li>
          <li class="tag-cloud-size-2 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/plack/">plack</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-8 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/plagger/">plagger</a><span class="count">(10)</span></li>
          <li class="tag-cloud-size-2 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/pms/">pms</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-5 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/png/">png</a><span class="count">(2)</span></li>
          <li class="tag-cloud-size-2 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/poem/">poem</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-8 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/portal/">portal</a><span class="count">(11)</span></li>
          <li class="tag-cloud-size-2 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/postgresql/">postgresql</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-5 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/postscript/">postscript</a><span class="count">(2)</span></li>
          <li class="tag-cloud-size-2 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/powershell/">powershell</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-8 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/presentation/">presentation</a><span class="count">(9)</span></li>
          <li class="tag-cloud-size-5 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/prism/">prism</a><span class="count">(2)</span></li>
          <li class="tag-cloud-size-5 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/program/">program</a><span class="count">(2)</span></li>
          <li class="tag-cloud-size-9"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/programming/">programming</a><span class="count">(78)</span></li>
          <li class="tag-cloud-size-2 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/programming-by-demonstration/">programming-by-demonstration</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-2 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/prolog/">prolog</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-6 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/protocol/">protocol</a><span class="count">(3)</span></li>
          <li class="tag-cloud-size-8 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/prototype.js/">prototype.js</a><span class="count">(6)</span></li>
          <li class="tag-cloud-size-6 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/proxy/">proxy</a><span class="count">(3)</span></li>
          <li class="tag-cloud-size-5 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/ps3/">ps3</a><span class="count">(2)</span></li>
          <li class="tag-cloud-size-7 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/psp/">psp</a><span class="count">(5)</span></li>
          <li class="tag-cloud-size-6 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/putty/">putty</a><span class="count">(3)</span></li>
          <li class="tag-cloud-size-5 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/puzzle/">puzzle</a><span class="count">(2)</span></li>
          <li class="tag-cloud-size-2 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/pv3d/">pv3d</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-8 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/python/">python</a><span class="count">(6)</span></li>
          <li class="tag-cloud-size-1 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/quantum/">quantum</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-6 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/quine/">quine</a><span class="count">(3)</span></li>
          <li class="tag-cloud-size-5 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/quiz/">quiz</a><span class="count">(2)</span></li>
          <li class="tag-cloud-size-1 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/r5rs/">r5rs</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-1 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/r6rs/">r6rs</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-1 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/r6v/">r6v</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-6 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/radio/">radio</a><span class="count">(3)</span></li>
          <li class="tag-cloud-size-9 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/rails/">rails</a><span class="count">(18)</span></li>
          <li class="tag-cloud-size-1 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/rainbowsixvegas/">rainbowsixvegas</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-1 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/raquo/">raquo</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-7 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/rdf/">rdf</a><span class="count">(4)</span></li>
          <li class="tag-cloud-size-5 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/reactive/">reactive</a><span class="count">(2)</span></li>
          <li class="tag-cloud-size-1 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/reader/">reader</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-5 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/readline/">readline</a><span class="count">(2)</span></li>
          <li class="tag-cloud-size-1 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/readN/">readN</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-9"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/read_later/">read_later</a><span class="count">(80)</span></li>
          <li class="tag-cloud-size-1 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/recipe/">recipe</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-1 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/recommendation/">recommendation</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-1 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/redmine/">redmine</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-9"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/reference/">reference</a><span class="count">(80)</span></li>
          <li class="tag-cloud-size-7 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/regexp/">regexp</a><span class="count">(5)</span></li>
          <li class="tag-cloud-size-5 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/remedie/">remedie</a><span class="count">(2)</span></li>
          <li class="tag-cloud-size-5 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/research/">research</a><span class="count">(2)</span></li>
          <li class="tag-cloud-size-8 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/rest/">rest</a><span class="count">(6)</span></li>
          <li class="tag-cloud-size-7 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/rfc/">rfc</a><span class="count">(4)</span></li>
          <li class="tag-cloud-size-1 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/rhetoric/">rhetoric</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-1 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/rhino/">rhino</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-1 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/rimo/">rimo</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-1 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/robot/">robot</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-9"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/roguelike/">roguelike</a><span class="count">(41)</span></li>
          <li class="tag-cloud-size-5 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/rpm/">rpm</a><span class="count">(2)</span></li>
          <li class="tag-cloud-size-9 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/rss/">rss</a><span class="count">(16)</span></li>
          <li class="tag-cloud-size-1 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/rsync/">rsync</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-7 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/rtm/">rtm</a><span class="count">(4)</span></li>
          <li class="tag-cloud-size-9"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/ruby/">ruby</a><span class="count">(44)</span></li>
          <li class="tag-cloud-size-5 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/rubygems/">rubygems</a><span class="count">(2)</span></li>
          <li class="tag-cloud-size-1 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/ryvius/">ryvius</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-5 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/s3/">s3</a><span class="count">(2)</span></li>
          <li class="tag-cloud-size-5 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/safari/">safari</a><span class="count">(2)</span></li>
          <li class="tag-cloud-size-1 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/safety/">safety</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-1 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/satzz/">satzz</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-1 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/sbm/">sbm</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-1 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/sbs/">sbs</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-6 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/scala/">scala</a><span class="count">(3)</span></li>
          <li class="tag-cloud-size-1 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/scalatest/">scalatest</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-1 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/scales/">scales</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-9"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/scheme/">scheme</a><span class="count">(43)</span></li>
          <li class="tag-cloud-size-9 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/science/">science</a><span class="count">(14)</span></li>
          <li class="tag-cloud-size-1 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/scifi/">scifi</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-1 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/scilab/">scilab</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-8 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/screen/">screen</a><span class="count">(8)</span></li>
          <li class="tag-cloud-size-6 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/script/">script</a><span class="count">(3)</span></li>
          <li class="tag-cloud-size-1 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/script.aculo.us/">script.aculo.us</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-1 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/scripting/">scripting</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-5 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/sdk/">sdk</a><span class="count">(2)</span></li>
          <li class="tag-cloud-size-1 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/sdl/">sdl</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-9 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/search/">search</a><span class="count">(13)</span></li>
          <li class="tag-cloud-size-7 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/secondlife/">secondlife</a><span class="count">(4)</span></li>
          <li class="tag-cloud-size-9 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/security/">security</a><span class="count">(14)</span></li>
          <li class="tag-cloud-size-1 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/selector/">selector</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-1 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/selenium/">selenium</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-5 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/self/">self</a><span class="count">(2)</span></li>
          <li class="tag-cloud-size-1 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/semantic/">semantic</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-5 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/semantics/">semantics</a><span class="count">(2)</span></li>
          <li class="tag-cloud-size-1 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/seo/">seo</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-5 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/server/">server</a><span class="count">(2)</span></li>
          <li class="tag-cloud-size-9"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/service/">service</a><span class="count">(29)</span></li>
          <li class="tag-cloud-size-1 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/sheet/">sheet</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-7 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/shell/">shell</a><span class="count">(5)</span></li>
          <li class="tag-cloud-size-7 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/shibuya.js/">shibuya.js</a><span class="count">(4)</span></li>
          <li class="tag-cloud-size-1 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/shibuya.lisp/">shibuya.lisp</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-5 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/sicp/">sicp</a><span class="count">(2)</span></li>
          <li class="tag-cloud-size-1 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/sinatra/">sinatra</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-1 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/skating/">skating</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-1 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/skk/">skk</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-5 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/slide/">slide</a><span class="count">(2)</span></li>
          <li class="tag-cloud-size-7 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/sns/">sns</a><span class="count">(4)</span></li>
          <li class="tag-cloud-size-5 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/soap/">soap</a><span class="count">(2)</span></li>
          <li class="tag-cloud-size-8 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/society/">society</a><span class="count">(7)</span></li>
          <li class="tag-cloud-size-1 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/socks/">socks</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-9 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/software/">software</a><span class="count">(26)</span></li>
          <li class="tag-cloud-size-1 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/space/">space</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-6 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/specification/">specification</a><span class="count">(3)</span></li>
          <li class="tag-cloud-size-5 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/spidermonkey/">spidermonkey</a><span class="count">(2)</span></li>
          <li class="tag-cloud-size-1 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/spin/">spin</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-7 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/sql/">sql</a><span class="count">(5)</span></li>
          <li class="tag-cloud-size-6 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/squid/">squid</a><span class="count">(3)</span></li>
          <li class="tag-cloud-size-1 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/srfi/">srfi</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-8 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/ssh/">ssh</a><span class="count">(6)</span></li>
          <li class="tag-cloud-size-1 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/statistics/">statistics</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-1 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/Steins%3BGate/">Steins;Gate</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-5 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/steinsgate/">steinsgate</a><span class="count">(2)</span></li>
          <li class="tag-cloud-size-1 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/strftime/">strftime</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-1 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/studio/">studio</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-9 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/study/">study</a><span class="count">(13)</span></li>
          <li class="tag-cloud-size-8 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/subversion/">subversion</a><span class="count">(8)</span></li>
          <li class="tag-cloud-size-1 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/sumo/">sumo</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-1 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/svchost.exe/">svchost.exe</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-6 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/svg/">svg</a><span class="count">(3)</span></li>
          <li class="tag-cloud-size-7 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/svk/">svk</a><span class="count">(4)</span></li>
          <li class="tag-cloud-size-6 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/svm/">svm</a><span class="count">(3)</span></li>
          <li class="tag-cloud-size-1 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/swfobject/">swfobject</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-1 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/sxpath/">sxpath</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-1 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/syntax-rule/">syntax-rule</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-1 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/systemF/">systemF</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-1 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/tagging/">tagging</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-1 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/tags/">tags</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-1 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/talk/">talk</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-5 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/tap/">tap</a><span class="count">(2)</span></li>
          <li class="tag-cloud-size-1 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/tcsh/">tcsh</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-5 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/tea/">tea</a><span class="count">(2)</span></li>
          <li class="tag-cloud-size-1 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/tech/">tech</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-6 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/technology/">technology</a><span class="count">(3)</span></li>
          <li class="tag-cloud-size-5 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/templatehaskell/">templatehaskell</a><span class="count">(2)</span></li>
          <li class="tag-cloud-size-1 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/templates/">templates</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-1 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/terminal/">terminal</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-6 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/test/">test</a><span class="count">(3)</span></li>
          <li class="tag-cloud-size-8 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/tex/">tex</a><span class="count">(11)</span></li>
          <li class="tag-cloud-size-7 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/text/">text</a><span class="count">(5)</span></li>
          <li class="tag-cloud-size-1 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/theorems/">theorems</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-1 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/theory/">theory</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-1 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/theschwartz/">theschwartz</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-1 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/thinkpad/">thinkpad</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-1 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/thrift/">thrift</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-6 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/thunderbird/">thunderbird</a><span class="count">(3)</span></li>
          <li class="tag-cloud-size-1 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/tiling/">tiling</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-9"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/tips/">tips</a><span class="count">(63)</span></li>
          <li class="tag-cloud-size-1 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/todesking/">todesking</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-5 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/tokyo/">tokyo</a><span class="count">(2)</span></li>
          <li class="tag-cloud-size-5 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/tokyotyrant/">tokyotyrant</a><span class="count">(2)</span></li>
          <li class="tag-cloud-size-1 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/tolkien/">tolkien</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-5 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/tombloo/">tombloo</a><span class="count">(2)</span></li>
          <li class="tag-cloud-size-1 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/tome/">tome</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-9"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/tool/">tool</a><span class="count">(49)</span></li>
          <li class="tag-cloud-size-8 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/tov/">tov</a><span class="count">(6)</span></li>
          <li class="tag-cloud-size-1 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/trac/">trac</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-1 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/trailer/">trailer</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-1 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/travel/">travel</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-1 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/trick/">trick</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-1 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/tropy/">tropy</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-1 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/troubleshooting/">troubleshooting</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-1 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/trpg/">trpg</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-1 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/tshirt/">tshirt</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-7 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/tumblr/">tumblr</a><span class="count">(5)</span></li>
          <li class="tag-cloud-size-9"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/tutorial/">tutorial</a><span class="count">(27)</span></li>
          <li class="tag-cloud-size-8 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/tv/">tv</a><span class="count">(9)</span></li>
          <li class="tag-cloud-size-1 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/tweener/">tweener</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-9 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/twitter/">twitter</a><span class="count">(14)</span></li>
          <li class="tag-cloud-size-5 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/type/">type</a><span class="count">(2)</span></li>
          <li class="tag-cloud-size-1 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/typect/">typect</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-1 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/types/">types</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-1 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/typestar/">typestar</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-5 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/typester/">typester</a><span class="count">(2)</span></li>
          <li class="tag-cloud-size-5 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/ubiquity/">ubiquity</a><span class="count">(2)</span></li>
          <li class="tag-cloud-size-9"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/ugomemo/">ugomemo</a><span class="count">(35)</span></li>
          <li class="tag-cloud-size-8 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/ui/">ui</a><span class="count">(7)</span></li>
          <li class="tag-cloud-size-1 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/unc/">unc</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-7 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/unicode/">unicode</a><span class="count">(5)</span></li>
          <li class="tag-cloud-size-1 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/uniform/">uniform</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-0 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/univ/">univ</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-8 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/unix/">unix</a><span class="count">(8)</span></li>
          <li class="tag-cloud-size-5 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/unko/">unko</a><span class="count">(2)</span></li>
          <li class="tag-cloud-size-0 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/unlambda/">unlambda</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-0 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/untangle/">untangle</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-0 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/upnp/">upnp</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-0 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/url/">url</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-8 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/userchrome/">userchrome</a><span class="count">(6)</span></li>
          <li class="tag-cloud-size-5 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/ustream/">ustream</a><span class="count">(2)</span></li>
          <li class="tag-cloud-size-8 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/vc/">vc</a><span class="count">(6)</span></li>
          <li class="tag-cloud-size-0 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/veoh/">veoh</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-9 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/video/">video</a><span class="count">(20)</span></li>
          <li class="tag-cloud-size-10"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/vim/">vim</a><span class="count">(97)</span></li>
          <li class="tag-cloud-size-5 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/vimperator/">vimperator</a><span class="count">(2)</span></li>
          <li class="tag-cloud-size-0 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/virtualbox/">virtualbox</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-7 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/vista/">vista</a><span class="count">(5)</span></li>
          <li class="tag-cloud-size-0 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/visual/">visual</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-9 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/visualization/">visualization</a><span class="count">(14)</span></li>
          <li class="tag-cloud-size-5 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/vm/">vm</a><span class="count">(2)</span></li>
          <li class="tag-cloud-size-5 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/vmware/">vmware</a><span class="count">(2)</span></li>
          <li class="tag-cloud-size-5 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/vpn/">vpn</a><span class="count">(2)</span></li>
          <li class="tag-cloud-size-0 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/vps/">vps</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-0 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/vsftpd/">vsftpd</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-0 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/vty/">vty</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-5 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/w3c/">w3c</a><span class="count">(2)</span></li>
          <li class="tag-cloud-size-0 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/wakabatan/">wakabatan</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-0 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/watch/">watch</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-5 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/weather/">weather</a><span class="count">(2)</span></li>
          <li class="tag-cloud-size-9"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/web/">web</a><span class="count">(69)</span></li>
          <li class="tag-cloud-size-6 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/web2.0/">web2.0</a><span class="count">(3)</span></li>
          <li class="tag-cloud-size-0 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/webdav/">webdav</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-0 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/webdesign/">webdesign</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-0 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/weblog/">weblog</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-9"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/webservice/">webservice</a><span class="count">(27)</span></li>
          <li class="tag-cloud-size-0 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/web%E6%BC%AB%E7%94%BB/">web漫画</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-6 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/wii/">wii</a><span class="count">(3)</span></li>
          <li class="tag-cloud-size-9 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/wiki/">wiki</a><span class="count">(22)</span></li>
          <li class="tag-cloud-size-6 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/wikipedia/">wikipedia</a><span class="count">(3)</span></li>
          <li class="tag-cloud-size-9"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/windows/">windows</a><span class="count">(57)</span></li>
          <li class="tag-cloud-size-5 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/windows7/">windows7</a><span class="count">(2)</span></li>
          <li class="tag-cloud-size-0 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/windows95/">windows95</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-8 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/wish/">wish</a><span class="count">(12)</span></li>
          <li class="tag-cloud-size-5 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/wmp/">wmp</a><span class="count">(2)</span></li>
          <li class="tag-cloud-size-6 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/words/">words</a><span class="count">(3)</span></li>
          <li class="tag-cloud-size-9 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/writing/">writing</a><span class="count">(20)</span></li>
          <li class="tag-cloud-size-6 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/wsh/">wsh</a><span class="count">(3)</span></li>
          <li class="tag-cloud-size-0 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/xbl/">xbl</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-0 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/xbla/">xbla</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-9"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/xbox/">xbox</a><span class="count">(97)</span></li>
          <li class="tag-cloud-size-0 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/xfn/">xfn</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-0 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/xhr/">xhr</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-0 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/xhtml/">xhtml</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-9"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/xml/">xml</a><span class="count">(27)</span></li>
          <li class="tag-cloud-size-0 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/xna/">xna</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-0 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/xp/">xp</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-8 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/xpath/">xpath</a><span class="count">(8)</span></li>
          <li class="tag-cloud-size-0 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/XPCNativeWrapper/">XPCNativeWrapper</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-9"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/xpcom/">xpcom</a><span class="count">(44)</span></li>
          <li class="tag-cloud-size-0 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/xquery/">xquery</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-0 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/xrea/">xrea</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-6 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/xs/">xs</a><span class="count">(3)</span></li>
          <li class="tag-cloud-size-7 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/xslt/">xslt</a><span class="count">(4)</span></li>
          <li class="tag-cloud-size-9"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/xul/">xul</a><span class="count">(29)</span></li>
          <li class="tag-cloud-size-0 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/y/">y</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-0 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/y-combinator/">y-combinator</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-7 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/yahoo/">yahoo</a><span class="count">(4)</span></li>
          <li class="tag-cloud-size-5 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/yaml/">yaml</a><span class="count">(2)</span></li>
          <li class="tag-cloud-size-0 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/yksk/">yksk</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-0 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/youpy/">youpy</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-9 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/youtube/">youtube</a><span class="count">(18)</span></li>
          <li class="tag-cloud-size-6 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/yurisii/">yurisii</a><span class="count">(3)</span></li>
          <li class="tag-cloud-size-0 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/zipper/">zipper</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-9"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/zsh/">zsh</a><span class="count">(27)</span></li>
          <li class="tag-cloud-size-9"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/_playlist/">_playlist</a><span class="count">(46)</span></li>
          <li class="tag-cloud-size-0 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/_trash/">_trash</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-0 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/%CE%BBC/">λC</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-0 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/%E2%98%85%E2%98%85%E2%98%85/">★★★</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-5 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/%E3%81%82%E3%81%A8%E3%81%A7/">あとで</a><span class="count">(2)</span></li>
          <li class="tag-cloud-size-0 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/%E3%81%82%E3%82%8B%E3%81%82%E3%82%8B/">あるある</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-5 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/%E3%81%84%E3%81%84%E8%A9%B1/">いい話</a><span class="count">(2)</span></li>
          <li class="tag-cloud-size-0 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/%E3%81%84%E3%81%A4%E3%81%8B%E8%A6%8B%E3%82%8B/">いつか見る</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-0 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/%E3%81%86%E3%82%93%E3%81%93/">うんこ</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-0 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/%E3%81%93%E3%82%8C%E3%81%AF%E3%81%B2%E3%81%A9%E3%81%84/">これはひどい</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-0 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/%E3%81%93%E3%82%93%E3%81%AB%E3%81%A1%E3%81%AF%E3%80%81%E3%81%8B%E3%82%8F%E3%81%84%E3%81%84/">こんにちは、かわいい</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-0 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/%E3%81%AA%E3%82%93%E3%81%A0%E3%81%93%E3%82%8C/">なんだこれ</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-0 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/%E3%82%A2%E3%82%A4%E3%82%B3%E3%83%B3/">アイコン</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-4 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/%E3%82%A2%E3%83%8B%E3%83%A1/">アニメ</a><span class="count">(2)</span></li>
          <li class="tag-cloud-size-0 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/%E3%82%A2%E3%83%9E%E3%82%AC%E3%83%9F/">アマガミ</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-0 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/%E3%82%A4%E3%83%A9%E3%82%B9%E3%83%88/">イラスト</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-0 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/%E3%82%AB%E3%83%94%E3%83%90%E3%83%A9/">カピバラ</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-4 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/%E3%82%B2%E3%83%BC%E3%83%A0/">ゲーム</a><span class="count">(2)</span></li>
          <li class="tag-cloud-size-0 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/%E3%82%B3%E3%83%B3%E3%83%86%E3%83%B3%E3%83%84/">コンテンツ</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-4 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/%E3%82%B5%E3%83%9E%E3%83%BC%E3%82%A6%E3%82%A9%E3%83%BC%E3%82%BA/">サマーウォーズ</a><span class="count">(2)</span></li>
          <li class="tag-cloud-size-7 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/%E3%82%B5%E3%83%B3%E3%83%89%E3%82%AD%E3%83%A3%E3%83%8B%E3%82%AA%E3%83%B3/">サンドキャニオン</a><span class="count">(4)</span></li>
          <li class="tag-cloud-size-7 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/%E3%83%89%E3%83%AA%E3%83%BC%E3%83%A0%E3%82%AF%E3%83%A9%E3%83%96/">ドリームクラブ</a><span class="count">(4)</span></li>
          <li class="tag-cloud-size-0 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/%E3%83%8D%E3%82%BF/">ネタ</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-0 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/%E3%83%8D%E3%83%88%E3%82%A6%E3%83%A8/">ネトウヨ</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-0 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/%E3%83%90%E3%83%BC%E3%83%AB%E3%81%AE%E3%82%88%E3%81%86%E3%81%AA%E3%82%82%E3%81%AE/">バールのようなもの</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-0 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/%E3%83%96%E3%82%AF%E3%83%9E%E7%A6%81%E6%AD%A2/">ブクマ禁止</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-4 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/%E3%83%A9%E3%83%96%E3%83%97%E3%83%A9%E3%82%B9/">ラブプラス</a><span class="count">(2)</span></li>
          <li class="tag-cloud-size-0 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/%E3%83%AA%E3%82%A2%E5%85%85/">リア充</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-4 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/%E4%BA%BA%E7%94%9F/">人生</a><span class="count">(2)</span></li>
          <li class="tag-cloud-size-0 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/%E5%84%AA%E7%A7%80%E3%81%AA%E5%AD%A6%E7%94%9F/">優秀な学生</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-0 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/%E5%89%B5%E4%BD%9C/">創作</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-8 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/%E5%8F%82%E8%80%83%E3%81%AB%E3%81%AA%E3%82%8B/">参考になる</a><span class="count">(7)</span></li>
          <li class="tag-cloud-size-0 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/%E5%8F%8C%E8%91%89%E7%90%86%E4%BF%9D/">双葉理保</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-0 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/%E5%8F%B0%E9%A2%A8/">台風</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-0 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/%E5%90%8C%E4%BA%BA/">同人</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-0 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/%E5%95%86%E5%93%81/">商品</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-7 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/%E5%A4%89%E6%85%8B/">変態</a><span class="count">(4)</span></li>
          <li class="tag-cloud-size-0 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/%E5%A4%A7%E6%A7%BB%E3%82%B1%E3%83%B3%E3%83%82/">大槻ケンヂ</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-0 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/%E5%AE%97%E6%95%99/">宗教</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-4 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/%E5%B9%B4%E5%8F%8E/">年収</a><span class="count">(2)</span></li>
          <li class="tag-cloud-size-0 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/%E6%94%BB%E6%AE%BB/">攻殻</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-7 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/%E6%96%87%E7%AB%A0/">文章</a><span class="count">(4)</span></li>
          <li class="tag-cloud-size-0 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/%E6%97%A5%E6%9C%AC%E8%AA%9E/">日本語</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-0 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/%E6%9C%8D/">服</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-4 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/%E6%9C%AC/">本</a><span class="count">(2)</span></li>
          <li class="tag-cloud-size-4 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/%E6%A4%9C%E7%B4%A2/">検索</a><span class="count">(2)</span></li>
          <li class="tag-cloud-size-0 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/%E6%B4%9E%E7%AA%9F%E7%89%A9%E8%AA%9E/">洞窟物語</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-0 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/%E6%BC%AB%E7%94%BB/">漫画</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-0 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/%E7%81%BD%E5%AE%B3/">災害</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-0 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/%E7%84%A1%E8%A8%80%E3%83%96%E3%82%AF%E3%83%9E/">無言ブクマ</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-0 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/%E7%89%A9%E8%AA%9E/">物語</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-0 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/%E7%89%B9%E8%A8%B1/">特許</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-0 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/%E7%8C%AB/">猫</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-0 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/%E7%94%B0%E6%9D%91%E3%82%86%E3%81%8B%E3%82%8A/">田村ゆかり</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-4 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/%E7%94%BB%E5%83%8F/">画像</a><span class="count">(2)</span></li>
          <li class="tag-cloud-size-0 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/%E7%9F%B3%E7%94%B0%E5%BD%B0/">石田彰</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-6 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/%E7%A4%BE%E4%BC%9A/">社会</a><span class="count">(3)</span></li>
          <li class="tag-cloud-size-4 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/%E7%A5%9E%E8%A9%B1/">神話</a><span class="count">(2)</span></li>
          <li class="tag-cloud-size-0 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/%E7%A7%8B%E8%91%89%E5%8E%9F/">秋葉原</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-0 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/%E7%A7%91%E5%AD%A6/">科学</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-0 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/%E7%AD%8B%E8%82%89%E5%B0%91%E5%A5%B3%E5%B8%AF/">筋肉少女帯</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-0 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/%E8%8A%B1%E6%BE%A4%E9%A6%99%E8%8F%9C/">花澤香菜</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-0 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/%E8%A8%98%E9%8C%B2/">記録</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-0 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/%E8%B2%AF%E8%93%84/">貯蓄</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-7 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/%E8%B3%87%E6%96%99/">資料</a><span class="count">(5)</span></li>
          <li class="tag-cloud-size-0 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/%E9%87%91/">金</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-0 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/%E9%9B%BB%E5%AD%90%E5%B7%A5%E4%BD%9C/">電子工作</a><span class="count">(1)</span></li>
          <li class="tag-cloud-size-6 tag-flat-hide"><a  class="tag" rel="tag" href="http://b.hatena.ne.jp/motemen/%E9%9D%9E%E3%83%A2%E3%83%86/">非モテ</a><span class="count">(3)</span></li>
        </ul>

        <div id="tag-more-show"><span>すべて表示</span></div>

      </div>
    </div>
    
  </div>
  </div>  

 


<script type="text/javascript"> 
  var _gaq = _gaq || [];
  _gaq.push(['_setCustomVar', 1, 'pageType', 'user', 3]); 
</script> 

        <script type="text/javascript">Hatena.CSSChanger.replaceDefault();</script><!-- Google Analytics -->
<script type="text/javascript">
__rendering_time = (new Date).getTime() - __rendering_time;
if (location.hash == '#benchmark')  {
  document.title = '' + __rendering_time + ' / ' + document.title;
}
</script>

<script type="text/javascript">

  var _gaq = _gaq || [];
  _gaq.push(
    ['_setAccount', 'UA-20092244-1'],
    ['_trackPageview'],
    ['b._setAccount', 'UA-7855606-1'],
    ['b._setDomainName', '.hatena.ne.jp'],
    ['b._trackPageview'],
    ['c._setAccount', 'UA-441387-3'],
    ['c._trackPageview']
  );

  (function() {
    var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
    ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
  })();

</script>

<!--
10.0.50.156 / eaeedeb882a5 
-->
</body>
</html>

@@ GET http://soundcloud.com/kkshow
HTTP/1.1 200 OK
Connection: close
Date: Sun, 27 Feb 2011 14:59:52 GMT
Via: 1.1 varnish
Age: 0
ETag: "04770e85c01ecb107c5b624b3631d6a4"
Server: nginx
Vary: Accept-Encoding
Content-Length: 56185
Content-Type: text/html; charset=utf-8

<!DOCTYPE html>
<html lang="en" xml:lang="en" xmlns="http://www.w3.org/1999/xhtml"><head><meta charset="utf-8" />
<title>kkshow's sounds on SoundCloud - Create, record and share your sounds for free</title>
<meta content="record, sounds, share, sound, audio, tracks, music, soundcloud" name="keywords" />
<meta content=". | Create, record and share the sounds you create anywhere to friends, family and the world with SoundCloud, the world's largest community of sound creators." name="description" />

<meta content="width=device-width" name="viewport" />
<meta content="chrome=1" name="X-UA-Compatible" />
<meta content="19507961798" property="fb:app_id" />
<meta content="SoundCloud" property="og:site_name" />
<meta content="Sounds by kkshow on SoundCloud" property="og:title" />
<meta content="http://i1.soundcloud.com/avatars-000000654375-agqsuw-large.jpg?4fb7bc" property="og:image" />
<meta content="Sounds by kkshow: . | Shared via SoundCloud" property="og:description" />
<meta content="video" name="medium" />
<meta content="242" property="og:video:height" />
<meta content="460" property="og:video:width" />
<meta content="application/x-shockwave-flash" property="og:video:type" />
<meta content="http://player.soundcloud.com/player.swf?url=http%3A%2F%2Fsoundcloud.com%2Fkkshow&amp;color=3b5998&amp;auto_play=true&amp;show_artwork=false" property="og:video" />
<link href="http://soundcloud.com/oembed?url=http%3A%2F%2Fsoundcloud.com%2Fkkshow&amp;format=xml" rel="alternate" type="text/xml+oembed" />
<link href="http://soundcloud.com/oembed?url=http%3A%2F%2Fsoundcloud.com%2Fkkshow&amp;format=json" rel="alternate" type="application/json+oembed" />

<!--[if IE]>
<script src="http://a1.soundcloud.com/javascripts/plugins/vendor/excanvas-compressed.js?4fb7bc" type="text/javascript"></script>
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
<link href="http://a1.soundcloud.com/stylesheets/general.css?4fb7bc" media="all" rel="stylesheet" type="text/css" />
<link href="http://a1.soundcloud.com/stylesheets/special.css?4fb7bc" media="all" rel="stylesheet" type="text/css" />
<link href="/sc-opensearch.xml" rel="search" title="SoundCloud Search" type="application/opensearchdescription+xml" />


<link href="http://a1.soundcloud.com/images/apple-touch-icon.png?4fb7bc" rel="apple-touch-icon" />
<link href="http://a1.soundcloud.com/favicon.ico?4fb7bc" rel="shortcut icon" />
<link href="http://a1.soundcloud.com/images/soundcloud_fluid.png?4fb7bc" rel="fluid-icon" />
</head>
<body class="tracks restricted" id="users"><div id="header"><div id="header-top"><div id="sc-info"><a href="/apps?ref=top">App Gallery</a>
|
<a href="/help">Get help</a>
|
<a href="/premium?ref=top">See prices</a>
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

<div id="main-wrapper"><div id="main-wrapper-inner"><div id="side-content"><div class="context-item context-box"><h3>Need a gift for a gifted musician?</h3>
<p>The SoundCloud Premium accounts also come as <strong>virtual gifts</strong> and it takes only two minutes to get one. Head over to our Gift page and check out the different Premium accounts starting at only <strong>€29 per year</strong>.</p>
<p><a href="/premium/gifts" class="icon-button"><span class="go-pro">Gift page</span></a></p></div>
<div class="context-item"><h3>About</h3></div>
<div class="" id="description"><p>.</p></div>
<div class="context-item hidden" id="contacts"><ul class="tabs"><li class="current"><a href="#following" class="following" onclick="return false;" rel="nofollow">Following<abbr>15 </abbr></a></li>
<li><a href="#followers" class="followers" onclick="return false;" rel="nofollow">Followers<abbr>15 </abbr></a></li>
<li><a href="#groups" class="groups" onclick="return false;" rel="nofollow">Groups<abbr>0 </abbr></a></li></ul>
<div class="pane" id="following"><a href="/kkshow/following" class="lazy hidden">View all</a></div>
<div class="hidden pane" id="followers"><a href="/kkshow/followers?include_unseen=false" class="lazy hidden">View all</a></div>
<div class="hidden pane" id="groups"><a href="/kkshow/groups" class="lazy hidden">View all</a></div></div>

</div>
<div id="main-content"><div id="main-content-inner">

<div id="user-info"><div class="user-image"><a class="user-image-large zoom" href="http://i1.soundcloud.com/avatars-000000654375-agqsuw-crop.jpg?4fb7bc" style="background:url(http://i1.soundcloud.com/avatars-000000654375-agqsuw-large.jpg?4fb7bc)" title="Click to zoom in">User Image</a></div>

<h1>kkshow
<span>Kanazawa, Japan</span></h1><div class="actions"><a href="/kkshow/follow" class="contact-link update button" id="add-user-204721" onclick="return false;" rel="nofollow"><span>Start following</span></a>
<a href="/messages/new?to=204721" class="send-message button" onclick="return false;" rel="nofollow"><span>Send message</span></a>
<a href="/kkshow/dropbox/profile" class="button send-track"><span>Share a track</span></a>
<a href="#share" class="share button" onclick="return false;" rel="nofollow" title="Share this on other networks"><span>Share</span></a>
<div class="share-code hidden action-overlay"><div class="action-overlay-inner"><div class="share-options"><div class="share-public share-root with-push-connection" data-sc-track-permalink="http://soundcloud.com/kkshow"><div class="share-icons"><div class="icons-group"><a href="http://facebook.com/sharer.php?u=http%3A%2F%2Fsoundcloud.com%2Fkkshow%3Futm_source%3Dsoundcloud%26utm_campaign%3Dshare%26utm_medium%3Dfacebook%26utm_content%3Dhttp%3A%2F%2Fsoundcloud.com%2Fkkshow" class="facebook " data-sc-share-type="facebook" data-sc-url="http://soundcloud.com/kkshow?utm_source=soundcloud&amp;utm_campaign=share&amp;utm_medium=raw&amp;utm_content=http://soundcloud.com/kkshow" target="_blank" title="Share to Facebook"><span>Facebook</span></a>
<a href="http://twitter.com/share?text=kkshow+by+kkshow+via+%23soundcloud&amp;url=http%3A%2F%2Fsoundcloud.com%2Fkkshow%3Futm_source%3Dsoundcloud%26utm_campaign%3Dshare%26utm_medium%3Dtwitter%26utm_content%3Dhttp%3A%2F%2Fsoundcloud.com%2Fkkshow" class="twitter " data-sc-share-type="twitter" data-sc-url="http://soundcloud.com/kkshow?utm_source=soundcloud&amp;utm_campaign=share&amp;utm_medium=raw&amp;utm_content=http://soundcloud.com/kkshow" target="_blank" title="Share to Twitter"><span>Twitter</span></a>
<a href="http://www.myspace.com/index.cfm?fuseaction=postto&amp;t=kkshow&amp;u=http%3A%2F%2Fsoundcloud.com%2Fkkshow%3Futm_source%3Dsoundcloud%26utm_campaign%3Dshare%26utm_medium%3Dmyspace%26utm_content%3Dhttp%3A%2F%2Fsoundcloud.com%2Fkkshow&amp;c=." class="myspace " data-sc-share-type="myspace" data-sc-url="http://soundcloud.com/kkshow?utm_source=soundcloud&amp;utm_campaign=share&amp;utm_medium=raw&amp;utm_content=http://soundcloud.com/kkshow" target="_blank" title="Share to MySpace"><span>MySpace</span></a>
<a href="mailto:?subject=kkshow%20-%20SoundCloud&amp;body=http%3A%2F%2Fsoundcloud.com%2Fkkshow%3Futm_source%3Dsoundcloud%26utm_campaign%3Dshare%26utm_medium%3Demail%26utm_content%3Dhttp%3A%2F%2Fsoundcloud.com%2Fkkshow" class="email " data-sc-share-type="email" data-sc-url="http://soundcloud.com/kkshow?utm_source=soundcloud&amp;utm_campaign=share&amp;utm_medium=raw&amp;utm_content=http://soundcloud.com/kkshow" target="_blank" title="Share to Email"><span>Email</span></a>
<a href="[soundcloud url=&quot;http://api.soundcloud.com/users/204721&quot;]" class="wordpress " data-sc-share-type="wordpress" data-sc-url="http://soundcloud.com/kkshow?utm_source=soundcloud&amp;utm_campaign=share&amp;utm_medium=raw&amp;utm_content=http://soundcloud.com/kkshow" target="_blank" title="Share to WordPress"><span>WordPress</span></a>
<a href="http://www.stumbleupon.com/submit?url=http%3A%2F%2Fsoundcloud.com%2Fkkshow%3Futm_source%3Dsoundcloud%26utm_campaign%3Dshare%26utm_medium%3Dstumbleupon%26utm_content%3Dhttp%3A%2F%2Fsoundcloud.com%2Fkkshow&amp;title=kkshow+-+SoundCloud" class="stumbleupon " data-sc-share-type="stumbleupon" data-sc-url="http://soundcloud.com/kkshow?utm_source=soundcloud&amp;utm_campaign=share&amp;utm_medium=raw&amp;utm_content=http://soundcloud.com/kkshow" target="_blank" title="Share to StumbleUpon"><span>StumbleUpon</span></a>
<a href="http://blogger.com/?url=http%3A%2F%2Fsoundcloud.com%2Fkkshow%3Futm_source%3Dsoundcloud%26utm_campaign%3Dshare%26utm_medium%3Dblogger%26utm_content%3Dhttp%3A%2F%2Fsoundcloud.com%2Fkkshow&amp;title=kkshow" class="blogger " data-sc-share-type="blogger" data-sc-url="http://soundcloud.com/kkshow?utm_source=soundcloud&amp;utm_campaign=share&amp;utm_medium=raw&amp;utm_content=http://soundcloud.com/kkshow" target="_blank" title="Share to Blogger"><span>Blogger</span></a>
<a href="http://delicious.com/save?url=http%3A%2F%2Fsoundcloud.com%2Fkkshow%3Futm_source%3Dsoundcloud%26utm_campaign%3Dshare%26utm_medium%3Ddelicious%26utm_content%3Dhttp%3A%2F%2Fsoundcloud.com%2Fkkshow&amp;title=kkshow+-+SoundCloud&amp;notes=." class="delicious " data-sc-share-type="delicious" data-sc-url="http://soundcloud.com/kkshow?utm_source=soundcloud&amp;utm_campaign=share&amp;utm_medium=raw&amp;utm_content=http://soundcloud.com/kkshow" target="_blank" title="Share to Delicious"><span>Delicious</span></a></div><a href="#" class="expand" onclick="return false;" rel="nofollow">More</a></div>
<span class="learnmore">Did you know that you can publish your tracks & favorites automatically to other social networks?
<a href="/settings/connections">Learn more</a></span>
<div class="secret-link shortenable" data-sc-long-url="http://soundcloud.com/kkshow"><label class="float" for="secret-users-204721">
<strong>Get the link:</strong>
</label>
<input class="url auto-select" readonly="readonly" title="Copy the link" type="text" value="http://soundcloud.com/kkshow" />
<input class="shorten-url public-shorten-url" id="shorten-url-users-204721" type="checkbox" />
<label for="shorten-url-users-204721">
Make it short
<span class="spinner">Loading</span>
</label></div>
<div class="embed-code-wrapper"><label class="float" for="embed-code-field">
<strong>Embed Code:</strong>
</label>
<input class="url auto-select" id="embed-code-field" readonly="readonly" title="Copy the code" type="text" value='&lt;object height="225" width="100%"&gt; &lt;param name="movie" value="http://player.soundcloud.com/player.swf?url=http%3A%2F%2Fapi.soundcloud.com%2Fusers%2F204721"&gt;&lt;/param&gt; &lt;param name="allowscriptaccess" value="always"&gt;&lt;/param&gt; &lt;embed allowscriptaccess="always" height="225" src="http://player.soundcloud.com/player.swf?url=http%3A%2F%2Fapi.soundcloud.com%2Fusers%2F204721" type="application/x-shockwave-flash" width="100%"&gt;&lt;/embed&gt; &lt;/object&gt;  &lt;span&gt;&lt;a href="http://soundcloud.com/kkshow"&gt;Latest tracks by kkshow&lt;/a&gt;&lt;/span&gt; ' />
<a class="customize-player-link icon-button" href="/customize/user/kkshow">Customize player</a></div></div></div></div></div>

<div class="mute-user-wrapper"></div></div>
</div>
<div id="user-tabs"><ul class="tabs"><li class="current first"><a href="/kkshow/tracks" class="tracks-count">Tracks<abbr> (10)</abbr></a></li><li class=""><span class="inactive playlists-count">Sets<abbr> (0)</abbr></span></li><li class=""><a href="/kkshow/comments" class="comments-count">Comments<abbr> (3)</abbr></a></li><li class=""><span class="inactive favorites-count">Favorites<abbr> (0)</abbr></span></li><li class="last"><a href="/kkshow/dropbox/profile" class="dropbox-count">DropBox</a></li></ul></div>


<div id="tracks"><ul class="tracks-list"><li class="player"><div class="player mode medium  " data-sc-track="10062947"><div class="info-header"><h3><a href="/kkshow/didgeridoo-vs-kudan-193">Didgeridoo Vs kudan #193</a></h3>
<span class="subtitle">Uploaded
<span class="by">by<span class="user tiny"><a href="/kkshow" class="user-name">kkshow</a>
<span class="user-status"><span class="contact add-contact"><a class="contact-link update"><span>Start following</span></a></span></span></span>
</span><abbr title='February,  4 2011 11:50:03 +0000' class='pretty-date'>on February 04, 2011 11:50</abbr></span>
<div class="meta-data"><span class="stats"><span class="plays first" title="22 Plays">22 <span>Plays</span></span></span></div>
</div>
<div class="actionbar"><div class="actions"><div class="primary"><a href="#share" class="share pl-button" onclick="return false;" rel="nofollow" title="Share this on other networks"><span>Share</span></a>
<div class="share-code hidden action-overlay"><div class="action-overlay-inner"><a href="/kkshow/didgeridoo-vs-kudan-193/share-options" class="lazy initial" onclick="return false;" rel="nofollow">Loading sharing options</a></div></div>

<a href="/you/favorites/kkshow/didgeridoo-vs-kudan-193" class="pl-button favorite create" onclick="return false;" rel="nofollow"><span>Save to Favorites</span></a></div>
<div class="secondary"><a href="/reports?track=didgeridoo-vs-kudan-193&amp;user=kkshow" class="report-this-track pl-button" onclick="return false;" rel="nofollow" title="Report this track"><span>Report this track</span></a></div>
<div class="hidden download-options action-overlay" data-sc-track="10062947"><div class="action-overlay-inner">This track is not downloadable</div></div></div></div>

<div class="container"><div class="controls"><a href="#play" class="play" onclick="return false;" rel="nofollow">Play</a>
<div class="timecodes"><span class="editable">0.00</span>
/
<span class="duration" title="PT719">7.19</span></div></div>
<div class="display"><div class="progress"></div>
<img class="waveform" src="http://waveforms.soundcloud.com/jXkgQyXdahTd_m.png" unselectable="on" />
<img class="waveform-overlay" src="http://a1.soundcloud.com/images/player-overlay.png?4fb7bc" unselectable="on" />
<div class="playhead aural"></div>
<div class="seekhead hidden"><div><span></span></div></div>
<ol class="timestamped-comments "><li class="aural template timestamped-comment"><div class="marker" style="width: 1px"></div></li></ol></div>
<a class="comments-toggle" href="#no-comments" title="Hide the comments">Hide the comments</a>
</div>

<script type="text/javascript">
window.SC.bufferTracks.push({"id":10062947,"uid":"jXkgQyXdahTd","user":{"username":"kkshow","permalink":"kkshow"},"uri":"/kkshow/didgeridoo-vs-kudan-193","duration":439755,"token":"GnTy9","name":"didgeridoo-vs-kudan-193","title":"Didgeridoo Vs kudan #193","commentable":true,"revealComments":true,"commentUri":"/kkshow/didgeridoo-vs-kudan-193/comments/","streamUrl":"http://media.soundcloud.com/stream/jXkgQyXdahTd?stream_token=GnTy9","waveformUrl":"http://waveforms.soundcloud.com/jXkgQyXdahTd_m.png","propertiesUri":"/kkshow/didgeridoo-vs-kudan-193/properties/","statusUri":"/transcodings/jXkgQyXdahTd","replacingUid":null,"preprocessingReady":true,"renderingFailed":false,"commentableByUser":true,"makeHeardUri":false,"favorite":false,"followingTrackOwner":false,"conversations":{}});
</script>
<script type="text/javascript">
window.SC.bufferComments = window.SC.bufferComments.concat([]);
</script></div>
</li>
<li class="player"><div class="player mode medium  " data-sc-track="6219141"><div class="info-header"><h3><a href="/kkshow/voltype">Voltype</a></h3>
<span class="subtitle">Uploaded
<span class="by">by<span class="user tiny"><a href="/kkshow" class="user-name">kkshow</a>
<span class="user-status"><span class="contact add-contact"><a class="contact-link update"><span>Start following</span></a></span></span></span>
</span><abbr title='October, 19 2010 19:49:56 +0000' class='pretty-date'>on October 19, 2010 19:49</abbr></span>
<div class="meta-data"><span class="stats"><span class="plays first" title="27 Plays">27 <span>Plays</span></span><span class="favoritings" title="3 Favoritings">3 <span>Favoritings</span></span></span></div>
</div>
<div class="actionbar"><div class="actions"><div class="primary"><a href="#share" class="share pl-button" onclick="return false;" rel="nofollow" title="Share this on other networks"><span>Share</span></a>
<div class="share-code hidden action-overlay"><div class="action-overlay-inner"><a href="/kkshow/voltype/share-options" class="lazy initial" onclick="return false;" rel="nofollow">Loading sharing options</a></div></div>

<a href="/you/favorites/kkshow/voltype" class="pl-button favorite create" onclick="return false;" rel="nofollow"><span>Save to Favorites</span></a></div>
<div class="secondary"><a href="/reports?track=voltype&amp;user=kkshow" class="report-this-track pl-button" onclick="return false;" rel="nofollow" title="Report this track"><span>Report this track</span></a></div>
<div class="hidden download-options action-overlay" data-sc-track="6219141"><div class="action-overlay-inner">This track is not downloadable</div></div></div></div>

<div class="container"><div class="controls"><a href="#play" class="play" onclick="return false;" rel="nofollow">Play</a>
<div class="timecodes"><span class="editable">0.00</span>
/
<span class="duration" title="PT1113">11.13</span></div></div>
<div class="display"><div class="progress"></div>
<img class="waveform" src="http://waveforms.soundcloud.com/dKAT8rGltzyL_m.png" unselectable="on" />
<img class="waveform-overlay" src="http://a1.soundcloud.com/images/player-overlay.png?4fb7bc" unselectable="on" />
<div class="playhead aural"></div>
<div class="seekhead hidden"><div><span></span></div></div>
<ol class="timestamped-comments "><li class="aural template timestamped-comment"><div class="marker" style="width: 1px"></div></li></ol></div>
<a class="comments-toggle" href="#no-comments" title="Hide the comments">Hide the comments</a>
</div>

<script type="text/javascript">
window.SC.bufferTracks.push({"id":6219141,"uid":"dKAT8rGltzyL","user":{"username":"kkshow","permalink":"kkshow"},"uri":"/kkshow/voltype","duration":673248,"token":"vzNGy","name":"voltype","title":"Voltype","commentable":true,"revealComments":true,"commentUri":"/kkshow/voltype/comments/","streamUrl":"http://media.soundcloud.com/stream/dKAT8rGltzyL?stream_token=vzNGy","waveformUrl":"http://waveforms.soundcloud.com/dKAT8rGltzyL_m.png","propertiesUri":"/kkshow/voltype/properties/","statusUri":"/transcodings/dKAT8rGltzyL","replacingUid":null,"preprocessingReady":true,"renderingFailed":false,"commentableByUser":true,"makeHeardUri":false,"favorite":false,"followingTrackOwner":false,"conversations":{}});
</script>
<script type="text/javascript">
window.SC.bufferComments = window.SC.bufferComments.concat([]);
</script></div>
</li>
<li class="player"><div class="player mode medium  " data-sc-track="5651804"><div class="info-header"><h3><a href="/kkshow/faafa-ahhhh">Faafa Ahhhh</a></h3>
<span class="subtitle">Uploaded
<span class="by">by<span class="user tiny"><a href="/kkshow" class="user-name">kkshow</a>
<span class="user-status"><span class="contact add-contact"><a class="contact-link update"><span>Start following</span></a></span></span></span>
</span><abbr title='September, 28 2010 21:05:49 +0000' class='pretty-date'>on September 28, 2010 21:05</abbr></span>
<div class="meta-data"><span class="stats"><span class="plays first" title="16 Plays">16 <span>Plays</span></span></span></div>
</div>
<div class="actionbar"><div class="actions"><div class="primary"><a href="#share" class="share pl-button" onclick="return false;" rel="nofollow" title="Share this on other networks"><span>Share</span></a>
<div class="share-code hidden action-overlay"><div class="action-overlay-inner"><a href="/kkshow/faafa-ahhhh/share-options" class="lazy initial" onclick="return false;" rel="nofollow">Loading sharing options</a></div></div>

<a href="/you/favorites/kkshow/faafa-ahhhh" class="pl-button favorite create" onclick="return false;" rel="nofollow"><span>Save to Favorites</span></a></div>
<div class="secondary"><a href="/reports?track=faafa-ahhhh&amp;user=kkshow" class="report-this-track pl-button" onclick="return false;" rel="nofollow" title="Report this track"><span>Report this track</span></a></div>
<div class="hidden download-options action-overlay" data-sc-track="5651804"><div class="action-overlay-inner">This track is not downloadable</div></div></div></div>

<div class="container"><div class="controls"><a href="#play" class="play" onclick="return false;" rel="nofollow">Play</a>
<div class="timecodes"><span class="editable">0.00</span>
/
<span class="duration" title="PT814">8.14</span></div></div>
<div class="display"><div class="progress"></div>
<img class="waveform" src="http://waveforms.soundcloud.com/b5HzpCLZHpyG_m.png" unselectable="on" />
<img class="waveform-overlay" src="http://a1.soundcloud.com/images/player-overlay.png?4fb7bc" unselectable="on" />
<div class="playhead aural"></div>
<div class="seekhead hidden"><div><span></span></div></div>
<ol class="timestamped-comments "><li class="aural template timestamped-comment"><div class="marker" style="width: 1px"></div></li></ol></div>
<a class="comments-toggle" href="#no-comments" title="Hide the comments">Hide the comments</a>
</div>

<script type="text/javascript">
window.SC.bufferTracks.push({"id":5651804,"uid":"b5HzpCLZHpyG","user":{"username":"kkshow","permalink":"kkshow"},"uri":"/kkshow/faafa-ahhhh","duration":494320,"token":"g8Zyv","name":"faafa-ahhhh","title":"Faafa Ahhhh","commentable":true,"revealComments":true,"commentUri":"/kkshow/faafa-ahhhh/comments/","streamUrl":"http://media.soundcloud.com/stream/b5HzpCLZHpyG?stream_token=g8Zyv","waveformUrl":"http://waveforms.soundcloud.com/b5HzpCLZHpyG_m.png","propertiesUri":"/kkshow/faafa-ahhhh/properties/","statusUri":"/transcodings/b5HzpCLZHpyG","replacingUid":null,"preprocessingReady":true,"renderingFailed":false,"commentableByUser":true,"makeHeardUri":false,"favorite":false,"followingTrackOwner":false,"conversations":{}});
</script>
<script type="text/javascript">
window.SC.bufferComments = window.SC.bufferComments.concat([]);
</script></div>
</li>
<li class="player"><div class="player mode medium  " data-sc-track="4736559"><div class="info-header"><h3><a href="/kkshow/oneesan-sindaratta">Oneesan Sindaratta</a></h3>
<span class="subtitle">Uploaded
<span class="by">by<span class="user tiny"><a href="/kkshow" class="user-name">kkshow</a>
<span class="user-status"><span class="contact add-contact"><a class="contact-link update"><span>Start following</span></a></span></span></span>
</span><abbr title='August, 20 2010 15:12:21 +0000' class='pretty-date'>on August 20, 2010 15:12</abbr></span>
<div class="meta-data"><span class="stats"><span class="plays first" title="20 Plays">20 <span>Plays</span></span><span class="favoritings" title="2 Favoritings">2 <span>Favoritings</span></span></span></div>
</div>
<div class="actionbar"><div class="actions"><div class="primary"><a href="#share" class="share pl-button" onclick="return false;" rel="nofollow" title="Share this on other networks"><span>Share</span></a>
<div class="share-code hidden action-overlay"><div class="action-overlay-inner"><a href="/kkshow/oneesan-sindaratta/share-options" class="lazy initial" onclick="return false;" rel="nofollow">Loading sharing options</a></div></div>

<a href="/you/favorites/kkshow/oneesan-sindaratta" class="pl-button favorite create" onclick="return false;" rel="nofollow"><span>Save to Favorites</span></a></div>
<div class="secondary"><a href="/reports?track=oneesan-sindaratta&amp;user=kkshow" class="report-this-track pl-button" onclick="return false;" rel="nofollow" title="Report this track"><span>Report this track</span></a></div>
<div class="hidden download-options action-overlay" data-sc-track="4736559"><div class="action-overlay-inner">This track is not downloadable</div></div></div></div>

<div class="container"><div class="controls"><a href="#play" class="play" onclick="return false;" rel="nofollow">Play</a>
<div class="timecodes"><span class="editable">0.00</span>
/
<span class="duration" title="PT916">9.16</span></div></div>
<div class="display"><div class="progress"></div>
<img class="waveform" src="http://waveforms.soundcloud.com/cnNuLXFsMBWM_m.png" unselectable="on" />
<img class="waveform-overlay" src="http://a1.soundcloud.com/images/player-overlay.png?4fb7bc" unselectable="on" />
<div class="playhead aural"></div>
<div class="seekhead hidden"><div><span></span></div></div>
<ol class="timestamped-comments "><li class="aural template timestamped-comment"><div class="marker" style="width: 1px"></div></li></ol></div>
<a class="comments-toggle" href="#no-comments" title="Hide the comments">Hide the comments</a>
</div>

<script type="text/javascript">
window.SC.bufferTracks.push({"id":4736559,"uid":"cnNuLXFsMBWM","user":{"username":"kkshow","permalink":"kkshow"},"uri":"/kkshow/oneesan-sindaratta","duration":556253,"token":"c4ebI","name":"oneesan-sindaratta","title":"Oneesan Sindaratta","commentable":true,"revealComments":true,"commentUri":"/kkshow/oneesan-sindaratta/comments/","streamUrl":"http://media.soundcloud.com/stream/cnNuLXFsMBWM?stream_token=c4ebI","waveformUrl":"http://waveforms.soundcloud.com/cnNuLXFsMBWM_m.png","propertiesUri":"/kkshow/oneesan-sindaratta/properties/","statusUri":"/transcodings/cnNuLXFsMBWM","replacingUid":null,"preprocessingReady":true,"renderingFailed":false,"commentableByUser":true,"makeHeardUri":false,"favorite":false,"followingTrackOwner":false,"conversations":{}});
</script>
<script type="text/javascript">
window.SC.bufferComments = window.SC.bufferComments.concat([]);
</script></div>
</li>
<li class="player"><div class="player mode medium  " data-sc-track="1191770"><div class="info-header"><h3><a href="/kkshow/silent-night">Silent Night</a></h3>
<span class="subtitle">Uploaded
<span class="by">by<span class="user tiny"><a href="/kkshow" class="user-name">kkshow</a>
<span class="user-status"><span class="contact add-contact"><a class="contact-link update"><span>Start following</span></a></span></span></span>
</span><abbr title='December, 24 2009 09:52:18 +0000' class='pretty-date'>on December 24, 2009 09:52</abbr></span>
<div class="meta-data"><span class="stats"><span class="plays first" title="364 Plays">364 <span>Plays</span></span></span></div>
</div>
<div class="actionbar"><div class="actions"><div class="primary"><a href="#share" class="share pl-button" onclick="return false;" rel="nofollow" title="Share this on other networks"><span>Share</span></a>
<div class="share-code hidden action-overlay"><div class="action-overlay-inner"><a href="/kkshow/silent-night/share-options" class="lazy initial" onclick="return false;" rel="nofollow">Loading sharing options</a></div></div>

<a href="/you/favorites/kkshow/silent-night" class="pl-button favorite create" onclick="return false;" rel="nofollow"><span>Save to Favorites</span></a></div>
<div class="secondary"><a href="/reports?track=silent-night&amp;user=kkshow" class="report-this-track pl-button" onclick="return false;" rel="nofollow" title="Report this track"><span>Report this track</span></a></div>
<div class="hidden download-options action-overlay" data-sc-track="1191770"><div class="action-overlay-inner">This track is not downloadable</div></div></div></div>

<div class="container"><div class="controls"><a href="#play" class="play" onclick="return false;" rel="nofollow">Play</a>
<div class="timecodes"><span class="editable">0.00</span>
/
<span class="duration" title="PT208">2.08</span></div></div>
<div class="display"><div class="progress"></div>
<img class="waveform" src="http://waveforms.soundcloud.com/95ZEDUT7xgj5_m.png" unselectable="on" />
<img class="waveform-overlay" src="http://a1.soundcloud.com/images/player-overlay.png?4fb7bc" unselectable="on" />
<div class="playhead aural"></div>
<div class="seekhead hidden"><div><span></span></div></div>
<ol class="timestamped-comments "><li class="aural template timestamped-comment"><div class="marker" style="width: 1px"></div></li></ol></div>
<a class="comments-toggle" href="#no-comments" title="Hide the comments">Hide the comments</a>
</div>

<script type="text/javascript">
window.SC.bufferTracks.push({"id":1191770,"uid":"95ZEDUT7xgj5","user":{"username":"kkshow","permalink":"kkshow"},"uri":"/kkshow/silent-night","duration":128671,"token":"L1i7y","name":"silent-night","title":"Silent Night","commentable":true,"revealComments":true,"commentUri":"/kkshow/silent-night/comments/","streamUrl":"http://media.soundcloud.com/stream/95ZEDUT7xgj5?stream_token=L1i7y","waveformUrl":"http://waveforms.soundcloud.com/95ZEDUT7xgj5_m.png","propertiesUri":"/kkshow/silent-night/properties/","statusUri":"/transcodings/95ZEDUT7xgj5","replacingUid":null,"preprocessingReady":true,"renderingFailed":false,"commentableByUser":true,"makeHeardUri":false,"favorite":false,"followingTrackOwner":false,"conversations":{}});
</script>
<script type="text/javascript">
window.SC.bufferComments = window.SC.bufferComments.concat([]);
</script></div>
</li>
<li class="player"><div class="player mode medium  " data-sc-track="581429"><div class="info-header"><h3><a href="/kkshow/river-in-india">River in India</a></h3>
<span class="subtitle">Uploaded
<span class="by">by<span class="user tiny"><a href="/kkshow" class="user-name">kkshow</a>
<span class="user-status"><span class="contact add-contact"><a class="contact-link update"><span>Start following</span></a></span></span></span>
</span><abbr title='September,  7 2009 14:11:43 +0000' class='pretty-date'>on September 07, 2009 14:11</abbr></span>
<div class="meta-data"><span class="stats"><span class="plays first" title="43 Plays">43 <span>Plays</span></span></span></div>
</div>
<div class="actionbar"><div class="actions"><div class="primary"><a href="#share" class="share pl-button" onclick="return false;" rel="nofollow" title="Share this on other networks"><span>Share</span></a>
<div class="share-code hidden action-overlay"><div class="action-overlay-inner"><a href="/kkshow/river-in-india/share-options" class="lazy initial" onclick="return false;" rel="nofollow">Loading sharing options</a></div></div>

<a href="/you/favorites/kkshow/river-in-india" class="pl-button favorite create" onclick="return false;" rel="nofollow"><span>Save to Favorites</span></a></div>
<div class="secondary"><a href="/reports?track=river-in-india&amp;user=kkshow" class="report-this-track pl-button" onclick="return false;" rel="nofollow" title="Report this track"><span>Report this track</span></a></div>
<div class="hidden download-options action-overlay" data-sc-track="581429"><div class="action-overlay-inner">This track is not downloadable</div></div></div></div>

<div class="container"><div class="controls"><a href="#play" class="play" onclick="return false;" rel="nofollow">Play</a>
<div class="timecodes"><span class="editable">0.00</span>
/
<span class="duration" title="PT628">6.28</span></div></div>
<div class="display"><div class="progress"></div>
<img class="waveform" src="http://waveforms.soundcloud.com/evcpZzbvFJV9_m.png" unselectable="on" />
<img class="waveform-overlay" src="http://a1.soundcloud.com/images/player-overlay.png?4fb7bc" unselectable="on" />
<div class="playhead aural"></div>
<div class="seekhead hidden"><div><span></span></div></div>
<ol class="timestamped-comments "><li class="aural template timestamped-comment"><div class="marker" style="width: 1px"></div></li></ol></div>
<a class="comments-toggle" href="#no-comments" title="Hide the comments">Hide the comments</a>
</div>

<script type="text/javascript">
window.SC.bufferTracks.push({"id":581429,"uid":"evcpZzbvFJV9","user":{"username":"kkshow","permalink":"kkshow"},"uri":"/kkshow/river-in-india","duration":388022,"token":"36283","name":"river-in-india","title":"River in India","commentable":true,"revealComments":true,"commentUri":"/kkshow/river-in-india/comments/","streamUrl":"http://media.soundcloud.com/stream/evcpZzbvFJV9?stream_token=36283","waveformUrl":"http://waveforms.soundcloud.com/evcpZzbvFJV9_m.png","propertiesUri":"/kkshow/river-in-india/properties/","statusUri":"/transcodings/evcpZzbvFJV9","replacingUid":null,"preprocessingReady":true,"renderingFailed":false,"commentableByUser":true,"makeHeardUri":false,"favorite":false,"followingTrackOwner":false,"conversations":{}});
</script>
<script type="text/javascript">
window.SC.bufferComments = window.SC.bufferComments.concat([]);
</script></div>
</li>
<li class="player"><div class="player mode medium  " data-sc-track="576760"><div class="info-header"><h3><a href="/kkshow/sundanhousya">Sundanhousya</a></h3>
<span class="subtitle">Uploaded
<span class="by">by<span class="user tiny"><a href="/kkshow" class="user-name">kkshow</a>
<span class="user-status"><span class="contact add-contact"><a class="contact-link update"><span>Start following</span></a></span></span></span>
</span><abbr title='September,  6 2009 06:30:01 +0000' class='pretty-date'>on September 06, 2009 06:30</abbr></span>
<div class="meta-data"><span class="stats"><span class="plays first" title="26 Plays">26 <span>Plays</span></span></span></div>
</div>
<div class="actionbar"><div class="actions"><div class="primary"><a href="#share" class="share pl-button" onclick="return false;" rel="nofollow" title="Share this on other networks"><span>Share</span></a>
<div class="share-code hidden action-overlay"><div class="action-overlay-inner"><a href="/kkshow/sundanhousya/share-options" class="lazy initial" onclick="return false;" rel="nofollow">Loading sharing options</a></div></div>

<a href="/you/favorites/kkshow/sundanhousya" class="pl-button favorite create" onclick="return false;" rel="nofollow"><span>Save to Favorites</span></a></div>
<div class="secondary"><a href="/reports?track=sundanhousya&amp;user=kkshow" class="report-this-track pl-button" onclick="return false;" rel="nofollow" title="Report this track"><span>Report this track</span></a></div>
<div class="hidden download-options action-overlay" data-sc-track="576760"><div class="action-overlay-inner">This track is not downloadable</div></div></div></div>

<div class="container"><div class="controls"><a href="#play" class="play" onclick="return false;" rel="nofollow">Play</a>
<div class="timecodes"><span class="editable">0.00</span>
/
<span class="duration" title="PT4737">47.37</span></div></div>
<div class="display"><div class="progress"></div>
<img class="waveform" src="http://waveforms.soundcloud.com/heVDK9XGJhe1_m.png" unselectable="on" />
<img class="waveform-overlay" src="http://a1.soundcloud.com/images/player-overlay.png?4fb7bc" unselectable="on" />
<div class="playhead aural"></div>
<div class="seekhead hidden"><div><span></span></div></div>
<ol class="timestamped-comments "><li class="aural template timestamped-comment"><div class="marker" style="width: 1px"></div></li></ol></div>
<a class="comments-toggle" href="#no-comments" title="Hide the comments">Hide the comments</a>
</div>

<script type="text/javascript">
window.SC.bufferTracks.push({"id":576760,"uid":"heVDK9XGJhe1","user":{"username":"kkshow","permalink":"kkshow"},"uri":"/kkshow/sundanhousya","duration":2857482,"token":"e262d","name":"sundanhousya","title":"Sundanhousya","commentable":true,"revealComments":true,"commentUri":"/kkshow/sundanhousya/comments/","streamUrl":"http://media.soundcloud.com/stream/heVDK9XGJhe1?stream_token=e262d","waveformUrl":"http://waveforms.soundcloud.com/heVDK9XGJhe1_m.png","propertiesUri":"/kkshow/sundanhousya/properties/","statusUri":"/transcodings/heVDK9XGJhe1","replacingUid":null,"preprocessingReady":true,"renderingFailed":false,"commentableByUser":true,"makeHeardUri":false,"favorite":false,"followingTrackOwner":false,"conversations":{}});
</script>
<script type="text/javascript">
window.SC.bufferComments = window.SC.bufferComments.concat([]);
</script></div>
</li>
<li class="player"><div class="player mode medium  " data-sc-track="571330"><div class="info-header"><h3><a href="/kkshow/rungilvedribaap">Rungilvedribaap</a></h3>
<span class="subtitle">Uploaded
<span class="by">by<span class="user tiny"><a href="/kkshow" class="user-name">kkshow</a>
<span class="user-status"><span class="contact add-contact"><a class="contact-link update"><span>Start following</span></a></span></span></span>
</span><abbr title='September,  4 2009 15:32:30 +0000' class='pretty-date'>on September 04, 2009 15:32</abbr></span>
<div class="meta-data"><span class="stats"><span class="plays first" title="19 Plays">19 <span>Plays</span></span></span></div>
</div>
<div class="actionbar"><div class="actions"><div class="primary"><a href="#share" class="share pl-button" onclick="return false;" rel="nofollow" title="Share this on other networks"><span>Share</span></a>
<div class="share-code hidden action-overlay"><div class="action-overlay-inner"><a href="/kkshow/rungilvedribaap/share-options" class="lazy initial" onclick="return false;" rel="nofollow">Loading sharing options</a></div></div>

<a href="/you/favorites/kkshow/rungilvedribaap" class="pl-button favorite create" onclick="return false;" rel="nofollow"><span>Save to Favorites</span></a></div>
<div class="secondary"><a href="/reports?track=rungilvedribaap&amp;user=kkshow" class="report-this-track pl-button" onclick="return false;" rel="nofollow" title="Report this track"><span>Report this track</span></a></div>
<div class="hidden download-options action-overlay" data-sc-track="571330"><div class="action-overlay-inner">This track is not downloadable</div></div></div></div>

<div class="container"><div class="controls"><a href="#play" class="play" onclick="return false;" rel="nofollow">Play</a>
<div class="timecodes"><span class="editable">0.00</span>
/
<span class="duration" title="PT1612">16.12</span></div></div>
<div class="display"><div class="progress"></div>
<img class="waveform" src="http://waveforms.soundcloud.com/vQ7GGflGzu9b_m.png" unselectable="on" />
<img class="waveform-overlay" src="http://a1.soundcloud.com/images/player-overlay.png?4fb7bc" unselectable="on" />
<div class="playhead aural"></div>
<div class="seekhead hidden"><div><span></span></div></div>
<ol class="timestamped-comments "><li class="aural template timestamped-comment"><div class="marker" style="width: 1px"></div></li></ol></div>
<a class="comments-toggle" href="#no-comments" title="Hide the comments">Hide the comments</a>
</div>

<script type="text/javascript">
window.SC.bufferTracks.push({"id":571330,"uid":"vQ7GGflGzu9b","user":{"username":"kkshow","permalink":"kkshow"},"uri":"/kkshow/rungilvedribaap","duration":972146,"token":"ba983","name":"rungilvedribaap","title":"Rungilvedribaap","commentable":true,"revealComments":true,"commentUri":"/kkshow/rungilvedribaap/comments/","streamUrl":"http://media.soundcloud.com/stream/vQ7GGflGzu9b?stream_token=ba983","waveformUrl":"http://waveforms.soundcloud.com/vQ7GGflGzu9b_m.png","propertiesUri":"/kkshow/rungilvedribaap/properties/","statusUri":"/transcodings/vQ7GGflGzu9b","replacingUid":null,"preprocessingReady":true,"renderingFailed":false,"commentableByUser":true,"makeHeardUri":false,"favorite":false,"followingTrackOwner":false,"conversations":{}});
</script>
<script type="text/javascript">
window.SC.bufferComments = window.SC.bufferComments.concat([]);
</script></div>
</li>
<li class="player"><div class="player mode medium  " data-sc-track="563729"><div class="info-header"><h3><a href="/kkshow/chenmet">Chenmet</a></h3>
<span class="subtitle">Uploaded
<span class="by">by<span class="user tiny"><a href="/kkshow" class="user-name">kkshow</a>
<span class="user-status"><span class="contact add-contact"><a class="contact-link update"><span>Start following</span></a></span></span></span>
</span><abbr title='September,  2 2009 18:54:23 +0000' class='pretty-date'>on September 02, 2009 18:54</abbr></span>
<div class="meta-data"><span class="stats"><span class="plays first" title="28 Plays">28 <span>Plays</span></span></span></div>
</div>
<div class="actionbar"><div class="actions"><div class="primary"><a href="#share" class="share pl-button" onclick="return false;" rel="nofollow" title="Share this on other networks"><span>Share</span></a>
<div class="share-code hidden action-overlay"><div class="action-overlay-inner"><a href="/kkshow/chenmet/share-options" class="lazy initial" onclick="return false;" rel="nofollow">Loading sharing options</a></div></div>

<a href="/you/favorites/kkshow/chenmet" class="pl-button favorite create" onclick="return false;" rel="nofollow"><span>Save to Favorites</span></a></div>
<div class="secondary"><a href="/reports?track=chenmet&amp;user=kkshow" class="report-this-track pl-button" onclick="return false;" rel="nofollow" title="Report this track"><span>Report this track</span></a></div>
<div class="hidden download-options action-overlay" data-sc-track="563729"><div class="action-overlay-inner">This track is not downloadable</div></div></div></div>

<div class="container"><div class="controls"><a href="#play" class="play" onclick="return false;" rel="nofollow">Play</a>
<div class="timecodes"><span class="editable">0.00</span>
/
<span class="duration" title="PT202">2.02</span></div></div>
<div class="display"><div class="progress"></div>
<img class="waveform" src="http://waveforms.soundcloud.com/yZ815ecxM6ZM_m.png" unselectable="on" />
<img class="waveform-overlay" src="http://a1.soundcloud.com/images/player-overlay.png?4fb7bc" unselectable="on" />
<div class="playhead aural"></div>
<div class="seekhead hidden"><div><span></span></div></div>
<ol class="timestamped-comments "><li class="aural template timestamped-comment"><div class="marker" style="width: 1px"></div></li></ol></div>
<a class="comments-toggle" href="#no-comments" title="Hide the comments">Hide the comments</a>
</div>

<script type="text/javascript">
window.SC.bufferTracks.push({"id":563729,"uid":"yZ815ecxM6ZM","user":{"username":"kkshow","permalink":"kkshow"},"uri":"/kkshow/chenmet","duration":122618,"token":"506d2","name":"chenmet","title":"Chenmet","commentable":true,"revealComments":true,"commentUri":"/kkshow/chenmet/comments/","streamUrl":"http://media.soundcloud.com/stream/yZ815ecxM6ZM?stream_token=506d2","waveformUrl":"http://waveforms.soundcloud.com/yZ815ecxM6ZM_m.png","propertiesUri":"/kkshow/chenmet/properties/","statusUri":"/transcodings/yZ815ecxM6ZM","replacingUid":null,"preprocessingReady":true,"renderingFailed":false,"commentableByUser":true,"makeHeardUri":false,"favorite":false,"followingTrackOwner":false,"conversations":{}});
</script>
<script type="text/javascript">
window.SC.bufferComments = window.SC.bufferComments.concat([]);
</script></div>
</li>
<li class="player"><div class="player mode medium  " data-sc-track="559077"><div class="info-header"><h3><a href="/kkshow/vvochtnogrwt">Vvochtnogrwt</a></h3>
<span class="subtitle">Uploaded
<span class="by">by<span class="user tiny"><a href="/kkshow" class="user-name">kkshow</a>
<span class="user-status"><span class="contact add-contact"><a class="contact-link update"><span>Start following</span></a></span></span></span>
</span><abbr title='September,  1 2009 16:28:35 +0000' class='pretty-date'>on September 01, 2009 16:28</abbr></span>
<div class="meta-data"><span class="stats"><span class="plays first" title="22 Plays">22 <span>Plays</span></span><span class="favoritings" title="1 Favoriting">1 <span>Favoriting</span></span><span class="downloads" title="1 Download">1 <span>Download</span></span></span></div>
</div>
<div class="actionbar"><div class="actions"><div class="primary"><a href="#share" class="share pl-button" onclick="return false;" rel="nofollow" title="Share this on other networks"><span>Share</span></a>
<div class="share-code hidden action-overlay"><div class="action-overlay-inner"><a href="/kkshow/vvochtnogrwt/share-options" class="lazy initial" onclick="return false;" rel="nofollow">Loading sharing options</a></div></div>

<a href="/you/favorites/kkshow/vvochtnogrwt" class="pl-button favorite create" onclick="return false;" rel="nofollow"><span>Save to Favorites</span></a></div>
<div class="secondary"><a href="/reports?track=vvochtnogrwt&amp;user=kkshow" class="report-this-track pl-button" onclick="return false;" rel="nofollow" title="Report this track"><span>Report this track</span></a></div>
<div class="hidden download-options action-overlay" data-sc-track="559077"><div class="action-overlay-inner">This track is not downloadable</div></div></div></div>

<div class="container"><div class="controls"><a href="#play" class="play" onclick="return false;" rel="nofollow">Play</a>
<div class="timecodes"><span class="editable">0.00</span>
/
<span class="duration" title="PT202">2.02</span></div></div>
<div class="display"><div class="progress"></div>
<img class="waveform" src="http://waveforms.soundcloud.com/vBqzmK9fHpdl_m.png" unselectable="on" />
<img class="waveform-overlay" src="http://a1.soundcloud.com/images/player-overlay.png?4fb7bc" unselectable="on" />
<div class="playhead aural"></div>
<div class="seekhead hidden"><div><span></span></div></div>
<ol class="timestamped-comments "><li class="aural template timestamped-comment"><div class="marker" style="width: 1px"></div></li></ol></div>
<a class="comments-toggle" href="#no-comments" title="Hide the comments">Hide the comments</a>
</div>

<script type="text/javascript">
window.SC.bufferTracks.push({"id":559077,"uid":"vBqzmK9fHpdl","user":{"username":"kkshow","permalink":"kkshow"},"uri":"/kkshow/vvochtnogrwt","duration":122671,"token":"947e0","name":"vvochtnogrwt","title":"Vvochtnogrwt","commentable":true,"revealComments":true,"commentUri":"/kkshow/vvochtnogrwt/comments/","streamUrl":"http://media.soundcloud.com/stream/vBqzmK9fHpdl?stream_token=947e0","waveformUrl":"http://waveforms.soundcloud.com/vBqzmK9fHpdl_m.png","propertiesUri":"/kkshow/vvochtnogrwt/properties/","statusUri":"/transcodings/vBqzmK9fHpdl","replacingUid":null,"preprocessingReady":true,"renderingFailed":false,"commentableByUser":true,"makeHeardUri":false,"favorite":false,"followingTrackOwner":false,"conversations":{}});
</script>
<script type="text/javascript">
window.SC.bufferComments = window.SC.bufferComments.concat([]);
</script></div>
</li></ul></div>

</div></div></div></div>
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
<script src="http://a1.soundcloud.com/javascripts/base.js?4fb7bc" type="text/javascript"></script>

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
@@ GET http://www.nicovideo.jp/tag/VOCALOID
HTTP/1.1 200 OK
Connection: close
Date: Tue, 01 Mar 2011 02:51:43 GMT
Server: Apache
Vary: Accept-Encoding
Content-Length: 111526
Content-Type: text/html
Content-Base: http://www.nicovideo.jp/

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="Content-Script-Type" content="text/javascript">
<meta http-equiv="Content-Style-Type" content="text/css">
<meta name="copyright" content="&copy; niwango, Inc.">

<!---->
<meta name="keywords" content="ニコニコ動画,VOCALOID">

<link rel="alternate" charset="utf-8" type="application/rss+xml" title="タグ VOCALOID" href="/tag/VOCALOID?sort=f&rss=2.0">
<link rel="alternate" media="handheld" type="application/xhtml+xml" href="http://nicomoba.jp/tag.php?key=VOCALOID">
<link rel="start" href="http://www.nicovideo.jp/tag/VOCALOID" title="最初のページ">
		<link rel="next" href="http://www.nicovideo.jp/tag/VOCALOID?page=2" title="次のページ"><title>タグで動画検索 VOCALOID ‐ ニコニコ動画(原宿)</title>
<base href="http://www.nicovideo.jp/">
<link rel="shortcut icon" href="http://res.nimg.jp/img/favicon.ico">

<link rel="stylesheet" type="text/css" charset="utf-8" href="http://res.nimg.jp/css/common.css?110228">

<link rel="stylesheet" type="text/css" charset="utf-8" href="http://res.nimg.jp/css/common/related.css?101026">









<link rel="stylesheet" type="text/css" charset="utf-8" href="http://res.nimg.jp/css/common/thumb.css?110105">
<link rel="stylesheet" type="text/css" charset="utf-8" href="http://res.nimg.jp/css/tag.css?101026">

<script type="text/javascript" src="http://res.nimg.jp/js/lib/prototype.js?1.5.1.1_2"></script>
<script type="text/javascript" src="http://res.nimg.jp/js/common.js?090905"></script>
<script type="text/javascript" src="http://res.nimg.jp/js/swfobject.js?4"></script>
<script type="text/javascript" src="http://res.nimg.jp/js/nicolib.js?100531"></script>
<script type="text/javascript" src="http://res.nimg.jp/js/ads.js?110222"></script>
<script type="text/javascript" src="http://res.nimg.jp/js/__utm.js?080117"></script>

<script type="text/javascript"><!--

var User = { id: false, age: false, isPremium: false, isOver18: !!document.cookie.match(/nicoadult\s*=\s*1/), isMan: null };
var q = "VOCALOID".unescapeHTML().replace(/&#([0-9]+);/g, function ($0, $1) { return String.fromCharCode($1); });
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
<form id="head_search_form" action="/tag" method="get" onsubmit="submitSearch(this.action, false); return false;">
<input type="hidden" name="ref">
<table cellpadding="0" cellspacing="0" summary=""><tr valign="bottom">
<td><a href="#" class="head_ssw_0" onclick="submitSearch('/search', this); return false;"><img src="http://res.nimg.jp/img/x.gif" style="width:57px;" alt="キーワード" /></a></td>
<td style="padding:0 2px;"><a href="#" class="head_ssw_1" onclick="submitSearch('/tag', this); return false;"><img src="http://res.nimg.jp/img/x.gif" style="width:31px; background-position:-57px 0;" alt="タグ"></a></td>
<td><a href="#" class="head_ssw_0" onclick="submitSearch('/mylist_search', this); return false;"><img src="http://res.nimg.jp/img/x.gif" style="width:55px; background-position:-88px 0;" alt="マイリスト"></a></td>
</tr></table>

<div style="background:#393F3F; width:242px; border:solid 1px #999F9F;"><table cellpadding="0" cellspacing="2" summary=""><tr><td><div class="head_search_input"><input type="text" name="s" id="bar_search" value="VOCALOID"></div></td><td><input name="submit" type="image" src="http://res.nimg.jp/img/base/head/search/submit.png" alt="検索"></td></tr></table></div>

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
		<!--↓タイトル↓-->
<div class="mb8p4">
<h1>タグ <span class="search_word" style="font-size:32px;" id="search_words"><span class="search_word">VOCALOID</span> </span> を含む動画の検索結果</h1>
<p class="font12">登録数：<strong class="search_total">130,258件</strong> <span style="color:#CCC;">…</span>
<a href="related_tag/VOCALOID">キーワード <strong><span class="search_word">VOCALOID</span> </strong> を含むタグを検索</a></p>
</div>
<!--↑タイトル↑-->

<!--↓ニコニ広告↓-->
<div id="nicoads">
<div id="uad_container">
<p class="mb8p4 font12" style="color:#696F6F;">【読込中】ニコニ広告を読み込んでいます…</p>
</div>
<script type="text/javascript" charset="utf-8" src="http://res.nimg.jp/js/uad_embed.js?101118"></script>
<script type="text/javascript"><!--
new UadEmbed({
	url: "http://uad-api.nicovideo.jp/UadsBannerService/deliveryJsonp",
	keyword: "VOCALOID",
	element: "uad_container",
	dictionary: {
		uadURL: "http://uad.nicovideo.jp/",
		apiURL: "http://api.uad.nicovideo.jp/",
		resURL: "http://res.nimg.jp/"
	}
});
--></script>
</div>
<!--↑ニコニ広告↑-->

<div class="content_672">
<!--↓左列↓-->

	
<!--↓動画該当あり↓-->

<table width="672" cellpadding="4" cellspacing="0">
<tr>
<td><form name="sort"><select name="sort" onChange="jumpMENU('parent',this,0)">
<option value="http://www.nicovideo.jp/tag/VOCALOID" selected>コメントが新しい順</option>
<option value="http://www.nicovideo.jp/tag/VOCALOID?order=a">コメントが古い順</option>
<option value="http://www.nicovideo.jp/tag/VOCALOID?sort=v">再生数が多い順</option>
<option value="http://www.nicovideo.jp/tag/VOCALOID?sort=v&amp;order=a">再生数が少ない順</option>
<option value="http://www.nicovideo.jp/tag/VOCALOID?sort=r">コメント数が多い順</option>
<option value="http://www.nicovideo.jp/tag/VOCALOID?sort=r&amp;order=a">コメント数が少ない順</option>
<option value="http://www.nicovideo.jp/tag/VOCALOID?sort=m">マイリスト数が多い順</option>
<option value="http://www.nicovideo.jp/tag/VOCALOID?sort=m&amp;order=a">マイリスト数が少ない順</option>
<option value="http://www.nicovideo.jp/tag/VOCALOID?sort=f">投稿日時が新しい順</option>
<option value="http://www.nicovideo.jp/tag/VOCALOID?sort=f&amp;order=a">投稿日時が古い順</option>
<option value="http://www.nicovideo.jp/tag/VOCALOID?sort=l">再生時間が長い順</option>
<option value="http://www.nicovideo.jp/tag/VOCALOID?sort=l&amp;order=a">再生時間が短い順</option>
</select></form></td>
<td nowrap><style><!--
.thumb_cols img { width:35px; height:18px; background:url('/img/common/thumb_cols/col_1.png'); border:0;}
.thumb_cols a:link img , .thumb_cols a:visited img { background:url('/img/common/thumb_cols/col_0.png');}
.thumb_cols a:hover img , .thumb_cols a:active img { background:url('/img/common/thumb_cols/col_1.png');}
--></style>

<p class="thumb_cols"><nobr><img src="http://res.nimg.jp/img/x.gif" alt="1列"><a href="http://www.nicovideo.jp/tag/VOCALOID" onclick="Cookie.set('col', '2', 1000*60*60*24*365, '.nicovideo.jp', '/')"><img src="http://res.nimg.jp/img/x.gif" alt="2列" style="background-position:-35px;"></a><a href="http://www.nicovideo.jp/tag/VOCALOID" onclick="Cookie.set('col', '4', 1000*60*60*24*365, '.nicovideo.jp', '/')"><img src="http://res.nimg.jp/img/x.gif" alt="4列" style="background-position:-70px;"></a></nobr></p>

<!--p class="font12" align="right">現在の値＝</p--></td>
<td width="100%" align="right"><table cellpadding="0" cellspacing="4" summary="" class="pager"><tr><td><span class="here">1</span><a href="http://www.nicovideo.jp/tag/VOCALOID?page=2">2</a><a href="http://www.nicovideo.jp/tag/VOCALOID?page=3">3</a><a href="http://www.nicovideo.jp/tag/VOCALOID?page=4">4</a><a href="http://www.nicovideo.jp/tag/VOCALOID?page=2">次へ</a></td></tr></table></td>
</tr>
</table>

<div style="width:624px; padding:0 24px; overflow:hidden;">


<div style="clear:both;">





<div class="thumb_col_1">
<!---->
<table width="624" cellpadding="4" cellspacing="0" summary="so10852344">
<tr valign="top">
<td><div id="item1" style="display:none;" onMouseover="showOBJ('thumb_uad_msg_so10852344')" onMouseout="hideOBJ('thumb_uad_msg_so10852344')">
	<div id="thumb_uad_msg_so10852344" style="display:none; position:absolute;">
	<p id="item1_uad_comment" class="uad_comment"><span style="color:#666;">-</span></p>
	</div>
</div>
<div id="item1_thumb" class="uad_thumbfrm">
<table cellspacing="0" cellpadding="0">
<tr>
<td onMouseover="showOBJ('thumb_uad_msg_so10852344')" onMouseout="hideOBJ('thumb_uad_msg_so10852344')">
<p><a href="watch/so10852344"><img src="http://tn-skr1.smilevideo.jp/smile?i=10852344" alt="" class="img_std96"></a></p>
<p class="vinfo_length"><span>1:42</span></p>
</td>
<td class="font10" align="right"><div style="width:92px; overflow:hidden; padding-left:4px;"><nobr>再生：<strong class="vinfo_view">171,936</strong><br></nobr>
<nobr>コメ：<strong class="vinfo_res">4,161</strong><br></nobr>
<nobr>マイ：<a href="mylistcomment/video/so10852344" style="color:#393F3F;"><strong class="vinfo_mylist">1,448</strong></a><br></nobr>
<nobr>宣伝：<a href="http://uad.nicovideo.jp/ads/?vid=so10852344" style="color:#393F3F;"><strong id="item1_uad_point_number" class="vinfo_uadp">0</strong></a><br></nobr>
</div></td>
</tr>
</table>
	</div>
</td>
<td style="background:url('http://res.nimg.jp/img/common/thumb/split_line.png') no-repeat bottom left; padding-bottom:6px;">
<div style="width:412px; overflow:hidden;">
<p class="font12 thumb_num">

<strong>
2010年05月26日 20:00
</strong> 投稿
</p>
<p class="font16" style="margin:2px 0;"><nobr><a href="watch/so10852344" class="watch" title="【初音ミク】収録曲とコスチュームをちょっとだけ公開！【Project DIVA 2nd】">【初音ミク】収録曲とコスチュームをちょっとだけ公開！【Project DIVA ...</a></nobr></p>
<p class="vinfo_description" title="うぅー、いいねぇ、かわいいねぇぇ、かっこいいねぇぇぇ。曲は曲で、すんごいメンバーから提供...">うぅー、いいねぇ、かわいいねぇぇ、かっこいいねぇぇぇ。曲は曲で、すんごいメンバーから提供...</p>
</div>
</td>
</tr>
</table>
<!---->
</div>
</div>



<div style="clear:both;">





<div class="thumb_col_1">
<!---->
<table width="624" cellpadding="4" cellspacing="0" summary="sm11713594">
<tr valign="top">
<td><div id="item2" style="display:none;" onMouseover="showOBJ('thumb_uad_msg_sm11713594')" onMouseout="hideOBJ('thumb_uad_msg_sm11713594')">
	<div id="thumb_uad_msg_sm11713594" style="display:none; position:absolute;">
	<p id="item2_uad_comment" class="uad_comment"><span style="color:#666;">-</span></p>
	</div>
</div>
<div id="item2_thumb" class="uad_thumbfrm">
<table cellspacing="0" cellpadding="0">
<tr>
<td onMouseover="showOBJ('thumb_uad_msg_sm11713594')" onMouseout="hideOBJ('thumb_uad_msg_sm11713594')">
<p><a href="watch/sm11713594"><img src="http://tn-skr3.smilevideo.jp/smile?i=11713594" alt="" class="img_std96"></a></p>
<p class="vinfo_length"><span>4:59</span></p>
</td>
<td class="font10" align="right"><div style="width:92px; overflow:hidden; padding-left:4px;"><nobr>再生：<strong class="vinfo_view">519,456</strong><br></nobr>
<nobr>コメ：<strong class="vinfo_res">24,309</strong><br></nobr>
<nobr>マイ：<a href="mylistcomment/video/sm11713594" style="color:#393F3F;"><strong class="vinfo_mylist">34,913</strong></a><br></nobr>
<nobr>宣伝：<a href="http://uad.nicovideo.jp/ads/?vid=sm11713594" style="color:#393F3F;"><strong id="item2_uad_point_number" class="vinfo_uadp">0</strong></a><br></nobr>
</div></td>
</tr>
</table>
	</div>
</td>
<td style="background:url('http://res.nimg.jp/img/common/thumb/split_line.png') no-repeat bottom left; padding-bottom:6px;">
<div style="width:412px; overflow:hidden;">
<p class="font12 thumb_num">

<strong>
2010年08月11日 17:10
</strong> 投稿
</p>
<p class="font16" style="margin:2px 0;"><nobr><a href="watch/sm11713594" class="watch" title="【GUMI】　会いたい　【オリジナル曲】">【GUMI】　会いたい　【オリジナル曲】</a></nobr></p>
<p class="vinfo_description" title="誰だって無性に会いたくなる時ってあるよね。作詞：Deadman作曲：Dios/シグナルP mylist...">誰だって無性に会いたくなる時ってあるよね。作詞：Deadman作曲：Dios/シグナルP mylist...</p>
</div>
</td>
</tr>
</table>
<!---->
</div>
</div>



<div style="clear:both;">





<div class="thumb_col_1">
<!---->
<table width="624" cellpadding="4" cellspacing="0" summary="sm13732022">
<tr valign="top">
<td><div id="item3" style="display:none;" onMouseover="showOBJ('thumb_uad_msg_sm13732022')" onMouseout="hideOBJ('thumb_uad_msg_sm13732022')">
	<div id="thumb_uad_msg_sm13732022" style="display:none; position:absolute;">
	<p id="item3_uad_comment" class="uad_comment"><span style="color:#666;">-</span></p>
	</div>
</div>
<div id="item3_thumb" class="uad_thumbfrm">
<table cellspacing="0" cellpadding="0">
<tr>
<td onMouseover="showOBJ('thumb_uad_msg_sm13732022')" onMouseout="hideOBJ('thumb_uad_msg_sm13732022')">
<p><a href="watch/sm13732022"><img src="http://tn-skr3.smilevideo.jp/smile?i=13732022" alt="" class="img_std96"></a></p>
<p class="vinfo_length"><span>4:00</span></p>
</td>
<td class="font10" align="right"><div style="width:92px; overflow:hidden; padding-left:4px;"><nobr>再生：<strong class="vinfo_view">2,617</strong><br></nobr>
<nobr>コメ：<strong class="vinfo_res">377</strong><br></nobr>
<nobr>マイ：<a href="mylistcomment/video/sm13732022" style="color:#393F3F;"><strong class="vinfo_mylist">268</strong></a><br></nobr>
<nobr>宣伝：<a href="http://uad.nicovideo.jp/ads/?vid=sm13732022" style="color:#393F3F;"><strong id="item3_uad_point_number" class="vinfo_uadp">0</strong></a><br></nobr>
</div></td>
</tr>
</table>
	</div>
</td>
<td style="background:url('http://res.nimg.jp/img/common/thumb/split_line.png') no-repeat bottom left; padding-bottom:6px;">
<div style="width:412px; overflow:hidden;">
<p class="font12 thumb_num">

<strong>
2011年02月28日 06:51
</strong> 投稿
</p>
<p class="font16" style="margin:2px 0;"><nobr><a href="watch/sm13732022" class="watch" title="【初音ミク】そうかそうか　そう　だったのか【オリジナル】">【初音ミク】そうかそうか　そう　だったのか【オリジナル】</a></nobr></p>
<p class="vinfo_description" title="ほぼ日Pです。　たぶん世界中いたるところで起きている結婚にともなう悩みを曲にしてみました。　イラスト...">ほぼ日Pです。　たぶん世界中いたるところで起きている結婚にともなう悩みを曲にしてみました。　イラスト...</p>
</div>
</td>
</tr>
</table>
<!---->
</div>
</div>



<div style="clear:both;">





<div class="thumb_col_1">
<!---->
<table width="624" cellpadding="4" cellspacing="0" summary="sm4559156">
<tr valign="top">
<td><div id="item4" style="display:none;" onMouseover="showOBJ('thumb_uad_msg_sm4559156')" onMouseout="hideOBJ('thumb_uad_msg_sm4559156')">
	<div id="thumb_uad_msg_sm4559156" style="display:none; position:absolute;">
	<p id="item4_uad_comment" class="uad_comment"><span style="color:#666;">-</span></p>
	</div>
</div>
<div id="item4_thumb" class="uad_thumbfrm">
<table cellspacing="0" cellpadding="0">
<tr>
<td onMouseover="showOBJ('thumb_uad_msg_sm4559156')" onMouseout="hideOBJ('thumb_uad_msg_sm4559156')">
<p><a href="watch/sm4559156"><img src="http://tn-skr1.smilevideo.jp/smile?i=4559156" alt="" class="img_std96"></a></p>
<p class="vinfo_length"><span>4:14</span></p>
</td>
<td class="font10" align="right"><div style="width:92px; overflow:hidden; padding-left:4px;"><nobr>再生：<strong class="vinfo_view">371,396</strong><br></nobr>
<nobr>コメ：<strong class="vinfo_res">27,975</strong><br></nobr>
<nobr>マイ：<a href="mylistcomment/video/sm4559156" style="color:#393F3F;"><strong class="vinfo_mylist">13,520</strong></a><br></nobr>
<nobr>宣伝：<a href="http://uad.nicovideo.jp/ads/?vid=sm4559156" style="color:#393F3F;"><strong id="item4_uad_point_number" class="vinfo_uadp">0</strong></a><br></nobr>
</div></td>
</tr>
</table>
	</div>
</td>
<td style="background:url('http://res.nimg.jp/img/common/thumb/split_line.png') no-repeat bottom left; padding-bottom:6px;">
<div style="width:412px; overflow:hidden;">
<p class="font12 thumb_num">

<strong>
2008年09月08日 12:48
</strong> 投稿
</p>
<p class="font16" style="margin:2px 0;"><nobr><a href="watch/sm4559156" class="watch" title="【がくぽ】ワールドイズマイン～毘沙門天アレンジ～【がくっぽいど】">【がくぽ】ワールドイズマイン～毘沙門天アレンジ～【がくっぽいど】</a></nobr></p>
<p class="vinfo_description" title="■どうも。なおぽです。我こそが毘沙門天なり！■素敵な原曲様はこちら→sm3504435■ブログ...">■どうも。なおぽです。我こそが毘沙門天なり！■素敵な原曲様はこちら→sm3504435■ブログ...</p>
</div>
</td>
</tr>
</table>
<!---->
</div>
</div>



<div style="clear:both;">





<div class="thumb_col_1">
<!---->
<table width="624" cellpadding="4" cellspacing="0" summary="sm13697158">
<tr valign="top">
<td><div id="item5" style="display:none;" onMouseover="showOBJ('thumb_uad_msg_sm13697158')" onMouseout="hideOBJ('thumb_uad_msg_sm13697158')">
	<div id="thumb_uad_msg_sm13697158" style="display:none; position:absolute;">
	<p id="item5_uad_comment" class="uad_comment"><span style="color:#666;">-</span></p>
	</div>
</div>
<div id="item5_thumb" class="uad_thumbfrm">
<table cellspacing="0" cellpadding="0">
<tr>
<td onMouseover="showOBJ('thumb_uad_msg_sm13697158')" onMouseout="hideOBJ('thumb_uad_msg_sm13697158')">
<p><a href="watch/sm13697158"><img src="http://tn-skr3.smilevideo.jp/smile?i=13697158" alt="" class="img_std96"></a></p>
<p class="vinfo_length"><span>5:15</span></p>
</td>
<td class="font10" align="right"><div style="width:92px; overflow:hidden; padding-left:4px;"><nobr>再生：<strong class="vinfo_view">848</strong><br></nobr>
<nobr>コメ：<strong class="vinfo_res">26</strong><br></nobr>
<nobr>マイ：<a href="mylistcomment/video/sm13697158" style="color:#393F3F;"><strong class="vinfo_mylist">54</strong></a><br></nobr>
<nobr>宣伝：<a href="http://uad.nicovideo.jp/ads/?vid=sm13697158" style="color:#393F3F;"><strong id="item5_uad_point_number" class="vinfo_uadp">0</strong></a><br></nobr>
</div></td>
</tr>
</table>
	</div>
</td>
<td style="background:url('http://res.nimg.jp/img/common/thumb/split_line.png') no-repeat bottom left; padding-bottom:6px;">
<div style="width:412px; overflow:hidden;">
<p class="font12 thumb_num">

<strong>
2011年02月24日 21:51
</strong> 投稿
</p>
<p class="font16" style="margin:2px 0;"><nobr><a href="watch/sm13697158" class="watch" title="【oFFENCe】初音ミクにヤンデレを演じさせてみた…【MMD-PV】">【oFFENCe】初音ミクにヤンデレを演じさせてみた…【MMD-PV】</a></nobr></p>
<p class="vinfo_description" title="offence【名詞】敵を攻撃する行為、怒ることによって引き起こされた怒りの感情　※日本語WordNet(英和)より...">offence【名詞】敵を攻撃する行為、怒ることによって引き起こされた怒りの感情　※日本語WordNet(英和)より...</p>
</div>
</td>
</tr>
</table>
<!---->
</div>
</div>



<div style="clear:both;">





<div class="thumb_col_1">
<!---->
<table width="624" cellpadding="4" cellspacing="0" summary="sm13636905">
<tr valign="top">
<td><div id="item6" style="display:none;" onMouseover="showOBJ('thumb_uad_msg_sm13636905')" onMouseout="hideOBJ('thumb_uad_msg_sm13636905')">
	<div id="thumb_uad_msg_sm13636905" style="display:none; position:absolute;">
	<p id="item6_uad_comment" class="uad_comment"><span style="color:#666;">-</span></p>
	</div>
</div>
<div id="item6_thumb" class="uad_thumbfrm">
<table cellspacing="0" cellpadding="0">
<tr>
<td onMouseover="showOBJ('thumb_uad_msg_sm13636905')" onMouseout="hideOBJ('thumb_uad_msg_sm13636905')">
<p><a href="watch/sm13636905"><img src="http://tn-skr2.smilevideo.jp/smile?i=13636905" alt="" class="img_std96"></a></p>
<p class="vinfo_length"><span>4:58</span></p>
</td>
<td class="font10" align="right"><div style="width:92px; overflow:hidden; padding-left:4px;"><nobr>再生：<strong class="vinfo_view">66,048</strong><br></nobr>
<nobr>コメ：<strong class="vinfo_res">2,705</strong><br></nobr>
<nobr>マイ：<a href="mylistcomment/video/sm13636905" style="color:#393F3F;"><strong class="vinfo_mylist">7,004</strong></a><br></nobr>
<nobr>宣伝：<a href="http://uad.nicovideo.jp/ads/?vid=sm13636905" style="color:#393F3F;"><strong id="item6_uad_point_number" class="vinfo_uadp">0</strong></a><br></nobr>
</div></td>
</tr>
</table>
	</div>
</td>
<td style="background:url('http://res.nimg.jp/img/common/thumb/split_line.png') no-repeat bottom left; padding-bottom:6px;">
<div style="width:412px; overflow:hidden;">
<p class="font12 thumb_num">

<strong>
2011年02月18日 21:00
</strong> 投稿
</p>
<p class="font16" style="margin:2px 0;"><nobr><a href="watch/sm13636905" class="watch" title="【初音ミク】memory【PV付オリジナル】">【初音ミク】memory【PV付オリジナル】</a></nobr></p>
<p class="vinfo_description" title="諦めた夢のなんて眩しいことだろう。■Compose164　(mylist/3304983)">諦めた夢のなんて眩しいことだろう。■Compose164　(mylist/3304983)</p>
</div>
</td>
</tr>
</table>
<!---->
</div>
</div>



<div style="clear:both;">





<div class="thumb_col_1">
<!---->
<table width="624" cellpadding="4" cellspacing="0" summary="sm13741173">
<tr valign="top">
<td><div id="item7" style="display:none;" onMouseover="showOBJ('thumb_uad_msg_sm13741173')" onMouseout="hideOBJ('thumb_uad_msg_sm13741173')">
	<div id="thumb_uad_msg_sm13741173" style="display:none; position:absolute;">
	<p id="item7_uad_comment" class="uad_comment"><span style="color:#666;">-</span></p>
	</div>
</div>
<div id="item7_thumb" class="uad_thumbfrm">
<table cellspacing="0" cellpadding="0">
<tr>
<td onMouseover="showOBJ('thumb_uad_msg_sm13741173')" onMouseout="hideOBJ('thumb_uad_msg_sm13741173')">
<p><a href="watch/sm13741173"><img src="http://tn-skr2.smilevideo.jp/smile?i=13741173" alt="" class="img_std96"></a></p>
<p class="vinfo_length"><span>24:54</span></p>
</td>
<td class="font10" align="right"><div style="width:92px; overflow:hidden; padding-left:4px;"><nobr>再生：<strong class="vinfo_view">2,195</strong><br></nobr>
<nobr>コメ：<strong class="vinfo_res">2,376</strong><br></nobr>
<nobr>マイ：<a href="mylistcomment/video/sm13741173" style="color:#393F3F;"><strong class="vinfo_mylist">242</strong></a><br></nobr>
<nobr>宣伝：<a href="http://uad.nicovideo.jp/ads/?vid=sm13741173" style="color:#393F3F;"><strong id="item7_uad_point_number" class="vinfo_uadp">0</strong></a><br></nobr>
</div></td>
</tr>
</table>
	</div>
</td>
<td style="background:url('http://res.nimg.jp/img/common/thumb/split_line.png') no-repeat bottom left; padding-bottom:6px;">
<div style="width:412px; overflow:hidden;">
<p class="font12 thumb_num">

<strong>
2011年03月01日 02:51
</strong> 投稿
<span style="color:#C00;">9時間前</span>
</p>
<p class="font16" style="margin:2px 0;"><nobr><a href="watch/sm13741173" class="watch" title="週刊VOCALOIDランキング　#178">週刊VOCALOIDランキング　#178</a></nobr></p>
<p class="vinfo_description" title="○集計期間：2011年2月21日5時～2011年2月28日5時○集計方法：再生数+(コメント数×補正値A)+(マイリス...">○集計期間：2011年2月21日5時～2011年2月28日5時○集計方法：再生数+(コメント数×補正値A)+(マイリス...</p>
</div>
</td>
</tr>
</table>
<!---->
</div>
</div>



<div style="clear:both;">





<div class="thumb_col_1">
<!---->
<table width="624" cellpadding="4" cellspacing="0" summary="sm8089993">
<tr valign="top">
<td><div id="item8" style="display:none;" onMouseover="showOBJ('thumb_uad_msg_sm8089993')" onMouseout="hideOBJ('thumb_uad_msg_sm8089993')">
	<div id="thumb_uad_msg_sm8089993" style="display:none; position:absolute;">
	<p id="item8_uad_comment" class="uad_comment"><span style="color:#666;">-</span></p>
	</div>
</div>
<div id="item8_thumb" class="uad_thumbfrm">
<table cellspacing="0" cellpadding="0">
<tr>
<td onMouseover="showOBJ('thumb_uad_msg_sm8089993')" onMouseout="hideOBJ('thumb_uad_msg_sm8089993')">
<p><a href="watch/sm8089993"><img src="http://tn-skr2.smilevideo.jp/smile?i=8089993" alt="" class="img_std96"></a></p>
<p class="vinfo_length"><span>5:36</span></p>
</td>
<td class="font10" align="right"><div style="width:92px; overflow:hidden; padding-left:4px;"><nobr>再生：<strong class="vinfo_view">2,596,713</strong><br></nobr>
<nobr>コメ：<strong class="vinfo_res">163,163</strong><br></nobr>
<nobr>マイ：<a href="mylistcomment/video/sm8089993" style="color:#393F3F;"><strong class="vinfo_mylist">244,027</strong></a><br></nobr>
<nobr>宣伝：<a href="http://uad.nicovideo.jp/ads/?vid=sm8089993" style="color:#393F3F;"><strong id="item8_uad_point_number" class="vinfo_uadp">0</strong></a><br></nobr>
</div></td>
</tr>
</table>
	</div>
</td>
<td style="background:url('http://res.nimg.jp/img/common/thumb/split_line.png') no-repeat bottom left; padding-bottom:6px;">
<div style="width:412px; overflow:hidden;">
<p class="font12 thumb_num">

<strong>
2009年08月30日 22:49
</strong> 投稿
</p>
<p class="font16" style="margin:2px 0;"><nobr><a href="watch/sm8089993" class="watch" title="【鏡音リン】炉心融解【オリジナル】 ">【鏡音リン】炉心融解【オリジナル】 </a></nobr></p>
<p class="vinfo_description" title="new!! 曲の人新作→sm13465059　　絵の人新作→sm13159498作曲：iroha　...">new!! 曲の人新作→sm13465059　　絵の人新作→sm13159498作曲：iroha　...</p>
</div>
</td>
</tr>
</table>
<!---->
</div>
</div>



<div style="clear:both;">





<div class="thumb_col_1">
<!---->
<table width="624" cellpadding="4" cellspacing="0" summary="sm13664704">
<tr valign="top">
<td><div id="item9" style="display:none;" onMouseover="showOBJ('thumb_uad_msg_sm13664704')" onMouseout="hideOBJ('thumb_uad_msg_sm13664704')">
	<div id="thumb_uad_msg_sm13664704" style="display:none; position:absolute;">
	<p id="item9_uad_comment" class="uad_comment"><span style="color:#666;">-</span></p>
	</div>
</div>
<div id="item9_thumb" class="uad_thumbfrm">
<table cellspacing="0" cellpadding="0">
<tr>
<td onMouseover="showOBJ('thumb_uad_msg_sm13664704')" onMouseout="hideOBJ('thumb_uad_msg_sm13664704')">
<p><a href="watch/sm13664704"><img src="http://tn-skr1.smilevideo.jp/smile?i=13664704" alt="" class="img_std96"></a></p>
<p class="vinfo_length"><span>5:07</span></p>
</td>
<td class="font10" align="right"><div style="width:92px; overflow:hidden; padding-left:4px;"><nobr>再生：<strong class="vinfo_view">114,370</strong><br></nobr>
<nobr>コメ：<strong class="vinfo_res">5,617</strong><br></nobr>
<nobr>マイ：<a href="mylistcomment/video/sm13664704" style="color:#393F3F;"><strong class="vinfo_mylist">12,873</strong></a><br></nobr>
<nobr>宣伝：<a href="http://uad.nicovideo.jp/ads/?vid=sm13664704" style="color:#393F3F;"><strong id="item9_uad_point_number" class="vinfo_uadp">0</strong></a><br></nobr>
</div></td>
</tr>
</table>
	</div>
</td>
<td style="background:url('http://res.nimg.jp/img/common/thumb/split_line.png') no-repeat bottom left; padding-bottom:6px;">
<div style="width:412px; overflow:hidden;">
<p class="font12 thumb_num">

<strong>
2011年02月21日 12:52
</strong> 投稿
</p>
<p class="font16" style="margin:2px 0;"><nobr><a href="watch/sm13664704" class="watch" title="【初音ミク】僕をそんな目で見ないで【オリジナル曲手書きＰＶ】">【初音ミク】僕をそんな目で見ないで【オリジナル曲手書きＰＶ】</a></nobr></p>
<p class="vinfo_description" title="きくおです、ボカロ曲第六弾です＞＜※2011/2/27　追記：人によって大きいダメージを受けることがある...">きくおです、ボカロ曲第六弾です＞＜※2011/2/27　追記：人によって大きいダメージを受けることがある...</p>
</div>
</td>
</tr>
</table>
<!---->
</div>
</div>



<div style="clear:both;">





<div class="thumb_col_1">
<!---->
<table width="624" cellpadding="4" cellspacing="0" summary="sm12556499">
<tr valign="top">
<td><div id="item10" style="display:none;" onMouseover="showOBJ('thumb_uad_msg_sm12556499')" onMouseout="hideOBJ('thumb_uad_msg_sm12556499')">
	<div id="thumb_uad_msg_sm12556499" style="display:none; position:absolute;">
	<p id="item10_uad_comment" class="uad_comment"><span style="color:#666;">-</span></p>
	</div>
</div>
<div id="item10_thumb" class="uad_thumbfrm">
<table cellspacing="0" cellpadding="0">
<tr>
<td onMouseover="showOBJ('thumb_uad_msg_sm12556499')" onMouseout="hideOBJ('thumb_uad_msg_sm12556499')">
<p><a href="watch/sm12556499"><img src="http://tn-skr4.smilevideo.jp/smile?i=12556499" alt="" class="img_std96"></a></p>
<p class="vinfo_length"><span>3:10</span></p>
</td>
<td class="font10" align="right"><div style="width:92px; overflow:hidden; padding-left:4px;"><nobr>再生：<strong class="vinfo_view">9,498</strong><br></nobr>
<nobr>コメ：<strong class="vinfo_res">410</strong><br></nobr>
<nobr>マイ：<a href="mylistcomment/video/sm12556499" style="color:#393F3F;"><strong class="vinfo_mylist">853</strong></a><br></nobr>
<nobr>宣伝：<a href="http://uad.nicovideo.jp/ads/?vid=sm12556499" style="color:#393F3F;"><strong id="item10_uad_point_number" class="vinfo_uadp">0</strong></a><br></nobr>
</div></td>
</tr>
</table>
	</div>
</td>
<td style="background:url('http://res.nimg.jp/img/common/thumb/split_line.png') no-repeat bottom left; padding-bottom:6px;">
<div style="width:412px; overflow:hidden;">
<p class="font12 thumb_num">

<strong>
2010年10月26日 19:14
</strong> 投稿
</p>
<p class="font16" style="margin:2px 0;"><nobr><a href="watch/sm12556499" class="watch" title="【MMD】ちびぬこレンとKAITOのなんでもない日常">【MMD】ちびぬこレンとKAITOのなんでもない日常</a></nobr></p>
<p class="vinfo_description" title="●ごく日常的なモーションで和める動画を作るつもりが、ゆったりほのぼのな曲の中にゆとりなくギチギチに詰...">●ごく日常的なモーションで和める動画を作るつもりが、ゆったりほのぼのな曲の中にゆとりなくギチギチに詰...</p>
</div>
</td>
</tr>
</table>
<!---->
</div>
</div>



<div style="clear:both;">





<div class="thumb_col_1">
<!---->
<table width="624" cellpadding="4" cellspacing="0" summary="sm12820248">
<tr valign="top">
<td><div id="item11" style="display:none;" onMouseover="showOBJ('thumb_uad_msg_sm12820248')" onMouseout="hideOBJ('thumb_uad_msg_sm12820248')">
	<div id="thumb_uad_msg_sm12820248" style="display:none; position:absolute;">
	<p id="item11_uad_comment" class="uad_comment"><span style="color:#666;">-</span></p>
	</div>
</div>
<div id="item11_thumb" class="uad_thumbfrm">
<table cellspacing="0" cellpadding="0">
<tr>
<td onMouseover="showOBJ('thumb_uad_msg_sm12820248')" onMouseout="hideOBJ('thumb_uad_msg_sm12820248')">
<p><a href="watch/sm12820248"><img src="http://tn-skr1.smilevideo.jp/smile?i=12820248" alt="" class="img_std96"></a></p>
<p class="vinfo_length"><span>10:17</span></p>
</td>
<td class="font10" align="right"><div style="width:92px; overflow:hidden; padding-left:4px;"><nobr>再生：<strong class="vinfo_view">9,395</strong><br></nobr>
<nobr>コメ：<strong class="vinfo_res">930</strong><br></nobr>
<nobr>マイ：<a href="mylistcomment/video/sm12820248" style="color:#393F3F;"><strong class="vinfo_mylist">1,339</strong></a><br></nobr>
<nobr>宣伝：<a href="http://uad.nicovideo.jp/ads/?vid=sm12820248" style="color:#393F3F;"><strong id="item11_uad_point_number" class="vinfo_uadp">0</strong></a><br></nobr>
</div></td>
</tr>
</table>
	</div>
</td>
<td style="background:url('http://res.nimg.jp/img/common/thumb/split_line.png') no-repeat bottom left; padding-bottom:6px;">
<div style="width:412px; overflow:hidden;">
<p class="font12 thumb_num">

<strong>
2010年11月22日 01:53
</strong> 投稿
</p>
<p class="font16" style="margin:2px 0;"><nobr><a href="watch/sm12820248" class="watch" title="【DIVA2nd】Alice in Musicland【EDIT動画】">【DIVA2nd】Alice in Musicland【EDIT動画】</a></nobr></p>
<p class="vinfo_description" title="OSTER project氏の2ndアルバム「Cinnamon philosophy」17曲目より。クリプトン家総動員。本当に素敵な曲で...">OSTER project氏の2ndアルバム「Cinnamon philosophy」17曲目より。クリプトン家総動員。本当に素敵な曲で...</p>
</div>
</td>
</tr>
</table>
<!---->
</div>
</div>



<div style="clear:both;">





<div class="thumb_col_1">
<!---->
<table width="624" cellpadding="4" cellspacing="0" summary="sm13722343">
<tr valign="top">
<td><div id="item12" style="display:none;" onMouseover="showOBJ('thumb_uad_msg_sm13722343')" onMouseout="hideOBJ('thumb_uad_msg_sm13722343')">
	<div id="thumb_uad_msg_sm13722343" style="display:none; position:absolute;">
	<p id="item12_uad_comment" class="uad_comment"><span style="color:#666;">-</span></p>
	</div>
</div>
<div id="item12_thumb" class="uad_thumbfrm">
<table cellspacing="0" cellpadding="0">
<tr>
<td onMouseover="showOBJ('thumb_uad_msg_sm13722343')" onMouseout="hideOBJ('thumb_uad_msg_sm13722343')">
<p><a href="watch/sm13722343"><img src="http://tn-skr4.smilevideo.jp/smile?i=13722343" alt="" class="img_std96"></a></p>
<p class="vinfo_length"><span>3:57</span></p>
</td>
<td class="font10" align="right"><div style="width:92px; overflow:hidden; padding-left:4px;"><nobr>再生：<strong class="vinfo_view">21</strong><br></nobr>
<nobr>コメ：<strong class="vinfo_res">2</strong><br></nobr>
<nobr>マイ：<a href="mylistcomment/video/sm13722343" style="color:#393F3F;"><strong class="vinfo_mylist">0</strong></a><br></nobr>
<nobr>宣伝：<a href="http://uad.nicovideo.jp/ads/?vid=sm13722343" style="color:#393F3F;"><strong id="item12_uad_point_number" class="vinfo_uadp">0</strong></a><br></nobr>
</div></td>
</tr>
</table>
	</div>
</td>
<td style="background:url('http://res.nimg.jp/img/common/thumb/split_line.png') no-repeat bottom left; padding-bottom:6px;">
<div style="width:412px; overflow:hidden;">
<p class="font12 thumb_num">

<strong>
2011年02月27日 11:54
</strong> 投稿
</p>
<p class="font16" style="margin:2px 0;"><nobr><a href="watch/sm13722343" class="watch" title="Parades ピアノver. - daburu">Parades ピアノver. - daburu</a></nobr></p>
<p class="vinfo_description" title="私はwhooの曲のいずれかを配置しているそれは素晴らしい曲です... このような構成よりも |･ω･｀)ｺｯｼｮﾘ原曲...">私はwhooの曲のいずれかを配置しているそれは素晴らしい曲です... このような構成よりも |･ω･｀)ｺｯｼｮﾘ原曲...</p>
</div>
</td>
</tr>
</table>
<!---->
</div>
</div>



<div style="clear:both;">





<div class="thumb_col_1">
<!---->
<table width="624" cellpadding="4" cellspacing="0" summary="sm12195657">
<tr valign="top">
<td><div id="item13" style="display:none;" onMouseover="showOBJ('thumb_uad_msg_sm12195657')" onMouseout="hideOBJ('thumb_uad_msg_sm12195657')">
	<div id="thumb_uad_msg_sm12195657" style="display:none; position:absolute;">
	<p id="item13_uad_comment" class="uad_comment"><span style="color:#666;">-</span></p>
	</div>
</div>
<div id="item13_thumb" class="uad_thumbfrm">
<table cellspacing="0" cellpadding="0">
<tr>
<td onMouseover="showOBJ('thumb_uad_msg_sm12195657')" onMouseout="hideOBJ('thumb_uad_msg_sm12195657')">
<p><a href="watch/sm12195657"><img src="http://tn-skr2.smilevideo.jp/smile?i=12195657" alt="" class="img_std96"></a></p>
<p class="vinfo_length"><span>4:22</span></p>
</td>
<td class="font10" align="right"><div style="width:92px; overflow:hidden; padding-left:4px;"><nobr>再生：<strong class="vinfo_view">123,507</strong><br></nobr>
<nobr>コメ：<strong class="vinfo_res">8,752</strong><br></nobr>
<nobr>マイ：<a href="mylistcomment/video/sm12195657" style="color:#393F3F;"><strong class="vinfo_mylist">10,750</strong></a><br></nobr>
<nobr>宣伝：<a href="http://uad.nicovideo.jp/ads/?vid=sm12195657" style="color:#393F3F;"><strong id="item13_uad_point_number" class="vinfo_uadp">0</strong></a><br></nobr>
</div></td>
</tr>
</table>
	</div>
</td>
<td style="background:url('http://res.nimg.jp/img/common/thumb/split_line.png') no-repeat bottom left; padding-bottom:6px;">
<div style="width:412px; overflow:hidden;">
<p class="font12 thumb_num">

<strong>
2010年09月23日 00:00
</strong> 投稿
</p>
<p class="font16" style="margin:2px 0;"><nobr><a href="watch/sm12195657" class="watch" title="【初音ミク】カロン【オリジナルPV】">【初音ミク】カロン【オリジナルPV】</a></nobr></p>
<p class="vinfo_description" title="失礼します、KulfiQと申します。セーラープルートって可愛いですよね。サターンと間違...">失礼します、KulfiQと申します。セーラープルートって可愛いですよね。サターンと間違...</p>
</div>
</td>
</tr>
</table>
<!---->
</div>
</div>



<div style="clear:both;">





<div class="thumb_col_1">
<!---->
<table width="624" cellpadding="4" cellspacing="0" summary="sm13577349">
<tr valign="top">
<td><div id="item14" style="display:none;" onMouseover="showOBJ('thumb_uad_msg_sm13577349')" onMouseout="hideOBJ('thumb_uad_msg_sm13577349')">
	<div id="thumb_uad_msg_sm13577349" style="display:none; position:absolute;">
	<p id="item14_uad_comment" class="uad_comment"><span style="color:#666;">-</span></p>
	</div>
</div>
<div id="item14_thumb" class="uad_thumbfrm">
<table cellspacing="0" cellpadding="0">
<tr>
<td onMouseover="showOBJ('thumb_uad_msg_sm13577349')" onMouseout="hideOBJ('thumb_uad_msg_sm13577349')">
<p><a href="watch/sm13577349"><img src="http://tn-skr2.smilevideo.jp/smile?i=13577349" alt="" class="img_std96"></a></p>
<p class="vinfo_length"><span>5:15</span></p>
</td>
<td class="font10" align="right"><div style="width:92px; overflow:hidden; padding-left:4px;"><nobr>再生：<strong class="vinfo_view">6,542</strong><br></nobr>
<nobr>コメ：<strong class="vinfo_res">305</strong><br></nobr>
<nobr>マイ：<a href="mylistcomment/video/sm13577349" style="color:#393F3F;"><strong class="vinfo_mylist">642</strong></a><br></nobr>
<nobr>宣伝：<a href="http://uad.nicovideo.jp/ads/?vid=sm13577349" style="color:#393F3F;"><strong id="item14_uad_point_number" class="vinfo_uadp">0</strong></a><br></nobr>
</div></td>
</tr>
</table>
	</div>
</td>
<td style="background:url('http://res.nimg.jp/img/common/thumb/split_line.png') no-repeat bottom left; padding-bottom:6px;">
<div style="width:412px; overflow:hidden;">
<p class="font12 thumb_num">

<strong>
2011年02月12日 19:55
</strong> 投稿
</p>
<p class="font16" style="margin:2px 0;"><nobr><a href="watch/sm13577349" class="watch" title="【第6回MMD杯本選】でっかい街、ちっさい僕">【第6回MMD杯本選】でっかい街、ちっさい僕</a></nobr></p>
<p class="vinfo_description" title="エキシビション⇛sm13706545テーマは『E』MMEを使用した質感表現と、ロケ地の&quot;でっかい街&quot;東京...">エキシビション⇛sm13706545テーマは『E』MMEを使用した質感表現と、ロケ地の"でっかい街"東京...</p>
</div>
</td>
</tr>
</table>
<!---->
</div>
</div>



<div style="clear:both;">





<div class="thumb_col_1">
<!---->
<table width="624" cellpadding="4" cellspacing="0" summary="sm13386216">
<tr valign="top">
<td><div id="item15" style="display:none;" onMouseover="showOBJ('thumb_uad_msg_sm13386216')" onMouseout="hideOBJ('thumb_uad_msg_sm13386216')">
	<div id="thumb_uad_msg_sm13386216" style="display:none; position:absolute;">
	<p id="item15_uad_comment" class="uad_comment"><span style="color:#666;">-</span></p>
	</div>
</div>
<div id="item15_thumb" class="uad_thumbfrm">
<table cellspacing="0" cellpadding="0">
<tr>
<td onMouseover="showOBJ('thumb_uad_msg_sm13386216')" onMouseout="hideOBJ('thumb_uad_msg_sm13386216')">
<p><a href="watch/sm13386216"><img src="http://tn-skr1.smilevideo.jp/smile?i=13386216" alt="" class="img_std96"></a></p>
<p class="vinfo_length"><span>3:46</span></p>
</td>
<td class="font10" align="right"><div style="width:92px; overflow:hidden; padding-left:4px;"><nobr>再生：<strong class="vinfo_view">908,628</strong><br></nobr>
<nobr>コメ：<strong class="vinfo_res">47,966</strong><br></nobr>
<nobr>マイ：<a href="mylistcomment/video/sm13386216" style="color:#393F3F;"><strong class="vinfo_mylist">60,921</strong></a><br></nobr>
<nobr>宣伝：<a href="http://uad.nicovideo.jp/ads/?vid=sm13386216" style="color:#393F3F;"><strong id="item15_uad_point_number" class="vinfo_uadp">0</strong></a><br></nobr>
</div></td>
</tr>
</table>
	</div>
</td>
<td style="background:url('http://res.nimg.jp/img/common/thumb/split_line.png') no-repeat bottom left; padding-bottom:6px;">
<div style="width:412px; overflow:hidden;">
<p class="font12 thumb_num">

<strong>
2011年01月23日 16:32
</strong> 投稿
</p>
<p class="font16" style="margin:2px 0;"><nobr><a href="watch/sm13386216" class="watch" title="【オリジナル曲PV】 パンダヒーロー 【GUMI】">【オリジナル曲PV】 パンダヒーロー 【GUMI】</a></nobr></p>
<p class="vinfo_description" title="どうもハチです。ヒーローの曲かきました。2ndアルバム「OFFICIAL ORANGE」より。アレン...">どうもハチです。ヒーローの曲かきました。2ndアルバム「OFFICIAL ORANGE」より。アレン...</p>
</div>
</td>
</tr>
</table>
<!---->
</div>
</div>



<div style="clear:both;">





<div class="thumb_col_1">
<!---->
<table width="624" cellpadding="4" cellspacing="0" summary="sm13738063">
<tr valign="top">
<td><div id="item16" style="display:none;" onMouseover="showOBJ('thumb_uad_msg_sm13738063')" onMouseout="hideOBJ('thumb_uad_msg_sm13738063')">
	<div id="thumb_uad_msg_sm13738063" style="display:none; position:absolute;">
	<p id="item16_uad_comment" class="uad_comment"><span style="color:#666;">-</span></p>
	</div>
</div>
<div id="item16_thumb" class="uad_thumbfrm">
<table cellspacing="0" cellpadding="0">
<tr>
<td onMouseover="showOBJ('thumb_uad_msg_sm13738063')" onMouseout="hideOBJ('thumb_uad_msg_sm13738063')">
<p><a href="watch/sm13738063"><img src="http://tn-skr4.smilevideo.jp/smile?i=13738063" alt="" class="img_std96"></a></p>
<p class="vinfo_length"><span>3:25</span></p>
</td>
<td class="font10" align="right"><div style="width:92px; overflow:hidden; padding-left:4px;"><nobr>再生：<strong class="vinfo_view">636</strong><br></nobr>
<nobr>コメ：<strong class="vinfo_res">52</strong><br></nobr>
<nobr>マイ：<a href="mylistcomment/video/sm13738063" style="color:#393F3F;"><strong class="vinfo_mylist">130</strong></a><br></nobr>
<nobr>宣伝：<a href="http://uad.nicovideo.jp/ads/?vid=sm13738063" style="color:#393F3F;"><strong id="item16_uad_point_number" class="vinfo_uadp">0</strong></a><br></nobr>
</div></td>
</tr>
</table>
	</div>
</td>
<td style="background:url('http://res.nimg.jp/img/common/thumb/split_line.png') no-repeat bottom left; padding-bottom:6px;">
<div style="width:412px; overflow:hidden;">
<p class="font12 thumb_num">

<strong>
2011年02月28日 22:00
</strong> 投稿
<span style="color:#C00;">13時間前</span>
</p>
<p class="font16" style="margin:2px 0;"><nobr><a href="watch/sm13738063" class="watch" title="【鏡音リンappend】夢見がちダンスパーティー【オリジナル】">【鏡音リンappend】夢見がちダンスパーティー【オリジナル】</a></nobr></p>
<p class="vinfo_description" title="9610さんとぷにＰとせかいせいふくＰです。せＰ「遠く離れても、僕達のパーティーは終わらない...">9610さんとぷにＰとせかいせいふくＰです。せＰ「遠く離れても、僕達のパーティーは終わらない...</p>
</div>
</td>
</tr>
</table>
<!---->
</div>
</div>



<div style="clear:both;">





<div class="thumb_col_1">
<!---->
<table width="624" cellpadding="4" cellspacing="0" summary="sm8082467">
<tr valign="top">
<td><div id="item17" style="display:none;" onMouseover="showOBJ('thumb_uad_msg_sm8082467')" onMouseout="hideOBJ('thumb_uad_msg_sm8082467')">
	<div id="thumb_uad_msg_sm8082467" style="display:none; position:absolute;">
	<p id="item17_uad_comment" class="uad_comment"><span style="color:#666;">-</span></p>
	</div>
</div>
<div id="item17_thumb" class="uad_thumbfrm">
<table cellspacing="0" cellpadding="0">
<tr>
<td onMouseover="showOBJ('thumb_uad_msg_sm8082467')" onMouseout="hideOBJ('thumb_uad_msg_sm8082467')">
<p><a href="watch/sm8082467"><img src="http://tn-skr4.smilevideo.jp/smile?i=8082467" alt="" class="img_std96"></a></p>
<p class="vinfo_length"><span>3:09</span></p>
</td>
<td class="font10" align="right"><div style="width:92px; overflow:hidden; padding-left:4px;"><nobr>再生：<strong class="vinfo_view">2,289,957</strong><br></nobr>
<nobr>コメ：<strong class="vinfo_res">47,979</strong><br></nobr>
<nobr>マイ：<a href="mylistcomment/video/sm8082467" style="color:#393F3F;"><strong class="vinfo_mylist">92,843</strong></a><br></nobr>
<nobr>宣伝：<a href="http://uad.nicovideo.jp/ads/?vid=sm8082467" style="color:#393F3F;"><strong id="item17_uad_point_number" class="vinfo_uadp">0</strong></a><br></nobr>
</div></td>
</tr>
</table>
	</div>
</td>
<td style="background:url('http://res.nimg.jp/img/common/thumb/split_line.png') no-repeat bottom left; padding-bottom:6px;">
<div style="width:412px; overflow:hidden;">
<p class="font12 thumb_num">

<strong>
2009年08月30日 05:56
</strong> 投稿
</p>
<p class="font16" style="margin:2px 0;"><nobr><a href="watch/sm8082467" class="watch" title="初音ミク　オリジナル曲　「裏表ラバーズ」">初音ミク　オリジナル曲　「裏表ラバーズ」</a></nobr></p>
<p class="vinfo_description" title="■現実逃避Pことwowakaです。■music by wowaka　mylist/12484677　HP　http:...">■現実逃避Pことwowakaです。■music by wowaka　mylist/12484677　HP　http:...</p>
</div>
</td>
</tr>
</table>
<!---->
</div>
</div>



<div style="clear:both;">





<div class="thumb_col_1">
<!---->
<table width="624" cellpadding="4" cellspacing="0" summary="sm12526980">
<tr valign="top">
<td><div id="item18" style="display:none;" onMouseover="showOBJ('thumb_uad_msg_sm12526980')" onMouseout="hideOBJ('thumb_uad_msg_sm12526980')">
	<div id="thumb_uad_msg_sm12526980" style="display:none; position:absolute;">
	<p id="item18_uad_comment" class="uad_comment"><span style="color:#666;">-</span></p>
	</div>
</div>
<div id="item18_thumb" class="uad_thumbfrm">
<table cellspacing="0" cellpadding="0">
<tr>
<td onMouseover="showOBJ('thumb_uad_msg_sm12526980')" onMouseout="hideOBJ('thumb_uad_msg_sm12526980')">
<p><a href="watch/sm12526980"><img src="http://tn-skr1.smilevideo.jp/smile?i=12526980" alt="" class="img_std96"></a></p>
<p class="vinfo_length"><span>5:15</span></p>
</td>
<td class="font10" align="right"><div style="width:92px; overflow:hidden; padding-left:4px;"><nobr>再生：<strong class="vinfo_view">10,770</strong><br></nobr>
<nobr>コメ：<strong class="vinfo_res">414</strong><br></nobr>
<nobr>マイ：<a href="mylistcomment/video/sm12526980" style="color:#393F3F;"><strong class="vinfo_mylist">1,134</strong></a><br></nobr>
<nobr>宣伝：<a href="http://uad.nicovideo.jp/ads/?vid=sm12526980" style="color:#393F3F;"><strong id="item18_uad_point_number" class="vinfo_uadp">0</strong></a><br></nobr>
</div></td>
</tr>
</table>
	</div>
</td>
<td style="background:url('http://res.nimg.jp/img/common/thumb/split_line.png') no-repeat bottom left; padding-bottom:6px;">
<div style="width:412px; overflow:hidden;">
<p class="font12 thumb_num">

<strong>
2010年10月24日 00:46
</strong> 投稿
</p>
<p class="font16" style="margin:2px 0;"><nobr><a href="watch/sm12526980" class="watch" title="【GUMI】 Last Sunset House remix【オリジナル曲PV】">【GUMI】 Last Sunset House remix【オリジナル曲PV】</a></nobr></p>
<p class="vinfo_description" title="どうもご無沙汰しております、７作目の投稿です。オリジナル曲「Last Sunset GUMIver.」【sm7945251】のア...">どうもご無沙汰しております、７作目の投稿です。オリジナル曲「Last Sunset GUMIver.」【sm7945251】のア...</p>
</div>
</td>
</tr>
</table>
<!---->
</div>
</div>



<div style="clear:both;">





<div class="thumb_col_1">
<!---->
<table width="624" cellpadding="4" cellspacing="0" summary="sm11519178">
<tr valign="top">
<td><div id="item19" style="display:none;" onMouseover="showOBJ('thumb_uad_msg_sm11519178')" onMouseout="hideOBJ('thumb_uad_msg_sm11519178')">
	<div id="thumb_uad_msg_sm11519178" style="display:none; position:absolute;">
	<p id="item19_uad_comment" class="uad_comment"><span style="color:#666;">-</span></p>
	</div>
</div>
<div id="item19_thumb" class="uad_thumbfrm">
<table cellspacing="0" cellpadding="0">
<tr>
<td onMouseover="showOBJ('thumb_uad_msg_sm11519178')" onMouseout="hideOBJ('thumb_uad_msg_sm11519178')">
<p><a href="watch/sm11519178"><img src="http://tn-skr3.smilevideo.jp/smile?i=11519178" alt="" class="img_std96"></a></p>
<p class="vinfo_length"><span>4:38</span></p>
</td>
<td class="font10" align="right"><div style="width:92px; overflow:hidden; padding-left:4px;"><nobr>再生：<strong class="vinfo_view">761,760</strong><br></nobr>
<nobr>コメ：<strong class="vinfo_res">52,599</strong><br></nobr>
<nobr>マイ：<a href="mylistcomment/video/sm11519178" style="color:#393F3F;"><strong class="vinfo_mylist">47,253</strong></a><br></nobr>
<nobr>宣伝：<a href="http://uad.nicovideo.jp/ads/?vid=sm11519178" style="color:#393F3F;"><strong id="item19_uad_point_number" class="vinfo_uadp">0</strong></a><br></nobr>
</div></td>
</tr>
</table>
	</div>
</td>
<td style="background:url('http://res.nimg.jp/img/common/thumb/split_line.png') no-repeat bottom left; padding-bottom:6px;">
<div style="width:412px; overflow:hidden;">
<p class="font12 thumb_num">

<strong>
2010年07月26日 07:24
</strong> 投稿
</p>
<p class="font16" style="margin:2px 0;"><nobr><a href="watch/sm11519178" class="watch" title="【神威がくぽ・他】ヴェノマニア公の狂気【中世物語風オリジナル】">【神威がくぽ・他】ヴェノマニア公の狂気【中世物語風オリジナル】</a></nobr></p>
<p class="vinfo_description" title="「踊ろうよ　このハーレムで」◆10万再生ありがとうございます！◆情欲に溺れちゃった人の...">「踊ろうよ　このハーレムで」◆10万再生ありがとうございます！◆情欲に溺れちゃった人の...</p>
</div>
</td>
</tr>
</table>
<!---->
</div>
</div>



<div style="clear:both;">





<div class="thumb_col_1">
<!---->
<table width="624" cellpadding="4" cellspacing="0" summary="sm11303956">
<tr valign="top">
<td><div id="item20" style="display:none;" onMouseover="showOBJ('thumb_uad_msg_sm11303956')" onMouseout="hideOBJ('thumb_uad_msg_sm11303956')">
	<div id="thumb_uad_msg_sm11303956" style="display:none; position:absolute;">
	<p id="item20_uad_comment" class="uad_comment"><span style="color:#666;">-</span></p>
	</div>
</div>
<div id="item20_thumb" class="uad_thumbfrm">
<table cellspacing="0" cellpadding="0">
<tr>
<td onMouseover="showOBJ('thumb_uad_msg_sm11303956')" onMouseout="hideOBJ('thumb_uad_msg_sm11303956')">
<p><a href="watch/sm11303956"><img src="http://tn-skr1.smilevideo.jp/smile?i=11303956" alt="" class="img_std96"></a></p>
<p class="vinfo_length"><span>5:05</span></p>
</td>
<td class="font10" align="right"><div style="width:92px; overflow:hidden; padding-left:4px;"><nobr>再生：<strong class="vinfo_view">118,329</strong><br></nobr>
<nobr>コメ：<strong class="vinfo_res">11,034</strong><br></nobr>
<nobr>マイ：<a href="mylistcomment/video/sm11303956" style="color:#393F3F;"><strong class="vinfo_mylist">6,727</strong></a><br></nobr>
<nobr>宣伝：<a href="http://uad.nicovideo.jp/ads/?vid=sm11303956" style="color:#393F3F;"><strong id="item20_uad_point_number" class="vinfo_uadp">0</strong></a><br></nobr>
</div></td>
</tr>
</table>
	</div>
</td>
<td style="background:url('http://res.nimg.jp/img/common/thumb/split_line.png') no-repeat bottom left; padding-bottom:6px;">
<div style="width:412px; overflow:hidden;">
<p class="font12 thumb_num">

<strong>
2010年07月07日 02:28
</strong> 投稿
</p>
<p class="font16" style="margin:2px 0;"><nobr><a href="watch/sm11303956" class="watch" title="【吹奏楽】＊ハロー、プラネット。【編曲】">【吹奏楽】＊ハロー、プラネット。【編曲】</a></nobr></p>
<p class="vinfo_description" title="--11/02/17 更新--どうも、どりゅ～です。＊ハロー、プラネット。(sm7138245)を吹奏楽向けに編...">--11/02/17 更新--どうも、どりゅ～です。＊ハロー、プラネット。(sm7138245)を吹奏楽向けに編...</p>
</div>
</td>
</tr>
</table>
<!---->
</div>
</div>



<div style="clear:both;">





<div class="thumb_col_1">
<!---->
<table width="624" cellpadding="4" cellspacing="0" summary="sm7026662">
<tr valign="top">
<td><div id="item21" style="display:none;" onMouseover="showOBJ('thumb_uad_msg_sm7026662')" onMouseout="hideOBJ('thumb_uad_msg_sm7026662')">
	<div id="thumb_uad_msg_sm7026662" style="display:none; position:absolute;">
	<p id="item21_uad_comment" class="uad_comment"><span style="color:#666;">-</span></p>
	</div>
</div>
<div id="item21_thumb" class="uad_thumbfrm">
<table cellspacing="0" cellpadding="0">
<tr>
<td onMouseover="showOBJ('thumb_uad_msg_sm7026662')" onMouseout="hideOBJ('thumb_uad_msg_sm7026662')">
<p><a href="watch/sm7026662"><img src="http://tn-skr3.smilevideo.jp/smile?i=7026662" alt="" class="img_std96"></a></p>
<p class="vinfo_length"><span>4:05</span></p>
</td>
<td class="font10" align="right"><div style="width:92px; overflow:hidden; padding-left:4px;"><nobr>再生：<strong class="vinfo_view">119,983</strong><br></nobr>
<nobr>コメ：<strong class="vinfo_res">4,906</strong><br></nobr>
<nobr>マイ：<a href="mylistcomment/video/sm7026662" style="color:#393F3F;"><strong class="vinfo_mylist">7,921</strong></a><br></nobr>
<nobr>宣伝：<a href="http://uad.nicovideo.jp/ads/?vid=sm7026662" style="color:#393F3F;"><strong id="item21_uad_point_number" class="vinfo_uadp">0</strong></a><br></nobr>
</div></td>
</tr>
</table>
	</div>
</td>
<td style="background:url('http://res.nimg.jp/img/common/thumb/split_line.png') no-repeat bottom left; padding-bottom:6px;">
<div style="width:412px; overflow:hidden;">
<p class="font12 thumb_num">

<strong>
2009年05月12日 20:08
</strong> 投稿
</p>
<p class="font16" style="margin:2px 0;"><nobr><a href="watch/sm7026662" class="watch" title="【がくっぽいど】いろは唄【男性目線ver.】">【がくっぽいど】いろは唄【男性目線ver.】</a></nobr></p>
<p class="vinfo_description" title="銀サク様のいろは唄の男性目線歌詞をがくぽさんに歌ってもらいました。★歌詞は666。様が考えた...">銀サク様のいろは唄の男性目線歌詞をがくぽさんに歌ってもらいました。★歌詞は666。様が考えた...</p>
</div>
</td>
</tr>
</table>
<!---->
</div>
</div>



<div style="clear:both;">





<div class="thumb_col_1">
<!---->
<table width="624" cellpadding="4" cellspacing="0" summary="sm13729705">
<tr valign="top">
<td><div id="item22" style="display:none;" onMouseover="showOBJ('thumb_uad_msg_sm13729705')" onMouseout="hideOBJ('thumb_uad_msg_sm13729705')">
	<div id="thumb_uad_msg_sm13729705" style="display:none; position:absolute;">
	<p id="item22_uad_comment" class="uad_comment"><span style="color:#666;">-</span></p>
	</div>
</div>
<div id="item22_thumb" class="uad_thumbfrm">
<table cellspacing="0" cellpadding="0">
<tr>
<td onMouseover="showOBJ('thumb_uad_msg_sm13729705')" onMouseout="hideOBJ('thumb_uad_msg_sm13729705')">
<p><a href="watch/sm13729705"><img src="http://tn-skr2.smilevideo.jp/smile?i=13729705" alt="" class="img_std96"></a></p>
<p class="vinfo_length"><span>2:50</span></p>
</td>
<td class="font10" align="right"><div style="width:92px; overflow:hidden; padding-left:4px;"><nobr>再生：<strong class="vinfo_view">442</strong><br></nobr>
<nobr>コメ：<strong class="vinfo_res">33</strong><br></nobr>
<nobr>マイ：<a href="mylistcomment/video/sm13729705" style="color:#393F3F;"><strong class="vinfo_mylist">95</strong></a><br></nobr>
<nobr>宣伝：<a href="http://uad.nicovideo.jp/ads/?vid=sm13729705" style="color:#393F3F;"><strong id="item22_uad_point_number" class="vinfo_uadp">0</strong></a><br></nobr>
</div></td>
</tr>
</table>
	</div>
</td>
<td style="background:url('http://res.nimg.jp/img/common/thumb/split_line.png') no-repeat bottom left; padding-bottom:6px;">
<div style="width:412px; overflow:hidden;">
<p class="font12 thumb_num">

<strong>
2011年02月28日 00:20
</strong> 投稿
</p>
<p class="font16" style="margin:2px 0;"><nobr><a href="watch/sm13729705" class="watch" title="【巡音ルカ/鏡音レン】月明かりのワルツ【オリジナル曲】">【巡音ルカ/鏡音レン】月明かりのワルツ【オリジナル曲】</a></nobr></p>
<p class="vinfo_description" title="どもっ、96crowです。【光と影のワルツ】sm11434226からの続きものです。■イラスト→黒猫...">どもっ、96crowです。【光と影のワルツ】sm11434226からの続きものです。■イラスト→黒猫...</p>
</div>
</td>
</tr>
</table>
<!---->
</div>
</div>



<div style="clear:both;">





<div class="thumb_col_1">
<!---->
<table width="624" cellpadding="4" cellspacing="0" summary="sm13715524">
<tr valign="top">
<td><div id="item23" style="display:none;" onMouseover="showOBJ('thumb_uad_msg_sm13715524')" onMouseout="hideOBJ('thumb_uad_msg_sm13715524')">
	<div id="thumb_uad_msg_sm13715524" style="display:none; position:absolute;">
	<p id="item23_uad_comment" class="uad_comment"><span style="color:#666;">-</span></p>
	</div>
</div>
<div id="item23_thumb" class="uad_thumbfrm">
<table cellspacing="0" cellpadding="0">
<tr>
<td onMouseover="showOBJ('thumb_uad_msg_sm13715524')" onMouseout="hideOBJ('thumb_uad_msg_sm13715524')">
<p><a href="watch/sm13715524"><img src="http://tn-skr1.smilevideo.jp/smile?i=13715524" alt="" class="img_std96"></a></p>
<p class="vinfo_length"><span>3:56</span></p>
</td>
<td class="font10" align="right"><div style="width:92px; overflow:hidden; padding-left:4px;"><nobr>再生：<strong class="vinfo_view">112,493</strong><br></nobr>
<nobr>コメ：<strong class="vinfo_res">6,883</strong><br></nobr>
<nobr>マイ：<a href="mylistcomment/video/sm13715524" style="color:#393F3F;"><strong class="vinfo_mylist">20,662</strong></a><br></nobr>
<nobr>宣伝：<a href="http://uad.nicovideo.jp/ads/?vid=sm13715524" style="color:#393F3F;"><strong id="item23_uad_point_number" class="vinfo_uadp">0</strong></a><br></nobr>
</div></td>
</tr>
</table>
	</div>
</td>
<td style="background:url('http://res.nimg.jp/img/common/thumb/split_line.png') no-repeat bottom left; padding-bottom:6px;">
<div style="width:412px; overflow:hidden;">
<p class="font12 thumb_num">

<strong>
2011年02月26日 20:32
</strong> 投稿
</p>
<p class="font16" style="margin:2px 0;"><nobr><a href="watch/sm13715524" class="watch" title="【GUMI（40㍍）】 キリトリセン 【オリジナル】">【GUMI（40㍍）】 キリトリセン 【オリジナル】</a></nobr></p>
<p class="vinfo_description" title="捨てるのが下手くそな人の歌。--------- キ リ ト リ セ ン ---------詩、曲、絵...">捨てるのが下手くそな人の歌。--------- キ リ ト リ セ ン ---------詩、曲、絵...</p>
</div>
</td>
</tr>
</table>
<!---->
</div>
</div>



<div style="clear:both;">





<div class="thumb_col_1">
<!---->
<table width="624" cellpadding="4" cellspacing="0" summary="sm13739777">
<tr valign="top">
<td><div id="item24" style="display:none;" onMouseover="showOBJ('thumb_uad_msg_sm13739777')" onMouseout="hideOBJ('thumb_uad_msg_sm13739777')">
	<div id="thumb_uad_msg_sm13739777" style="display:none; position:absolute;">
	<p id="item24_uad_comment" class="uad_comment"><span style="color:#666;">-</span></p>
	</div>
</div>
<div id="item24_thumb" class="uad_thumbfrm">
<table cellspacing="0" cellpadding="0">
<tr>
<td onMouseover="showOBJ('thumb_uad_msg_sm13739777')" onMouseout="hideOBJ('thumb_uad_msg_sm13739777')">
<p><a href="watch/sm13739777"><img src="http://tn-skr2.smilevideo.jp/smile?i=13739777" alt="" class="img_std96"></a></p>
<p class="vinfo_length"><span>4:00</span></p>
</td>
<td class="font10" align="right"><div style="width:92px; overflow:hidden; padding-left:4px;"><nobr>再生：<strong class="vinfo_view">116</strong><br></nobr>
<nobr>コメ：<strong class="vinfo_res">8</strong><br></nobr>
<nobr>マイ：<a href="mylistcomment/video/sm13739777" style="color:#393F3F;"><strong class="vinfo_mylist">4</strong></a><br></nobr>
<nobr>宣伝：<a href="http://uad.nicovideo.jp/ads/?vid=sm13739777" style="color:#393F3F;"><strong id="item24_uad_point_number" class="vinfo_uadp">0</strong></a><br></nobr>
</div></td>
</tr>
</table>
	</div>
</td>
<td style="background:url('http://res.nimg.jp/img/common/thumb/split_line.png') no-repeat bottom left; padding-bottom:6px;">
<div style="width:412px; overflow:hidden;">
<p class="font12 thumb_num">

<strong>
2011年03月01日 01:57
</strong> 投稿
<span style="color:#C00;">9時間前</span>
</p>
<p class="font16" style="margin:2px 0;"><nobr><a href="watch/sm13739777" class="watch" title="うちのハクにメグメグ☆ファイアーエンドレスナイト踊ってもらった">うちのハクにメグメグ☆ファイアーエンドレスナイト踊ってもらった</a></nobr></p>
<p class="vinfo_description" title="現在、改良製作中の弱音ハクVerS2.0に「メグメグ☆ファイアーエンドレスナイト」を踊ってもらいました。いろ...">現在、改良製作中の弱音ハクVerS2.0に「メグメグ☆ファイアーエンドレスナイト」を踊ってもらいました。いろ...</p>
</div>
</td>
</tr>
</table>
<!---->
</div>
</div>



<div style="clear:both;">





<div class="thumb_col_1">
<!---->
<table width="624" cellpadding="4" cellspacing="0" summary="sm13508854">
<tr valign="top">
<td><div id="item25" style="display:none;" onMouseover="showOBJ('thumb_uad_msg_sm13508854')" onMouseout="hideOBJ('thumb_uad_msg_sm13508854')">
	<div id="thumb_uad_msg_sm13508854" style="display:none; position:absolute;">
	<p id="item25_uad_comment" class="uad_comment"><span style="color:#666;">-</span></p>
	</div>
</div>
<div id="item25_thumb" class="uad_thumbfrm">
<table cellspacing="0" cellpadding="0">
<tr>
<td onMouseover="showOBJ('thumb_uad_msg_sm13508854')" onMouseout="hideOBJ('thumb_uad_msg_sm13508854')">
<p><a href="watch/sm13508854"><img src="http://tn-skr3.smilevideo.jp/smile?i=13508854" alt="" class="img_std96"></a></p>
<p class="vinfo_length"><span>3:34</span></p>
</td>
<td class="font10" align="right"><div style="width:92px; overflow:hidden; padding-left:4px;"><nobr>再生：<strong class="vinfo_view">2,527</strong><br></nobr>
<nobr>コメ：<strong class="vinfo_res">59</strong><br></nobr>
<nobr>マイ：<a href="mylistcomment/video/sm13508854" style="color:#393F3F;"><strong class="vinfo_mylist">117</strong></a><br></nobr>
<nobr>宣伝：<a href="http://uad.nicovideo.jp/ads/?vid=sm13508854" style="color:#393F3F;"><strong id="item25_uad_point_number" class="vinfo_uadp">0</strong></a><br></nobr>
</div></td>
</tr>
</table>
	</div>
</td>
<td style="background:url('http://res.nimg.jp/img/common/thumb/split_line.png') no-repeat bottom left; padding-bottom:6px;">
<div style="width:412px; overflow:hidden;">
<p class="font12 thumb_num">

<strong>
2011年02月05日 23:00
</strong> 投稿
</p>
<p class="font16" style="margin:2px 0;"><nobr><a href="watch/sm13508854" class="watch" title="【MMD】らぶ式ミクさんでこっち向いてBaby">【MMD】らぶ式ミクさんでこっち向いてBaby</a></nobr></p>
<p class="vinfo_description" title="初めまして。MMDをダウンロードして、まだ２週間も経っていない新参者です。らぶ式ミクさんに...">初めまして。MMDをダウンロードして、まだ２週間も経っていない新参者です。らぶ式ミクさんに...</p>
</div>
</td>
</tr>
</table>
<!---->
</div>
</div>



<div style="clear:both;">





<div class="thumb_col_1">
<!---->
<table width="624" cellpadding="4" cellspacing="0" summary="sm13598881">
<tr valign="top">
<td><div id="item26" style="display:none;" onMouseover="showOBJ('thumb_uad_msg_sm13598881')" onMouseout="hideOBJ('thumb_uad_msg_sm13598881')">
	<div id="thumb_uad_msg_sm13598881" style="display:none; position:absolute;">
	<p id="item26_uad_comment" class="uad_comment"><span style="color:#666;">-</span></p>
	</div>
</div>
<div id="item26_thumb" class="uad_thumbfrm">
<table cellspacing="0" cellpadding="0">
<tr>
<td onMouseover="showOBJ('thumb_uad_msg_sm13598881')" onMouseout="hideOBJ('thumb_uad_msg_sm13598881')">
<p><a href="watch/sm13598881"><img src="http://tn-skr2.smilevideo.jp/smile?i=13598881" alt="" class="img_std96"></a></p>
<p class="vinfo_length"><span>3:15</span></p>
</td>
<td class="font10" align="right"><div style="width:92px; overflow:hidden; padding-left:4px;"><nobr>再生：<strong class="vinfo_view">51,240</strong><br></nobr>
<nobr>コメ：<strong class="vinfo_res">1,895</strong><br></nobr>
<nobr>マイ：<a href="mylistcomment/video/sm13598881" style="color:#393F3F;"><strong class="vinfo_mylist">5,056</strong></a><br></nobr>
<nobr>宣伝：<a href="http://uad.nicovideo.jp/ads/?vid=sm13598881" style="color:#393F3F;"><strong id="item26_uad_point_number" class="vinfo_uadp">0</strong></a><br></nobr>
</div></td>
</tr>
</table>
	</div>
</td>
<td style="background:url('http://res.nimg.jp/img/common/thumb/split_line.png') no-repeat bottom left; padding-bottom:6px;">
<div style="width:412px; overflow:hidden;">
<p class="font12 thumb_num">

<strong>
2011年02月14日 19:01
</strong> 投稿
</p>
<p class="font16" style="margin:2px 0;"><nobr><a href="watch/sm13598881" class="watch" title="【第6回MMD杯本選】取り外し可能人体">【第6回MMD杯本選】取り外し可能人体</a></nobr></p>
<p class="vinfo_description" title="2/27まさかの受賞！（驚）ありがとうございました！賞名ﾌｲﾀwww運営の皆様お疲れ様でした！">2/27まさかの受賞！（驚）ありがとうございました！賞名ﾌｲﾀwww運営の皆様お疲れ様でした！</p>
</div>
</td>
</tr>
</table>
<!---->
</div>
</div>



<div style="clear:both;">





<div class="thumb_col_1">
<!---->
<table width="624" cellpadding="4" cellspacing="0" summary="sm13731603">
<tr valign="top">
<td><div id="item27" style="display:none;" onMouseover="showOBJ('thumb_uad_msg_sm13731603')" onMouseout="hideOBJ('thumb_uad_msg_sm13731603')">
	<div id="thumb_uad_msg_sm13731603" style="display:none; position:absolute;">
	<p id="item27_uad_comment" class="uad_comment"><span style="color:#666;">-</span></p>
	</div>
</div>
<div id="item27_thumb" class="uad_thumbfrm">
<table cellspacing="0" cellpadding="0">
<tr>
<td onMouseover="showOBJ('thumb_uad_msg_sm13731603')" onMouseout="hideOBJ('thumb_uad_msg_sm13731603')">
<p><a href="watch/sm13731603"><img src="http://tn-skr4.smilevideo.jp/smile?i=13731603" alt="" class="img_std96"></a></p>
<p class="vinfo_length"><span>4:41</span></p>
</td>
<td class="font10" align="right"><div style="width:92px; overflow:hidden; padding-left:4px;"><nobr>再生：<strong class="vinfo_view">1,047</strong><br></nobr>
<nobr>コメ：<strong class="vinfo_res">43</strong><br></nobr>
<nobr>マイ：<a href="mylistcomment/video/sm13731603" style="color:#393F3F;"><strong class="vinfo_mylist">223</strong></a><br></nobr>
<nobr>宣伝：<a href="http://uad.nicovideo.jp/ads/?vid=sm13731603" style="color:#393F3F;"><strong id="item27_uad_point_number" class="vinfo_uadp">0</strong></a><br></nobr>
</div></td>
</tr>
</table>
	</div>
</td>
<td style="background:url('http://res.nimg.jp/img/common/thumb/split_line.png') no-repeat bottom left; padding-bottom:6px;">
<div style="width:412px; overflow:hidden;">
<p class="font12 thumb_num">

<strong>
2011年02月28日 05:02
</strong> 投稿
</p>
<p class="font16" style="margin:2px 0;"><nobr><a href="watch/sm13731603" class="watch" title="【巡音ルカ】浪漫主義【オリジナル】">【巡音ルカ】浪漫主義【オリジナル】</a></nobr></p>
<p class="vinfo_description" title="初めまして。黒田亜津(クロダ アシン)です。 花粉症です。  うた： 巡音ルカ コー...">初めまして。黒田亜津(クロダ アシン)です。 花粉症です。  うた： 巡音ルカ コー...</p>
</div>
</td>
</tr>
</table>
<!---->
</div>
</div>



<div style="clear:both;">





<div class="thumb_col_1">
<!---->
<table width="624" cellpadding="4" cellspacing="0" summary="sm2724221">
<tr valign="top">
<td><div id="item28" style="display:none;" onMouseover="showOBJ('thumb_uad_msg_sm2724221')" onMouseout="hideOBJ('thumb_uad_msg_sm2724221')">
	<div id="thumb_uad_msg_sm2724221" style="display:none; position:absolute;">
	<p id="item28_uad_comment" class="uad_comment"><span style="color:#666;">-</span></p>
	</div>
</div>
<div id="item28_thumb" class="uad_thumbfrm">
<table cellspacing="0" cellpadding="0">
<tr>
<td onMouseover="showOBJ('thumb_uad_msg_sm2724221')" onMouseout="hideOBJ('thumb_uad_msg_sm2724221')">
<p><a href="watch/sm2724221"><img src="http://tn-skr2.smilevideo.jp/smile?i=2724221" alt="" class="img_std96"></a></p>
<p class="vinfo_length"><span>3:58</span></p>
</td>
<td class="font10" align="right"><div style="width:92px; overflow:hidden; padding-left:4px;"><nobr>再生：<strong class="vinfo_view">2,978</strong><br></nobr>
<nobr>コメ：<strong class="vinfo_res">240</strong><br></nobr>
<nobr>マイ：<a href="mylistcomment/video/sm2724221" style="color:#393F3F;"><strong class="vinfo_mylist">65</strong></a><br></nobr>
<nobr>宣伝：<a href="http://uad.nicovideo.jp/ads/?vid=sm2724221" style="color:#393F3F;"><strong id="item28_uad_point_number" class="vinfo_uadp">0</strong></a><br></nobr>
</div></td>
</tr>
</table>
	</div>
</td>
<td style="background:url('http://res.nimg.jp/img/common/thumb/split_line.png') no-repeat bottom left; padding-bottom:6px;">
<div style="width:412px; overflow:hidden;">
<p class="font12 thumb_num">

<strong>
2008年03月21日 09:18
</strong> 投稿
</p>
<p class="font16" style="margin:2px 0;"><nobr><a href="watch/sm2724221" class="watch" title="初音ミクで合唱曲「はじまり」～修正ver.～">初音ミクで合唱曲「はじまり」～修正ver.～</a></nobr></p>
<p class="vinfo_description" title="　前回sm2701958伴奏が聞こえにくかったという声を聞いて、１段階音量を上げました。でもこれだと大きすぎ...">　前回sm2701958伴奏が聞こえにくかったという声を聞いて、１段階音量を上げました。でもこれだと大きすぎ...</p>
</div>
</td>
</tr>
</table>
<!---->
</div>
</div>



<div style="clear:both;">





<div class="thumb_col_1">
<!---->
<table width="624" cellpadding="4" cellspacing="0" summary="sm13739075">
<tr valign="top">
<td><div id="item29" style="display:none;" onMouseover="showOBJ('thumb_uad_msg_sm13739075')" onMouseout="hideOBJ('thumb_uad_msg_sm13739075')">
	<div id="thumb_uad_msg_sm13739075" style="display:none; position:absolute;">
	<p id="item29_uad_comment" class="uad_comment"><span style="color:#666;">-</span></p>
	</div>
</div>
<div id="item29_thumb" class="uad_thumbfrm">
<table cellspacing="0" cellpadding="0">
<tr>
<td onMouseover="showOBJ('thumb_uad_msg_sm13739075')" onMouseout="hideOBJ('thumb_uad_msg_sm13739075')">
<p><a href="watch/sm13739075"><img src="http://tn-skr4.smilevideo.jp/smile?i=13739075" alt="" class="img_std96"></a></p>
<p class="vinfo_length"><span>4:56</span></p>
</td>
<td class="font10" align="right"><div style="width:92px; overflow:hidden; padding-left:4px;"><nobr>再生：<strong class="vinfo_view">177</strong><br></nobr>
<nobr>コメ：<strong class="vinfo_res">19</strong><br></nobr>
<nobr>マイ：<a href="mylistcomment/video/sm13739075" style="color:#393F3F;"><strong class="vinfo_mylist">44</strong></a><br></nobr>
<nobr>宣伝：<a href="http://uad.nicovideo.jp/ads/?vid=sm13739075" style="color:#393F3F;"><strong id="item29_uad_point_number" class="vinfo_uadp">0</strong></a><br></nobr>
</div></td>
</tr>
</table>
	</div>
</td>
<td style="background:url('http://res.nimg.jp/img/common/thumb/split_line.png') no-repeat bottom left; padding-bottom:6px;">
<div style="width:412px; overflow:hidden;">
<p class="font12 thumb_num">

<strong>
2011年02月28日 23:30
</strong> 投稿
<span style="color:#C00;">12時間前</span>
</p>
<p class="font16" style="margin:2px 0;"><nobr><a href="watch/sm13739075" class="watch" title="【KAITO】epilogue【オリジナル】">【KAITO】epilogue【オリジナル】</a></nobr></p>
<p class="vinfo_description" title="&gt;ﾟ))&gt;＜…コンニチ歯。誕生月間スライディング！年末に作ってた曲なので年越し的な新しく何かするとか...">>ﾟ))>＜…コンニチ歯。誕生月間スライディング！年末に作ってた曲なので年越し的な新しく何かするとか...</p>
</div>
</td>
</tr>
</table>
<!---->
</div>
</div>



<div style="clear:both;">





<div class="thumb_col_1">
<!---->
<table width="624" cellpadding="4" cellspacing="0" summary="sm13581709">
<tr valign="top">
<td><div id="item30" style="display:none;" onMouseover="showOBJ('thumb_uad_msg_sm13581709')" onMouseout="hideOBJ('thumb_uad_msg_sm13581709')">
	<div id="thumb_uad_msg_sm13581709" style="display:none; position:absolute;">
	<p id="item30_uad_comment" class="uad_comment"><span style="color:#666;">-</span></p>
	</div>
</div>
<div id="item30_thumb" class="uad_thumbfrm">
<table cellspacing="0" cellpadding="0">
<tr>
<td onMouseover="showOBJ('thumb_uad_msg_sm13581709')" onMouseout="hideOBJ('thumb_uad_msg_sm13581709')">
<p><a href="watch/sm13581709"><img src="http://tn-skr2.smilevideo.jp/smile?i=13581709" alt="" class="img_std96"></a></p>
<p class="vinfo_length"><span>3:10</span></p>
</td>
<td class="font10" align="right"><div style="width:92px; overflow:hidden; padding-left:4px;"><nobr>再生：<strong class="vinfo_view">9,037</strong><br></nobr>
<nobr>コメ：<strong class="vinfo_res">23,762</strong><br></nobr>
<nobr>マイ：<a href="mylistcomment/video/sm13581709" style="color:#393F3F;"><strong class="vinfo_mylist">126</strong></a><br></nobr>
<nobr>宣伝：<a href="http://uad.nicovideo.jp/ads/?vid=sm13581709" style="color:#393F3F;"><strong id="item30_uad_point_number" class="vinfo_uadp">0</strong></a><br></nobr>
</div></td>
</tr>
</table>
	</div>
</td>
<td style="background:url('http://res.nimg.jp/img/common/thumb/split_line.png') no-repeat bottom left; padding-bottom:6px;">
<div style="width:412px; overflow:hidden;">
<p class="font12 thumb_num">

<strong>
2011年02月13日 03:13
</strong> 投稿
</p>
<p class="font16" style="margin:2px 0;"><nobr><a href="watch/sm13581709" class="watch" title="【初音ミク】みくみくみくみ【飛び出すコメント】">【初音ミク】みくみくみくみ【飛び出すコメント】</a></nobr></p>
<p class="vinfo_description" title="コメントが飛び出します。出しすぎると、顔にかかって見えなくなります。全部出ている時は、AA...">コメントが飛び出します。出しすぎると、顔にかかって見えなくなります。全部出ている時は、AA...</p>
</div>
</td>
</tr>
</table>
<!---->
</div>
</div>



<div style="clear:both;">





<div class="thumb_col_1">
<!---->
<table width="624" cellpadding="4" cellspacing="0" summary="nm9877846">
<tr valign="top">
<td><div id="item31" style="display:none;" onMouseover="showOBJ('thumb_uad_msg_nm9877846')" onMouseout="hideOBJ('thumb_uad_msg_nm9877846')">
	<div id="thumb_uad_msg_nm9877846" style="display:none; position:absolute;">
	<p id="item31_uad_comment" class="uad_comment"><span style="color:#666;">-</span></p>
	</div>
</div>
<div id="item31_thumb" class="uad_thumbfrm">
<table cellspacing="0" cellpadding="0">
<tr>
<td onMouseover="showOBJ('thumb_uad_msg_nm9877846')" onMouseout="hideOBJ('thumb_uad_msg_nm9877846')">
<p><a href="watch/nm9877846"><img src="http://tn-skr3.smilevideo.jp/smile?i=9877846" alt="" class="img_std96"></a></p>
<p class="vinfo_length"><span>2:22</span></p>
</td>
<td class="font10" align="right"><div style="width:92px; overflow:hidden; padding-left:4px;"><nobr>再生：<strong class="vinfo_view">30,809</strong><br></nobr>
<nobr>コメ：<strong class="vinfo_res">3,113</strong><br></nobr>
<nobr>マイ：<a href="mylistcomment/video/nm9877846" style="color:#393F3F;"><strong class="vinfo_mylist">1,761</strong></a><br></nobr>
<nobr>宣伝：<a href="http://uad.nicovideo.jp/ads/?vid=nm9877846" style="color:#393F3F;"><strong id="item31_uad_point_number" class="vinfo_uadp">0</strong></a><br></nobr>
</div></td>
</tr>
</table>
	</div>
</td>
<td style="background:url('http://res.nimg.jp/img/common/thumb/split_line.png') no-repeat bottom left; padding-bottom:6px;">
<div style="width:412px; overflow:hidden;">
<p class="font12 thumb_num">

<strong>
2010年03月01日 17:28
</strong> 投稿
</p>
<p class="font16" style="margin:2px 0;"><nobr><a href="watch/nm9877846" class="watch" title="【鏡音リン・レン】ロリンとレン【トークロイド】">【鏡音リン・レン】ロリンとレン【トークロイド】</a></nobr></p>
<p class="vinfo_description" title="炉理心は二次元までで! 　新しいのできました：nm10817455　■ゲーム実況：sm11951728">炉理心は二次元までで! 　新しいのできました：nm10817455　■ゲーム実況：sm11951728</p>
</div>
</td>
</tr>
</table>
<!---->
</div>
</div>



<div style="clear:both;">





<div class="thumb_col_1">
<!---->
<table width="624" cellpadding="4" cellspacing="0" summary="nm13741988">
<tr valign="top">
<td><div id="item32" style="display:none;" onMouseover="showOBJ('thumb_uad_msg_nm13741988')" onMouseout="hideOBJ('thumb_uad_msg_nm13741988')">
	<div id="thumb_uad_msg_nm13741988" style="display:none; position:absolute;">
	<p id="item32_uad_comment" class="uad_comment"><span style="color:#666;">-</span></p>
	</div>
</div>
<div id="item32_thumb" class="uad_thumbfrm">
<table cellspacing="0" cellpadding="0">
<tr>
<td onMouseover="showOBJ('thumb_uad_msg_nm13741988')" onMouseout="hideOBJ('thumb_uad_msg_nm13741988')">
<p><a href="watch/nm13741988"><img src="http://tn-skr1.smilevideo.jp/smile?i=13741988" alt="" class="img_std96"></a></p>
<p class="vinfo_length"><span>3:28</span></p>
</td>
<td class="font10" align="right"><div style="width:92px; overflow:hidden; padding-left:4px;"><nobr>再生：<strong class="vinfo_view">27</strong><br></nobr>
<nobr>コメ：<strong class="vinfo_res">8</strong><br></nobr>
<nobr>マイ：<a href="mylistcomment/video/nm13741988" style="color:#393F3F;"><strong class="vinfo_mylist">9</strong></a><br></nobr>
<nobr>宣伝：<a href="http://uad.nicovideo.jp/ads/?vid=nm13741988" style="color:#393F3F;"><strong id="item32_uad_point_number" class="vinfo_uadp">0</strong></a><br></nobr>
</div></td>
</tr>
</table>
	</div>
</td>
<td style="background:url('http://res.nimg.jp/img/common/thumb/split_line.png') no-repeat bottom left; padding-bottom:6px;">
<div style="width:412px; overflow:hidden;">
<p class="font12 thumb_num">

<strong>
2011年03月01日 06:27
</strong> 投稿
<span style="color:#C00;">5時間前</span>
</p>
<p class="font16" style="margin:2px 0;"><nobr><a href="watch/nm13741988" class="watch" title="【初音ミク】ルービックキューブ-more spinning mix-【オリジナル】">【初音ミク】ルービックキューブ-more spinning mix-【オリジナル】</a></nobr></p>
<p class="vinfo_description" title="真理の箱よ。今君に問う、愛しいワケを。　◆　奇跡的に高校生を終える事が出来ました。てわけでこれから卒...">真理の箱よ。今君に問う、愛しいワケを。　◆　奇跡的に高校生を終える事が出来ました。てわけでこれから卒...</p>
</div>
</td>
</tr>
</table>
<!---->
</div>
</div>

</div><table width="672" cellpadding="4" cellspacing="0">
<tr>
<td><form name="sort"><select name="sort" onChange="jumpMENU('parent',this,0)">
<option value="http://www.nicovideo.jp/tag/VOCALOID" selected>コメントが新しい順</option>
<option value="http://www.nicovideo.jp/tag/VOCALOID?order=a">コメントが古い順</option>
<option value="http://www.nicovideo.jp/tag/VOCALOID?sort=v">再生数が多い順</option>
<option value="http://www.nicovideo.jp/tag/VOCALOID?sort=v&amp;order=a">再生数が少ない順</option>
<option value="http://www.nicovideo.jp/tag/VOCALOID?sort=r">コメント数が多い順</option>
<option value="http://www.nicovideo.jp/tag/VOCALOID?sort=r&amp;order=a">コメント数が少ない順</option>
<option value="http://www.nicovideo.jp/tag/VOCALOID?sort=m">マイリスト数が多い順</option>
<option value="http://www.nicovideo.jp/tag/VOCALOID?sort=m&amp;order=a">マイリスト数が少ない順</option>
<option value="http://www.nicovideo.jp/tag/VOCALOID?sort=f">投稿日時が新しい順</option>
<option value="http://www.nicovideo.jp/tag/VOCALOID?sort=f&amp;order=a">投稿日時が古い順</option>
<option value="http://www.nicovideo.jp/tag/VOCALOID?sort=l">再生時間が長い順</option>
<option value="http://www.nicovideo.jp/tag/VOCALOID?sort=l&amp;order=a">再生時間が短い順</option>
</select></form></td>
<td nowrap><style><!--
.thumb_cols img { width:35px; height:18px; background:url('/img/common/thumb_cols/col_1.png'); border:0;}
.thumb_cols a:link img , .thumb_cols a:visited img { background:url('/img/common/thumb_cols/col_0.png');}
.thumb_cols a:hover img , .thumb_cols a:active img { background:url('/img/common/thumb_cols/col_1.png');}
--></style>

<p class="thumb_cols"><nobr><img src="http://res.nimg.jp/img/x.gif" alt="1列"><a href="http://www.nicovideo.jp/tag/VOCALOID" onclick="Cookie.set('col', '2', 1000*60*60*24*365, '.nicovideo.jp', '/')"><img src="http://res.nimg.jp/img/x.gif" alt="2列" style="background-position:-35px;"></a><a href="http://www.nicovideo.jp/tag/VOCALOID" onclick="Cookie.set('col', '4', 1000*60*60*24*365, '.nicovideo.jp', '/')"><img src="http://res.nimg.jp/img/x.gif" alt="4列" style="background-position:-70px;"></a></nobr></p>

<!--p class="font12" align="right">現在の値＝</p--></td>
<td width="100%" align="right"><table cellpadding="0" cellspacing="4" summary="" class="pager"><tr><td><span class="here">1</span><a href="http://www.nicovideo.jp/tag/VOCALOID?page=2">2</a><a href="http://www.nicovideo.jp/tag/VOCALOID?page=3">3</a><a href="http://www.nicovideo.jp/tag/VOCALOID?page=4">4</a><a href="http://www.nicovideo.jp/tag/VOCALOID?page=2">次へ</a></td></tr></table></td>
</tr>
</table>


<!--↑動画該当あり↑-->

<!--↓1ページ目:静画表示↓-->
<div style="padding:4px;"><p class="dot_2"><img src="http://res.nimg.jp/img/x.gif" alt=""></p></div>
<p class="font12" style="padding:4px;">ニコニコ静画でタグ <strong><span class="search_word">VOCALOID</span> </strong> を含むスライドショーが <strong>27件</strong> 見つかりました！
<a href="http://seiga.nicovideo.jp/search/theme/tag/VOCALOID?sort=theme_update">すべて表示 &gt;&gt;</a></p>
<div id="item33">
<table width="672" cellpadding="4" cellspacing="0" summary="" style="margin:0 0 8px;">
<tr valign="top">
<td>
<p><a href="http://seiga.nicovideo.jp/watch/sg6768"><img src="http://lohas.nicoseiga.jp/thumb/431725s" alt="" class="img_std96"></a></p>
<p class="vinfo_length"><span>200 pic</span></p>
</td>
<td width="100%">
<p class="font12 thumb_num"><strong>10年04月16日 04:14</strong> 投稿</p>
<p class="font16" style="margin:2px 0;"><a href="http://seiga.nicovideo.jp/watch/sg6768" class="watch">男性ボカロだけで!!</a></p>
<p class="font12 thumb_num">
再生：<strong>6,147</strong>&nbsp;
コメ：<strong>300</strong>&nbsp;
マイ：<a href="mylistcomment/seiga/sg6768" style="color:#393F3F;"><strong>62</strong></a>
</p>
<p class="vinfo_last_res">ｗｗｗｗｗｗｗｗｗｗ ｗｗｗ 荒らしコメ無視してく KAITO厨うざすぎ あーがんばっ...</p>
</td>
</tr>
</table>
</div>
<div id="item34">
<table width="672" cellpadding="4" cellspacing="0" summary="" style="margin:0 0 8px;">
<tr valign="top">
<td>
<p><a href="http://seiga.nicovideo.jp/watch/sg3643"><img src="http://lohas.nicoseiga.jp/thumb/269724s" alt="" class="img_std96"></a></p>
<p class="vinfo_length"><span>157 pic</span></p>
</td>
<td width="100%">
<p class="font12 thumb_num"><strong>10年01月24日 00:11</strong> 投稿</p>
<p class="font16" style="margin:2px 0;"><a href="http://seiga.nicovideo.jp/watch/sg3643" class="watch">VOCALOD＋『メガネ』ってあり？</a></p>
<p class="font12 thumb_num">
再生：<strong>8,608</strong>&nbsp;
コメ：<strong>292</strong>&nbsp;
マイ：<a href="mylistcomment/seiga/sg3643" style="color:#393F3F;"><strong>73</strong></a>
</p>
<p class="vinfo_last_res">・・・・・・・・・・ ウォォォォォォォォォ いいぜ ！？ ちょｗｗ グッ！！ いい...</p>
</td>
</tr>
</table>
</div>
<div id="item35">
<table width="672" cellpadding="4" cellspacing="0" summary="" style="margin:0 0 8px;">
<tr valign="top">
<td>
<p><a href="http://seiga.nicovideo.jp/watch/sg13015"><img src="http://lohas.nicoseiga.jp/thumb/738147s" alt="" class="img_std96"></a></p>
<p class="vinfo_length"><span>70 pic</span></p>
</td>
<td width="100%">
<p class="font12 thumb_num"><strong>10年10月31日 16:20</strong> 投稿</p>
<p class="font16" style="margin:2px 0;"><a href="http://seiga.nicovideo.jp/watch/sg13015" class="watch">亞北ネル</a></p>
<p class="font12 thumb_num">
再生：<strong>980</strong>&nbsp;
コメ：<strong>31</strong>&nbsp;
マイ：<a href="mylistcomment/seiga/sg13015" style="color:#393F3F;"><strong>10</strong></a>
</p>
<p class="vinfo_last_res">ネルぅぅぅっぅ！ この二人いいね！ かぁいい ごちゃごちゃうるせー 典型的なツン...</p>
</td>
</tr>
</table>
</div>
<div id="item36">
<table width="672" cellpadding="4" cellspacing="0" summary="" style="margin:0 0 8px;">
<tr valign="top">
<td>
<p><a href="http://seiga.nicovideo.jp/watch/sg5679"><img src="http://lohas.nicoseiga.jp/thumb/381904s" alt="" class="img_std96"></a></p>
<p class="vinfo_length"><span>89 pic</span></p>
</td>
<td width="100%">
<p class="font12 thumb_num"><strong>10年03月19日 02:42</strong> 投稿</p>
<p class="font16" style="margin:2px 0;"><a href="http://seiga.nicovideo.jp/watch/sg5679" class="watch">ボーカロイド全員集合！２</a></p>
<p class="font12 thumb_num">
再生：<strong>11,076</strong>&nbsp;
コメ：<strong>387</strong>&nbsp;
マイ：<a href="mylistcomment/seiga/sg5679" style="color:#393F3F;"><strong>67</strong></a>
</p>
<p class="vinfo_last_res">どうしてこうなったww おい！がくｗｗ うぎゃっ！！ｗｗ 人柱アリスだ とらどら！...</p>
</td>
</tr>
</table>
</div>
<!--↑1ページ目:静画表示↑-->



<!--↑左列↑-->
</div>
<div class="content_312">
<!--↓右列↓-->

<div class="mb8p4">
<p id="web_pc_prime"></p>
</div>

<script type="text/javascript"><!--
	getAds('web_pc_prime');
//--></script>

<div class="mb8p4">
<p><img src="http://res.nimg.jp/img/common/related/pedia_frm_top.png" alt=""></p>
<table width="304" cellpadding="0" cellspacing="0" summary="">
<tr><td><div class="related_pedia_bg">

<div style="padding:4px;">
<p class="font10" style="margin:0 0 4px;">【みんなでつくる百科事典】ニコニコ大百科</p>
<p class="font12">
<strong style="color:#F90;">VOCALOID</strong> に関する大百科の記事：
</p>
</div>

<div id="related_nicopedia_body">
<p class="font12" style="padding:4px;">読み込み中です…<noscript style="color:#F60;"><br>JavaScript を有効にしてください。</noscript></p>
</div>

<div id="related_nicopedia_footer">
<a target="_blank" href="http://dic.nicovideo.jp/a/VOCALOID">続きを表示</a>
</div>

</div></td></tr>
</table>
<p><img src="http://res.nimg.jp/img/common/related/pedia_frm_btm.png" alt=""></p>
</div>

<!--↓記事表示の本文(件数分繰返)↓-->
<textarea style="display:none;" id="related_nicopedia_body_tpl">
<p class="font12" style="padding:4px;">#summary#...</p>
</textarea>
<!--↑記事表示の本文(件事数分繰返)↑-->

<!--↓記事が見つからない＞本文↓-->
<textarea style="display:none;" id="related_nicopedia_no_article_body_tpl">
<p class="font12" style="padding:4px;">関連記事は見つかりませんでした。<br>記事を書いてみませんか？</p>
</textarea>
<!--↑記事が見つからない＞本文↑-->

<!--↓記事が見つからない＞フッター↓-->
<textarea style="display:none;" id="related_nicopedia_no_article_footer_tpl">
<a target="_blank" href="http://dic.nicovideo.jp/p/a/VOCALOID">記事を書く</a>
</textarea>
<!--↑記事が見つからない＞フッター↑-->

<script type="text/javascript" src="http://res.nimg.jp/js/nicopedia.js?20081001" charset="utf-8"></script>
<script type="text/javascript"><!--
var pedia = new Nicopedia("VOCALOID").loadSummary();
pedia.writtenOnly().withArticles(function (articles) {
	var tpl = new Template($F("related_nicopedia_body_tpl"), /(^|.|\r|\n)(#(\w+)#)/);
	var htmls = articles.map(function (article) {
		article.summary = (article.summary || "").escapeHTML();
		article.shortSummary = article.summary.length > 64
			? article.summary.substring(0, 64) + "..." : article.summary;
		article.url = article.getURL();
		return tpl.evaluate(article);
	});
	if (htmls.length == 0) {
		$("related_nicopedia_body").update($F("related_nicopedia_no_article_body_tpl"));
		$("related_nicopedia_footer").update($F("related_nicopedia_no_article_footer_tpl"));
	} else {
		$("related_nicopedia_body").update(htmls.join(""));
	}
	var el = $("related_nicopedia_total");
	if (el) el.update(pedia.total || "0");
});
pedia.execute();
--></script>

<!---->


<div id="web_pc_360"></div>
<textarea style="display:none;" id="web_pc_megatext_tpl">
<p style="margin:0 0 2px;"><a href="#url#" target="_blank"><img src="#image#"></a></p>
<p class="font12"><a href="#url#" target="_blank">#text#</a></p>
</textarea>

<script type="text/javascript"><!--

getAds("web_pc_360", {
	template: function (data) {
		data.text = data.text.replace(/\r?\n/g, "<br>");
		var tpl = new Template($F("web_pc_megatext_tpl"), /(^|.|\r|\n)(#(\w+)#)/);
		return tpl.evaluate(data);
	}
});

--></script>

<div class="mb8p4">
<p><img src="http://res.nimg.jp/img/common/related/chcom_frm_top.png" alt=""></p>
<table width="304" cellpadding="0" cellspacing="0" summary="">
<tr><td><div class="related_chcom_bg">

<!--↓DBに接続できた↓-->
<div style="padding:4px;">
<p class="font10" style="margin:0 0 4px;">
【公式動画を見るなら】ニコニコチャンネル
</p>
<!--↓該当あり↓-->
<p class="font12">
タグ <strong style="color:#393F3F;">VOCALOID</strong> に関するチャンネルが <strong>1件</strong> 見つかりました
</p>
<!--↑該当あり↑-->
</div>

<!--↓該当あり↓-->
<div style="padding:4px;">
<a href="http://ch.nicovideo.jp/channel/ch207"><img alt="下田麻美ちゃんねる" src="http://icon.nimg.jp/channel/ch207.jpg?1268983747" class="related_chcom_img"></a>
	<p class="font12"><strong>09/01/15 13:19</strong> 開設</p>
	<p class="font16"><a href="http://ch.nicovideo.jp/channel/ch207"><strong>下田麻美ちゃんねる</strong></a></p>
	<p class="related_chcom_description">声優・下田麻美のＣＤアルバム『Ｐｒｉｓｍ／鏡音リン・レン feat. 下田麻美』発売連動の特別チャンネル...</p>
	<p class="font10">
	<nobr>動画：<strong>9</strong></nobr>
			</p>
</div>
<div style="padding:4px; clear:both;"><p class="dot_1"><img src="http://res.nimg.jp/img/x.gif" alt=""></p></div>

<p class="font12" style="text-align:center; padding:4px;"><a href="http://ch.nicovideo.jp/search/VOCALOID?mode=t">全ての関連チャンネルを表示</a></p>
<!--↑該当あり↑-->

<!--↑DBに接続できた↑-->

</div></td></tr>
</table>
<p><img src="http://res.nimg.jp/img/common/related/chcom_frm_btm.png" alt=""></p>
</div>

<div class="mb8p4">
<p><img src="http://res.nimg.jp/img/common/related/chcom_frm_top.png" alt=""></p>
<table width="304" cellpadding="0" cellspacing="0" summary="">
<tr><td><div class="related_chcom_bg">

<!--↓DBに接続できた↓-->
<div style="padding:4px;">
<p class="font10" style="margin:0 0 4px;">
【動画や生放送で共有体験】ニコニコミュニティ
</p>
<!--↓該当あり↓-->
<p class="font12">
タグ <strong style="color:#393F3F;">VOCALOID</strong> に関するコミュニティが <strong>1352件</strong> 見つかりました
</p>
<!--↑該当あり↑-->
</div>

<!--↓該当あり↓-->
<div style="padding:4px;">
<a href="http://com.nicovideo.jp/community/co1043657"><img alt="h a l . c a f e ✽ " src="http://icon.nimg.jp/community/co1043657.jpg?1298938080" class="related_chcom_img"></a>
	<p class="font12"><strong>11/02/16 22:12</strong> 開設</p>
	<p class="font16"><a href="http://com.nicovideo.jp/community/co1043657"><strong>h a l . c a f e ✽ </strong></a></p>
	<p class="related_chcom_description">.
【 ✽ about 放 送 説 明 】

ハ ル ン ケ ア 、 略 し て ハ ル と 呼 ん で 下 さ い 。
何 度 ...</p>
	<p class="font10">
	<nobr>動画：<strong>0</strong></nobr>
				<nobr>メンバ：<strong>30</strong></nobr>
		<nobr>レベル：<strong>8</strong></nobr>
			</p>
</div>
<div style="padding:4px; clear:both;"><p class="dot_1"><img src="http://res.nimg.jp/img/x.gif" alt=""></p></div>
<div style="padding:4px;">
<a href="http://com.nicovideo.jp/community/co1059048"><img alt="空飛ぶキリンとジェイクイーズの科白" src="http://icon.nimg.jp/community/co1059048.jpg?1298932558" class="related_chcom_img"></a>
	<p class="font12"><strong>11/03/01 01:41</strong> 開設</p>
	<p class="font16"><a href="http://com.nicovideo.jp/community/co1059048"><strong>空飛ぶキリンとジェイクイーズの科白</strong></a></p>
	<p class="related_chcom_description">
&amp;quot;All the world is stage, and all the men and women are merely players.&amp;quot;

瑠璃色の昼...</p>
	<p class="font10">
	<nobr>動画：<strong>0</strong></nobr>
				<nobr>メンバ：<strong>3</strong></nobr>
		<nobr>レベル：<strong>2</strong></nobr>
			</p>
</div>
<div style="padding:4px; clear:both;"><p class="dot_1"><img src="http://res.nimg.jp/img/x.gif" alt=""></p></div>
<div style="padding:4px;">
<a href="http://com.nicovideo.jp/community/co450691"><img alt="【アンバ】ベルギーからのバナナ王子様です！【FC】" src="http://icon.nimg.jp/community/co450691.jpg?1298927008" class="related_chcom_img"></a>
	<p class="font12"><strong>10/08/29 12:35</strong> 開設</p>
	<p class="font16"><a href="http://com.nicovideo.jp/community/co450691"><strong>【アンバ】ベルギーからのバナナ王子様...</strong></a></p>
	<p class="related_chcom_description">よーいらしゃいませー！ヾ(＠°▽°＠)ﾉ

僕はベルギーからのアンバです！
バナナが大好きですね！ミト...</p>
	<p class="font10">
	<nobr>動画：<strong>23</strong></nobr>
				<nobr>メンバ：<strong>166</strong></nobr>
		<nobr>レベル：<strong>17</strong></nobr>
			</p>
</div>
<div style="padding:4px; clear:both;"><p class="dot_1"><img src="http://res.nimg.jp/img/x.gif" alt=""></p></div>

<p class="font12" style="text-align:center; padding:4px;"><a href="http://com.nicovideo.jp/search/VOCALOID?mode=t">全ての関連コミュニティを表示</a></p>
<!--↑該当あり↑-->

<!--↑DBに接続できた↑-->

</div></td></tr>
</table>
<p><img src="http://res.nimg.jp/img/common/related/chcom_frm_btm.png" alt=""></p>
</div>
	<!---->
				<!---->

<!--↑右列↑-->
</div>


<script type="text/javascript"><!--
var searchInfo = {
	page: 'tag',
	query: q,
	words: q.split(" "),
	total: 130258,
	offset: 1,
	length: 32,
	result: [
{id:"so10852344",title:"【初音ミク】収録曲とコスチュームをちょっとだけ公開！【Project DIVA 2nd】",image:"http://tn-skr1.smilevideo.jp/smile?i=10852344"},
{id:"sm11713594",title:"【GUMI】　会いたい　【オリジナル曲】",image:"http://tn-skr3.smilevideo.jp/smile?i=11713594"},
{id:"sm13732022",title:"【初音ミク】そうかそうか　そう　だったのか【オリジナル】",image:"http://tn-skr3.smilevideo.jp/smile?i=13732022"},
{id:"sm4559156",title:"【がくぽ】ワールドイズマイン～毘沙門天アレンジ～【がくっぽいど】",image:"http://tn-skr1.smilevideo.jp/smile?i=4559156"},
{id:"sm13697158",title:"【oFFENCe】初音ミクにヤンデレを演じさせてみた…【MMD-PV】",image:"http://tn-skr3.smilevideo.jp/smile?i=13697158"},
{id:"sm13636905",title:"【初音ミク】memory【PV付オリジナル】",image:"http://tn-skr2.smilevideo.jp/smile?i=13636905"},
{id:"sm13741173",title:"週刊VOCALOIDランキング　#178",image:"http://tn-skr2.smilevideo.jp/smile?i=13741173"},
{id:"sm8089993",title:"【鏡音リン】炉心融解【オリジナル】 ",image:"http://tn-skr2.smilevideo.jp/smile?i=8089993"},
{id:"sm13664704",title:"【初音ミク】僕をそんな目で見ないで【オリジナル曲手書きＰＶ】",image:"http://tn-skr1.smilevideo.jp/smile?i=13664704"},
{id:"sm12556499",title:"【MMD】ちびぬこレンとKAITOのなんでもない日常",image:"http://tn-skr4.smilevideo.jp/smile?i=12556499"},
{id:"sm12820248",title:"【DIVA2nd】Alice in Musicland【EDIT動画】",image:"http://tn-skr1.smilevideo.jp/smile?i=12820248"},
{id:"sm13722343",title:"Parades ピアノver. - daburu",image:"http://tn-skr4.smilevideo.jp/smile?i=13722343"},
{id:"sm12195657",title:"【初音ミク】カロン【オリジナルPV】",image:"http://tn-skr2.smilevideo.jp/smile?i=12195657"},
{id:"sm13577349",title:"【第6回MMD杯本選】でっかい街、ちっさい僕",image:"http://tn-skr2.smilevideo.jp/smile?i=13577349"},
{id:"sm13386216",title:"【オリジナル曲PV】 パンダヒーロー 【GUMI】",image:"http://tn-skr1.smilevideo.jp/smile?i=13386216"},
{id:"sm13738063",title:"【鏡音リンappend】夢見がちダンスパーティー【オリジナル】",image:"http://tn-skr4.smilevideo.jp/smile?i=13738063"},
{id:"sm8082467",title:"初音ミク　オリジナル曲　「裏表ラバーズ」",image:"http://tn-skr4.smilevideo.jp/smile?i=8082467"},
{id:"sm12526980",title:"【GUMI】 Last Sunset House remix【オリジナル曲PV】",image:"http://tn-skr1.smilevideo.jp/smile?i=12526980"},
{id:"sm11519178",title:"【神威がくぽ・他】ヴェノマニア公の狂気【中世物語風オリジナル】",image:"http://tn-skr3.smilevideo.jp/smile?i=11519178"},
{id:"sm11303956",title:"【吹奏楽】＊ハロー、プラネット。【編曲】",image:"http://tn-skr1.smilevideo.jp/smile?i=11303956"},
{id:"sm7026662",title:"【がくっぽいど】いろは唄【男性目線ver.】",image:"http://tn-skr3.smilevideo.jp/smile?i=7026662"},
{id:"sm13729705",title:"【巡音ルカ/鏡音レン】月明かりのワルツ【オリジナル曲】",image:"http://tn-skr2.smilevideo.jp/smile?i=13729705"},
{id:"sm13715524",title:"【GUMI（40㍍）】 キリトリセン 【オリジナル】",image:"http://tn-skr1.smilevideo.jp/smile?i=13715524"},
{id:"sm13739777",title:"うちのハクにメグメグ☆ファイアーエンドレスナイト踊ってもらった",image:"http://tn-skr2.smilevideo.jp/smile?i=13739777"},
{id:"sm13508854",title:"【MMD】らぶ式ミクさんでこっち向いてBaby",image:"http://tn-skr3.smilevideo.jp/smile?i=13508854"},
{id:"sm13598881",title:"【第6回MMD杯本選】取り外し可能人体",image:"http://tn-skr2.smilevideo.jp/smile?i=13598881"},
{id:"sm13731603",title:"【巡音ルカ】浪漫主義【オリジナル】",image:"http://tn-skr4.smilevideo.jp/smile?i=13731603"},
{id:"sm2724221",title:"初音ミクで合唱曲「はじまり」～修正ver.～",image:"http://tn-skr2.smilevideo.jp/smile?i=2724221"},
{id:"sm13739075",title:"【KAITO】epilogue【オリジナル】",image:"http://tn-skr4.smilevideo.jp/smile?i=13739075"},
{id:"sm13581709",title:"【初音ミク】みくみくみくみ【飛び出すコメント】",image:"http://tn-skr2.smilevideo.jp/smile?i=13581709"},
{id:"nm9877846",title:"【鏡音リン・レン】ロリンとレン【トークロイド】",image:"http://tn-skr3.smilevideo.jp/smile?i=9877846"},
{id:"nm13741988",title:"【初音ミク】ルービックキューブ-more spinning mix-【オリジナル】",image:"http://tn-skr1.smilevideo.jp/smile?i=13741988"}
	]
};

Nico.onReady(function () {
	var uad = new UserAdvertisement();
	searchInfo.result.each(function (item, index) {
		uad.addTarget(item.id, "item" + (index+1));
	});
	uad.load();
});
--></script>		</div>
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
総動画数：<strong style="color:#393F3F;">5,567,682</strong> ／
総再生数：<strong style="color:#393F3F;">23,151,237,852</strong> ／
総コメント数：<strong style="color:#393F3F;">2,974,085,813</strong>
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
