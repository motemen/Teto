? my ($track, $index) = @_;
? my $current_track_url = Teto->queue->current_track && Teto->queue->current_track->url || '';
? if ($track) {
  <li class="track <?= $_ % 2 ? 'odd' : 'even' ?> <? if ($track->url eq $current_track_url) { ?>playing<? } ?>" data-track-index="<?= $index ?>" tabindex="0">
?   if ($track->image) {
      <img src="<?= $track->image ?>">
?   }
?   if (defined $track->title) {
      <span class="title"><?= $track->title ?></span>
?   } else {
      <span class="title not-loaded">(not loaded)</span>
?   }
    <br>
    <a class="url" href="<?= $track->url ?>"><?= $track->url ?></a>
    <span class="meta"><?= $track->has_buffer ? $track->buffer_length : '-' ?> bytes</span>
  </li>
? }
