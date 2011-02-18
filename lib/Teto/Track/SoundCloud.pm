package Teto::Track::SoundCloud;
use Mouse;

extends 'Teto::Track';

my $NON_USER = qr/^(tags|tracks|people|groups|tour|you|settings|pages|developers|premium|login|followings)$/;
my $NON_MIX  = qr/^(following|groups|follow|tracks|comments|favorites)$/;

override buildargs_from_url => sub {
    my ($class, $url) = @_;
    my ($user, $mix) = $url =~ m<^http://soundcloud\.com/([\w-]+)/([\w-]+)$> or return undef;
    return undef if $user =~ $NON_USER;
    return undef if $mix =~ $NON_MIX;
    return {};
};

override play => sub {
    my $self = shift;
    my $media_url = $self->media_url or return;
    # $self->send_url_to_buffer($media_url);
    my $fh = $self->url_to_fh($media_url);
    $self->send_file_to_buffer($fh);
};

sub _build_media_url {
    my $self = shift;

    my $res = $self->user_agent->get($self->url);
    unless ($res->is_success) {
        $self->error($res->message);
        return;
    }

    if (defined (my $title = $self->extract_title_from_res($res))) {
        $self->title($title);
    }

    my ($media_url) = $res->decoded_content =~ m<"streamUrl":"([^"]+)"> or return;
    return $media_url;
}

sub extract_title_from_res {
    my ($self, $res) = @_;
    my ($title) = $res->decoded_content =~ m#<h1><em>\s*(.+)\s*</em></h1>#;
    return $title;
}

__PACKAGE__->meta->make_immutable;

no Mouse;

1;
