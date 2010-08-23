package Teto::FileCache;
use Any::Moose;
use Any::Moose 'X::Types::Path::Class';

has 'cache_dir', (
    is  => 'rw',
    isa => 'Path::Class::Dir',
    coerce  => 1,
    default => '.cache',
);

has 'readonly', (
    is  => 'rw',
    isa => 'Bool',
    default => 0,
);

__PACKAGE__->meta->make_immutable;

use File::Spec;
use Path::Class qw(file);

sub file_to_read {
    my ($self, $url) = @_;
    $url =~ m<^http://(?:www\.nicovideo\.jp/watch|nico\.ms)/([sn]m\d+)> or return;

    my $video_id = $1;

    if (-d (my $dir = $self->cache_dir->subdir($video_id))) {
        if (my $file = (grep { -f $_ } $dir->children)[0]) {
            return $file;
        }
    }
}

sub fh_to_write {
    my ($self, $url, $meta) = @_;
    $url =~ m<^http://(?:www\.nicovideo\.jp/watch|nico\.ms)/([sn]m\d+)> or return;

    return file(File::Spec->devnull)->openw if $self->readonly;

    my $video_id = $1;

    my $ext = (split '/', $meta->{content_type})[1] || 'flv';
       $ext = 'swf' if $ext =~ /flash/;

    my $filename = "$video_id.$ext";
       $filename = "$meta->{title}.$filename" if length $meta->{title};
       $filename = join '_', File::Spec->splitdir($filename);

    my $file = $self->cache_dir->file($video_id, $filename);
    $file->dir->mkpath;
    return $file->openw;
}

1;
