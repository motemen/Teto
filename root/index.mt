? local %_ = @_;
<!DOCTYPE html>
<html>
  <head>
    <title>Teto</title>
    <link rel="stylesheet" href="/css/style.css">
  </head>
  <body>
    <div id="container">

    <h1><a href="/">teto</a><a href="/stream" class="stream-link">stream</a></h1>

? for my $feeder (values %{ Teto->feeders }) {
    <section class="feed">
      <h1><? if ($feeder->image) { ?><img src="<?= $feeder->image ?>"> <? } ?><a href="<?= $feeder->url ?>" class="title"><?= $feeder->title || $feeder->url ?></a> <a href="<?= $feeder->url ?>" class="url"><?= eval { $feeder->url->host . $feeder->url->path_query } ?></a></h1>
      <div class="playlist">
        <ol>
?       for (0 .. $#{ $feeder->tracks }) {
?         my $track = $feeder->tracks->[$_];
?=        $_mt->render_file('_track.mt', $track);
?       }
        </ol>
      </div>
    </section>
? }

    <section class="queue">
      <h1>Queue</h1>
      <ol>
? for (0 .. $#{ Teto->queue->queue }) {
?   my $track = Teto->queue->queue->[$_];
?=  $_mt->render_file('_track.mt', $track);
? }
      </ol>
    </section>

    </div>
  </body>
</html>
