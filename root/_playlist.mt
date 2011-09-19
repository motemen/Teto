? my ($playlist, $control) = @_;

      <h1><? if ($playlist->image) { ?><img src="<?= $playlist->image ?>"> <? } ?><a href="<?= $playlist->url ?>" class="title"><?= $playlist->title || $playlist->url ?></a> <a href="<?= $playlist->url ?>" class="url"><?= eval { $playlist->url->host . $playlist->url->path_query } || '' ?></a></h1>
      <div class="playlist">
        <ol>
?       for (0 .. $#{ $playlist->tracks }) {
?         my $track = $playlist->tracks->[$_];
?=        $_mt->render_file('_track.mt', $track, $_, $control);
?       }
        </ol>
      </div>
