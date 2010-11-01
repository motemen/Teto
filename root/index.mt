? local %_ = @_;
<!DOCTYPE html>
<html>
  <head>
    <title>teto</title>
    <style type="text/css">
body {
    margin: 15px;
    background-color: #262626;
}

h1 {
    margin-top: 0;
    font-family: "Lucida Sans Unicode";
}

h1 a {
    text-decoration: none;
}

h2 {
    font-family: Georgia;
    color: #8F8650;
    clear: both;
}

div#container {
    color: #FFFFFF;
    padding: 10px;
}

a {
    color: #5A7678;
}

a:hover {
    color: #7AA0A3;
}

input {
    font-family: sans-serif;
    font-size: large;
    padding: 0.1em 0.4em;
}

img {
    border: 0;
    vertical-align: middle;
    margin: 3px;
}

textarea {
    width: 100%;
    height: 8em;
    background-color: #E9E9E9;
    border: 1px solid #8F8442;
}

#status {
    font-size: smaller;
}

th {
  background-color: #152D38;
  padding: 0.4em 0.5em;
}

td {
  background-color: #385D66;
  padding: 0.4em 0.5em;
}

ul#feed {
    list-style: none;
    font-size: x-large;
    border: 1px solid #8F8F8F;
    background-color: #101010;
    padding: 0.5em 1em;
}

ul#queue {
    font-size: 90%;
    list-style: none;
    margin: 0;
    padding: 0;
}

ul#queue li {
    margin: 5px;
    width: 156px;
    height: 120px;
    overflow: hidden;
    border: 1px solid #474F45;
    background-color: #101010;
    float: left;
    position: relative;
    text-align: center;
    line-height: 120px;
}

ul#queue li.selected {
    border-color: #DDD;
}

ul#queue li.next {
    background-color: #454746;
}

ul#queue li img {
    vertical-align: middle;
}

ul#queue li span.playing {
    position: absolute;
    top: 0;
    left: 0;
    line-height: 14px;
    background-color: #FFF;
    opacity: 0.8;
}

ul#queue li span.delete {
    position: absolute;
    top: 0;
    left: 0;
    line-height: 14px;
    background-color: #FFF;
    opacity: 0.8;
    display: none;
}

ul#queue li span.delete a {
    color: #333;
    text-decoration: none;
    display: block;
}

ul#queue li:hover span.delete {
    display: inline;
}

ul#queue li .title {
    position: absolute;
    bottom: 0;
    left: 0;
    padding: 0.3em;
    font-size: smaller;
    line-height: 1em;
    background: #333;
    opacity: 0.7;
}

ul#queue li .title a {
    color: #F9F9F9;
    text-decoration: none;
    display: block;
}
    </style>
  </head>
  <body>
    <div id="container">

    <h1><a href="/">teto</a><a href="/stream" class="stream-link">stream <img src="/static/speaker-orange.gif"></a></h1>

    <ul id="feed">
? foreach (@{$_{server}->feeder->feeds}) {
      <li><a href="<?= $_->{url} ?>"><?= $_->{title} || $_->{url} ?></a></li>
? }
    </ul>

    <ul id="queue">
? foreach (0 .. $#{$_{server}->queue->queue}) {
?   my $entry = $_{server}->queue->queue->[$_];
    <li
      <? if ($_ == $_{server}->queue->index) { ?>class="selected"<? } ?>
      <? if ($_ == $_{server}->queue->next_index) { ?>class="next"<? } ?>
    >
?     if ($_ == $_{server}->queue->index) {
        <span class="playing"><img src="/static/speaker-orange.gif" /></span>
?     }
      <span class="delete"><a href="/remove?i=<?= $_ ?>"><img src="/static/delete-page-red.gif" /></a></span>
      <a href="/set_next?i=<?= $_ ?>">
?     if ($entry->url) {
        <img src="<?= $entry->thumbnail ?>" onerror="this.src='http://res.nimg.jp/img/common/video_deleted.jpg'" />
?     } else {
        <img src="/static/add-page-orange.gif" />
?     }
      </a>
      <span class="title">
        <a href="<?= $entry->url ?>" target="_blank">
        <?= do { my $name = $entry->name || ''; utf8::decode $name if !utf8::is_utf8 $name; $name } ?>
        </a>
      </span>
    </li>
? }

    </ul>

    <br style="clear: both" />

    <div>
      <form action="/add" method="post">
      <textarea class="url" name="url"></textarea><br />
      <input type="submit" name="add" value="add" />
      </form>
    </div>

    <!--
    <table id="status">
      <tr>
        <th>buffer-&gt;length</th>
        <td><?= $_{server}->buffer->length ?></td>
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
      <tr>
        <th>next queue index</th>
        <td><?= $_{server}->queue->next_index ?></td>
      </tr>
    </table>
    -->

    </div>
  </body>
</html>
