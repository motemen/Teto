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
      <h1><? if ($feeder->image) { ?><img src="<?= $feeder->image ?>"> <? } ?><a href="<?= $feeder->url ?>" class="title"><?= $feeder->title || $feeder->url ?></a> <a href="<?= $feeder->url ?>" class="url"><?= $feeder->url->host . $feeder->url->path ?></a></h1>
      <div class="playlist">
        <ol>
?       for (0 .. $#{ $feeder->tracks }) {
?         my $track = $feeder->tracks->[$_];
          <li class="track <?= $_ % 2 ? 'odd' : 'even' ?>">
?           if ($track->image) {
              <img src="<?= $track->image ?>">
?           }
            <span class="title"><?= $track->title || '' ?></span>
            <a class="url" href="<?= $track->url ?>"><?= $track->url ?></a>
          </li>
?       }
        </ol>
      </div>
    </section>
? }

    <div class="playlist">
      <ol>
? for (0 .. $#{ Teto->playlist->playlist }) {
?   my $track = Teto->playlist->playlist->[$_];
        <li class="track <?= $_ % 2 ? 'odd' : 'even' ?>">
          <span class="title"><?= ($track->title || '') ?></span>
          <a class="url" href="<?= $track->url ?>"><?= $track->url ?></a>
        </li>
? }
      </ol>
    </div>

    </div>
  </body>
</html>
