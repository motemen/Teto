? my ($track, $index, $control) = @_;
? my $current_track_url = $control->queue->current_track && $control->queue->current_track->url || '';
? if ($track) {
  <li class="track <?= $_ % 2 ? 'odd' : 'even' ?> <? if ($track->url eq $current_track_url) { ?>playing<? } ?> <? if ($track->is_system) { ?>system<? } ?>" data-track-index="<?= $index ?>" tabindex="0">
?   if ($track->is_system) {
      <span class="title"><?= $track->title ?></span>
?   } else {
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
    <span class="meta"><?= $track->has_buffer ? $track->peek_buffer_length : '-' ?> bytes</span>
    <span class="status"><?= $track->status ?></span>
?   if ($track->error) {
      <span class="error"><?= $track->error ?></span>
?   }
?   }
  </li>
? }
