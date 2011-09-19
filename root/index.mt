? local %_ = @_;
? my $control = $_{control};
<!DOCTYPE html>
<html>
  <head>
    <title>Teto</title>
    <link rel="stylesheet" href="/css/style.css">
    <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.5.1/jquery.min.js"></script>
    <script type="text/javascript">
var Teto = {};
Teto.playlistURL = null;
Teto.selectplaylist = function (url) {
  $.get('/api/playlist', { url: url }).success(
    function (html) {
    Teto.playlistURL = url;
    $('#playlist').html(html);
      $('#select-playlist li').each(function () {
        $(this).attr('data-playlist-url') == url ? $(this).addClass('selected') : $(this).removeClass('selected');
      });
    }
  );
};
Teto.selectTrack = function (index) {
  $.post('/api/track', { playlist: Teto.playlistURL, index: index }).success(
    function (html) {
      $('#playlist').html(html);
    }
  );
};
Teto.addNewplaylist = function () {
  var url = prompt('Enter playlist URL', '');
  if (url) {
    $.post('/api/playlist', { url: url });
  }
};
$(function () {
  $('#select-playlist li').live('click', function () {
    if (this.id == 'add-new-playlist') {
      Teto.addNewplaylist();
    } else {
      Teto.selectplaylist($(this).attr('data-playlist-url'));
    }
  }).live('keypress', function (e) { if (e.keyCode == 13) $(this).click() });

  $('#playlist li.track').live('click', function (e) {
    if (e.target == this) Teto.selectTrack($(this).attr('data-track-index'));
  }).live('keypress', function (e) {
    if (e.target == this && e.keyCode == 13) Teto.selectTrack($(this).attr('data-track-index'));
    });
});

$(function () {
  $('#queue .track span.delete').live('click', function () {
    $.post('/api/delete_track', { i: $(this).parent('li.track').attr('data-track-index') });
  });
});
    </script>
  </head>
  <body>
    <div id="container">

    <h1><a href="/">teto</a><a href="/stream" class="stream-link">stream</a></h1>

    <section id="queue" class="queue">
      <h1>Queue</h1>
      <ul>
? for (0 .. $#{ $control->queue->tracks }) {
?   my $track = $control->queue->tracks->[$_];
?   my $current_track_url = $control->queue->current_track && $control->queue->current_track->url || '';
  <li class="track <?= $_ % 2 ? 'odd' : 'even' ?> <? if ($track->is_system) { ?>system<? } ?> <? if ($track->url eq $current_track_url) { ?>playing<? } ?>" data-track-index="<?= $_ ?>" tabindex="0">
?   if ($track->is_system) {
      <span class="title"><?= $track->title ?></span>
?   } else {
?     if (0 && $track->image) {
      <img src="<?= $track->image ?>">
?     }
?     if (defined $track->title) {
      <span class="title"><?= $track->title ?></span>
?     } else {
      <span class="title not-loaded">(not loaded)</span>
?     }
?   }
    <span class="button delete" tabindex="0">×</span>
  </li>
? }
      </ul>
    </section>

    <nav>
      <ul id="select-playlist">
? my $playlist_url = $control->playlist && $control->playlist->url || '';
? for my $playlist (values %{ Teto->playlists }) {
        <li class="<? if ($playlist->url eq $playlist_url) { ?>selected<? } ?>" tabindex="0" data-playlist-url="<?= $playlist->url ?>"><? if ($playlist->image) { ?><span class="icon-container"><img src="<?= $playlist->image ?>"></span> <? } ?><?= $playlist->title || $playlist->url ?></li>
? }
        <li id="add-new-playlist" tabindex="0">&nbsp;+&nbsp;</li>
      </ul>
    </nav>

    <section id="playlist" class="playlist">
? if (my $playlist = $control->playlist) {
?=  $_mt->render_file('_playlist.mt', $playlist, $control);
? }
    </section>

    </div>
  </body>
</html>
