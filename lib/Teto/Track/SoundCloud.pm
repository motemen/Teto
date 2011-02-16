package Teto::Track::SoundCloud;
use Mouse;

extends 'Teto::Track';

my $NON_USER = qr/^(tags|tracks|people|groups|tour|you|settings|pages|developers|premium|login)$/;
my $NON_MIX  = qr/^(following|groups|follow)$/;

override buildargs_from_url => sub {
    my ($class, $url) = @_;
    my ($user, $mix) = $url =~ m<^http://soundcloud\.com/([\w-]+)/([\w-]+)$> or return undef;
    return undef if $user =~ $NON_USER;
    return undef if $mix =~ $NON_MIX;
    return {};
};

override play => sub {
    my $self = shift;

    my $res = $self->user_agent->get($self->url);
    unless ($res->is_success) {
        $self->error($res->message);
        return;
    }

    my ($media_url) = $res->decoded_content =~ m<"streamUrl":"([^"]+)"> or return;

    # $self->send_url_to_buffer($media_url);
    my $fh = $self->url_to_fh($media_url);
    $self->read_file_to_buffer($fh);
};

__PACKAGE__->meta->make_immutable;

no Mouse;

1;
