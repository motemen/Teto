? my $track = shift;
          <li class="track <?= $_ % 2 ? 'odd' : 'even' ?> <? if (Teto->queue->current_track->url eq $track->url) { ?>playing<? } ?>">
?           if ($track->image) {
              <img src="<?= $track->image ?>">
?           }
?           if (defined $track->title) {
              <span class="title"><?= $track->title ?></span>
?           } else {
              <span class="title not-loaded">(not loaded)</span>
?           }
            <br>
            <a class="url" href="<?= $track->url ?>"><?= $track->url ?></a>
          </li>
