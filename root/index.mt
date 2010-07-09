? local %_ = @_;
? my $u = sub {
?   require Encode;
?   Encode::is_utf8($_[0]) ? Encode::encode_utf8($_[0]) : $_[0];
? };
<!DOCTYPE html>
<html>
  <head>
    <title>teto</title>
    <style type="text/css">
body {
    padding: 0 15%;
    margin: 0;
    background-color: #152D38;
}
h1 {
    font-family: "Lucida Sans Unicode";
    margin-bottom: 1.5em;
}
h1 a {
    text-decoration: none;
}
h2 {
    margin-top: 0.2em;
    font-family: Georgia;
    position: absolute;
    right: 88%;
    color: #385D66;
}
div#container {
    border: 1px solid #FFFFFF;
    border-top: none;
    border-bottom: none;
    background-color: #385D66;
    color: #FFFFFF;
    padding: 1em;
}
div#container a {
    color: #99D487;
}
#queue li {
    line-height: 2em;
}
li .indicator {
    visibility: hidden;
}
li.selected .indicator {
    visibility: visible;
}
input {
    font-family: sans-serif;
    font-size: large;
    height: 1.5em;
    padding: 2px 8px;
}
input[type="submit"] {
    height: 2em;
}
img {
    border: 0;
    vertical-align: middle;
    margin: 3px;
}
textarea.url {
    width: 80%;
    height: 8em;
}
#playlist {
    padding: 0
}
#playlist > li {
    background: #27858D;
    padding: 5px;
    margin-bottom: 10px;
    position: relative;
    list-style: none;
    overflow: hidden;
    color: #EFEFEF;
}
#playlist > li img {
    max-height: 60px;
}

#status {
    font-size: smaller;
}
th {
  background-color: #152D38;
  padding: 0.4em 0.5em;
}
td {
  padding: 0.4em 0.5em;
}

.info { 
    font-size: 90%;
    position: absolute;
    left: 60%;
    top: 10px;
}

.info dt {
    font-weight: bold;
    float: left;
    margin-right: 0.5em;
}

p.more {
    text-align: right;
}

ul#queue {
    font-size: 90%;
    list-style: none;
    padding-left: 0;
}

ul#queue li {
    margin: 0.1em;
}
    </style>
  </head>
  <body>
    <div id="container">

    <h1><a href="/">teto</a><a href="/stream" class="stream-link">stream <img src="/static/speaker-orange.gif"></a></h1>

    <h2>Playlist</h2>
    <ul id="playlist">
? foreach (grep $_, (reverse @{$_{server}->playlist->entries})[0..4]) {
    <li>
    <img src="<?= $_->{image_url} ?>"/>
    <a href="<?= $_->{source_url} ?>"><?= $u->($_->{title}) ?></a>
    <!--
    <dl class="info">
      <dt>media</dt> <dd><a href="<?= $_->{url} ?>"><?= $_->{url} ?></a></dd>
    </dl>
    -->
    </li>
? }
    </ul>
? if (@{$_{server}->playlist->entries} > 5) {
    <p class="more"><a href="#">more</a></p>
? }

    <h2>Queue</h2>
    <ul id="queue">
? foreach (0 .. $#{$_{server}->queue->queue}) {
?   my $entry = $_{server}->queue->queue->[$_];
?   my $url   = ref $entry eq 'HASH' ? $entry->{url}   : $entry;
?   my $title = ref $entry eq 'HASH' ? $entry->{title} : $entry;
?   my $selected = $_ == $_{server}->queue->index;
    <li <? if ($selected) { ?>class="selected"<? } ?>>
      <span class="indicator">&raquo;</span>
      <img src="http://favicon.hatena.ne.jp/?url=<?= $url ?>" width="16" height="16" /><a href="<?= $url ?>"><?= $u->($title) ?></a>
    </li>
? }

    <li>
    <form action="/add" method="post">
    <textarea class="url" name="url"></textarea> <input type="submit" name="add" value="add" />
    </form>
    </li>

    </ul>

    <h2>Status</h2>
    <table id="status">
      <tr>
        <th>buffer_length</th>
        <td><?= $_{server}->buffer_length ?></td>
      </tr>
      <tr>
        <th>bytes_sent</th>
        <td><?= $_{server}->bytes_sent ?></td>
      </tr>
      <tr>
        <th>status</th>
        <td><? require Data::Dumper; ?><code><?= Data::Dumper->new([ $_{server}->status ])->Terse(1)->Dump ?></code></td>
      </tr>
      <tr>
        <th>bytes_timeline</th>
        <td><? require Data::Dumper; ?><code><?= Data::Dumper->new([ $_{server}->bytes_timeline ])->Terse(1)->Dump ?></code></td>
      </tr>
      <tr>
        <th>current_track_number</th>
        <td><?= $_{server}->current_track_number ?></td>
      </tr>
      <tr>
        <th>queue index</th>
        <td><?= $_{server}->queue->index ?></td>
      </tr>
    </table>

    </div>
  </body>
</html>
