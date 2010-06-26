? local %_ = @_;
<!DOCTYPE html>
<html>
  <head>
    <title>teto</title>
    <style type="text/css">
#queue li { line-height: 2em }
li .indicator { visibility: hidden }
li.selected .indicator { visibility: visible }
input { font-family: sans-serif; font-size: large; height: 1.5em; padding: 2px 8px }
input[type="submit"] { height: 2em }
img { border: 0; vertical-align: middle; margin: 3px }
textarea.url {
    width: 80%;
    height: 8em;
}
#playlist {
    padding: 0
}
#playlist > li {
    background: #EEE;
    padding: 5px;
    margin-bottom: 10px;
    position: relative;
    list-style: none;
    overflow: hidden;
}

.info { 
    font-size: smaller;
    position: absolute;
    left: 60%;
    top: 10px;
}

.info dt {
    font-weight: bold;
    float: left;
    margin-right: 0.5em;
}
    </style>
  </head>
  <body>
    <h1>teto</h1>
    <p><a href="/stream">stream</a></p>

? if (0) {
    <h2>Playlist</h2>
    <ul id="playlist">
? foreach (reverse @{$_{server}->playlist->entries}) {
    <li>
    <img src="<?= $_->{image_url} ?>"/>
    <?= $_->{title} ?>
    <dl class="info">
      <dt>source</dt><dd><a href="<?= $_->{source_url} ?>"><?= $_->{source_url} ?></a></dd>
      <dt>media</dt> <dd><a href="<?= $_->{url} ?>"><?= $_->{url} ?></a></dd>
    </dl>
    </li>
? }
    </ul>
? }

    <h2>Queue</h2>
    <ul id="queue">
? foreach (0 .. $#{$_{server}->queue->queue}) {
?   my $url = $_{server}->queue->queue->[$_];
?   my $selected = $_ == $_{server}->queue->index;
    <li <? if ($selected) { ?>class="selected"<? } ?>>
      <span class="indicator">&raquo;</span>
      <img src="http://favicon.hatena.ne.jp/?url=<?= $url ?>" width="16" height="16" /><a href="<?= $url ?>"><?= $url ?></a>
    </li>
? }

    <li>
    <form action="/add" method="post">
    <textarea class="url" name="url"></textarea> <input type="submit" name="add" value="add" />
    </form>
    </li>

    </ul>

  </body>
</html>
