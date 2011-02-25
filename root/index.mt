? local %_ = @_;
<!DOCTYPE html>
<html>
  <head>
    <title>Teto</title>
    <link rel="stylesheet" href="/css/style.css">
    <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.5.0/jquery.min.js"></script>
    <script type="text/javascript">
var Teto = {};
Teto.feederURL = null;
Teto.selectFeeder = function (url) {
  $.get('/api/feeder', { url: url }).success(
    function (html) {
    Teto.feederURL = url;
    $('#feeder').html(html);
      $('#select-feeder li').each(function () {
        $(this).attr('data-feeder-url') == url ? $(this).addClass('selected') : $(this).removeClass('selected');
      });
    }
  );
};
Teto.selectTrack = function (index) {
  $.post('/api/track', { feeder: Teto.feederURL, index: index }).success(
    function (html) {
      $('#feeder').html(html);
    }
  );
};
$(function () {
  $('#select-feeder li').live('click', function () {
    Teto.selectFeeder($(this).attr('data-feeder-url'));
  }).live('keypress', function (e) { if (e.keyCode == 13) $(this).click() });
  $('#feeder li.track').live('click', function (e) {
    if (e.target == this) Teto.selectTrack($(this).attr('data-track-index'));
  }).live('keypress', function (e) {
    if (e.target == this && e.keyCode == 13) Teto.selectTrack($(this).attr('data-track-index'));
    });
});
    </script>
  </head>
  <body>
    <div id="container">

    <h1><a href="/">teto</a><a href="/stream" class="stream-link">stream</a></h1>

    <nav>
      <ul id="select-feeder">
? my $feeder_url = Teto->control->feeder && Teto->control->feeder->url || '';
? for my $feeder (values %{ Teto->feeders }) {
        <li class="<? if ($feeder->url eq $feeder_url) { ?>selected<? } ?>" tabindex="0" data-feeder-url="<?= $feeder->url ?>"><? if ($feeder->image) { ?><span class="icon-container"><img src="<?= $feeder->image ?>"></span> <? } ?><?= $feeder->title || $feeder->url ?></li>
? }
      </ul>
    </nav>

    <section id="feeder" class="feeder">
? if (my $feeder = Teto->control->feeder) {
?=  $_mt->render_file('_feeder.mt', $feeder);
? }
    </section>

    <section class="queue">
      <h1>Queue</h1>
      <ol>
? for (0 .. $#{ Teto->queue->queue }) {
?   my $track = Teto->queue->queue->[$_];
?=  $_mt->render_file('_track.mt', $track, $_);
? }
      </ol>
    </section>

    </div>
  </body>
</html>
