? local %_ = @_;
? use Encode;
<!DOCTYPE html>
<html>
  <head>
    <title>Teto</title>
    <link rel="stylesheet" href="/css/style.css">
  </head>
  <body>
    <div id="container">

    <h1><a href="/">teto</a><a href="/stream" class="stream-link">stream</a></h1>

    <div class="playlist">
      <ul>
? for (0 .. $#{ Teto->playlist->playlist }) {
?   my $track = Teto->playlist->playlist->[$_];
        <li class="track <?= $_ % 2 ? 'odd' : 'even' ?>">
          <span class="title"><?= encode_utf8 ($track->title || '') ?></span>
          <a class="url" href="<?= $track->url ?>"><?= $track->url ?></a>
        </li>
? }
      </ul>
    </div>

    </div>
  </body>
</html>
