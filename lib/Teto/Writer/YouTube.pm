package Teto::Writer::YouTube;
use Any::Moose;

extends 'Teto::Writer';

no Any::Moose;

use Teto::Logger qw($logger);
use WWW::YouTube::Download;

sub write {
    my $self = shift;

    my ($video_id) = $self->url =~ m<^http://www\.youtube\.com/watch\?.*?\bv=([^&]+)> or return;

    my $client = WWW::YouTube::Download->new;
    my $video_url = eval { $client->get_video_url($video_id) } or do {
        $logger->log(error => "get_video_url failed: $@");
        return;
    };
    my $title = $client->get_title($video_id);

    return $self->start_transcoding_url($video_url, { title => $title });
}

1;
