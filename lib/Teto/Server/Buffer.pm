package Teto::Server::Buffer;
use Any::Moose;

use constant META_INTERVAL => 16 * 1024;

has buffer => (
    traits  => [ 'String' ],
    is      => 'rw',
    isa     => 'Str',
    default => q(),
    handles => {
        append => 'append',
        length => 'length',
    },
);

has meta_interval => (
    is  => 'rw',
    isa => 'Int',
    default => sub { META_INTERVAL },
);

has meta_data => (
    is  => 'rw',
    isa => 'HashRef',
    default => sub { +{} },
);

use constant {
    BUFFER_SIZE_MAX => 16 * 1024, # 16kb
    BUFFER_SIZE_MIN =>  1 * 1024, #  1kb
};

__PACKAGE__->meta->make_immutable;

use POSIX qw(ceil);

# TODO なんかもっといい API で Coro のコントロールできないか…

sub underruns {
    shift->length < BUFFER_SIZE_MIN;
}

sub overruns {
    shift->length > BUFFER_SIZE_MAX;
}

sub write {
    my $self = shift;
    my $data = join '', @_;

    my $title = $self->meta_data->{title} || '';
    utf8::encode $title if utf8::is_utf8 $title;
    my $meta = qq(StreamTitle='$title';);
    my $len = ceil(length($meta) / 16);
    my $metadata_section = chr($len) . $meta . ("\x00" x (16 * $len - length $meta));

    while (length($data) >= $self->meta_interval) {
        $self->append(substr $data, 0, $self->meta_interval, '');
        $self->append($metadata_section);
        $self->{meta_interval} = META_INTERVAL;
    }

    $self->append($data);
    $self->{meta_interval} -= length $data;
}

sub read {
    my ($self, $len) = @_;
    return substr $self->{buffer}, 0, $len, '';
}

1;
