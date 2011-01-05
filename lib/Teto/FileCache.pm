package Teto::FileCache;
use Mouse;
use MouseX::Types::Path::Class;

has cache_dir => (
    is  => 'rw',
    isa => 'Path::Class::Dir',
    coerce  => 1,
    default => '.cache',
);

has readonly => (
    is  => 'rw',
    isa => 'Bool',
    default => 0,
);

has metainfo => (
    is  => 'rw',
    isa => 'YAML::Tiny',
    lazy_build => 1,
);

sub _build_metainfo {
    my $self = shift;
    return YAML::Tiny->read($self->metainfo_file) || YAML::Tiny->new;
}

has metainfo_file => (
    is  => 'rw',
    isa => 'Path::Class::File',
    lazy_build => 1,
);

sub _build_metainfo_file {
    my $self = shift;
    return $self->cache_dir->file('meta.yaml');
}

__PACKAGE__->meta->make_immutable;

use File::Spec;
use File::Util qw(escape_filename);
use Path::Class qw(file);
use YAML::Tiny;

sub file_to_read {
    my ($self, $url) = @_;
    $url =~ m<^http://(?:www\.nicovideo\.jp/watch|nico\.ms)/(sm\d+)> or return;

    my $video_id = $1;

    if (-d (my $dir = $self->cache_dir->subdir($video_id))) {
        if (my $file = (grep { -f $_ } $dir->children)[0]) {
            $self->set_meta($url, last_access => time());
            return $file;
        }
    }
}

sub fh_to_write {
    my ($self, $url, $meta) = @_;

    if ($self->readonly || $url =~ m<^http://(?:www\.nicovideo\.jp/watch|nico\.ms)/(sm\d+)>) {
        return file(File::Spec->devnull)->openw;
    }

    my $video_id = $1;

    my $ext = (split '/', $meta->{content_type})[1] || 'flv';
       $ext = 'swf' if $ext =~ /flash/;

    my $filename = "$video_id.$ext";
       $filename = "$meta->{title}.$filename" if length $meta->{title};
       $filename = escape_filename($filename);

    my $file = $self->cache_dir->file($video_id, $filename);
    $file->dir->mkpath;

    $self->set_meta($url, created => time());

    return $file->openw;
}

sub get_meta {
    my ($self, $url) = @_;

    if (@_ > 2) {
        my $key = shift;
        return $self->metainfo->[0]->{$url}->{$key};
    } else {
        return $self->metainfo->[0]->{$url};
    }
}

sub set_meta {
    my ($self, $url, $key, $value) = @_;
    utf8::encode $value if utf8::is_utf8 $value;
    $self->metainfo->[0]->{$url}->{$key} = $value;
    $self->write_metafile;
}

# TODO Wide character...
sub write_metafile {
    my $self = shift;
    $self->metainfo_file->dir->mkpath;
    $self->metainfo->write($self->metainfo_file);
}

1;
