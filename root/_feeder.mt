? my ($feeder, $control) = @_;
      <h1><? if ($feeder->image) { ?><img src="<?= $feeder->image ?>"> <? } ?><a href="<?= $feeder->url ?>" class="title"><?= $feeder->title || $feeder->url ?></a> <a href="<?= $feeder->url ?>" class="url"><?= eval { $feeder->url->host . $feeder->url->path_query } ?></a></h1>
      <div class="playlist">
        <ol>
?       for (0 .. $#{ $feeder->tracks }) {
?         my $track = $feeder->tracks->[$_];
?=        $_mt->render_file('_track.mt', $track, $_, $control);
?       }
        </ol>
      </div>
