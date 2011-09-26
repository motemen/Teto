package Teto::Tatsumaki::Handler::API;
use strict;
use warnings;
use parent 'Teto::Tatsumaki::Handler';
use Teto::Playlist;
use Tatsumaki::Error;

sub get {
    my ($self, $command) = @_;
    my $get_command = $self->can("_get_$command")
        or Tatsumaki::Error::HTTP->throw(405);
    $self->$get_command;
}

sub post {
    my ($self, $command) = @_;
    my $post_command = $self->can("_post_$command")
        or Tatsumaki::Error::HTTP->throw(405);
    $self->$post_command;
}

sub _get_playlist {
    my ($self, $playlist) = @_;

    my $control = $self->build_control;
    my $playlist = $playlist || Teto::Playlist->of_url($self->request->param('url')) || $control->playlist;
    $self->render('_playlist.html', { 
        playlist => $playlist,
        control  => $control,
    });
}

sub _post_playlist {
    my $self = shift;
    my $playlist = Teto::Playlist->feed_async($self->request->param('url'));
    $self->_get_playlist;
}

sub _post_delete_track {
    my $self = shift;

    my $control = $self->build_control;
    my $i = $self->request->param('i');
    if ($i > 0) {
        splice @{ $control->queue->tracks }, $i, 1;
    }

    $self->response->code(204);
}

sub _post_play {
    my $self = shift;
    
    my $control = $self->build_control;
    my $playlist = Teto::Playlist->of_url( $self->request->param('playlist') );
    if ($playlist) {
        $control->set_playlist($playlist);
    }

    $self->_get_playlist($playlist);
}

1;
