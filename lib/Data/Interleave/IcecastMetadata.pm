package Data::Interleave::IcecastMetadata;
use Mouse;
use POSIX;

has interval => (
    is  => 'rw',
    isa => 'Int',
    default => 16 * 1024,
);

has pos => (
    is  => 'rw',
    isa => 'Int',
    lazy => 1,
    default => sub { $_[0]->interval },
);

has position => (
    is  => 'rw',
    isa => 'Int',
    default => 0,
);

has metadata => (
    is  => 'rw',
    isa => 'HashRef',
    default => sub { +{} },
);

__PACKAGE__->meta->make_immutable;

no Mouse;

sub interleave {
    my ($self, $data) = @_;

    my $interleaved = '';

    my $title = $self->metadata->{title} || '';
    utf8::encode $title if utf8::is_utf8 $title;
    my $meta = qq(StreamTitle='$title';);
    my $len  = ceil(length($meta) / 16);
    $meta = chr($len) . $meta . ("\x00" x (16 * $len - length $meta));

    while (length($data) >= $self->pos) {
        $interleaved .= substr $data, 0, $self->pos, '';
        $interleaved .= $meta;
        $self->pos($self->interval);
    }
    $interleaved .= $data;
    $self->{pos} -= length $data;

    return $interleaved;
}

1;
