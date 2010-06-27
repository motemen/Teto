package Teto::Playlist::Entry;
use Any::Moose;

has 'title', (
    is  => 'rw',
    isa => 'Maybe[Str]',
);

has 'url', (
    is  => 'rw',
    isa => 'Maybe[Str]', # XXX URI
);

has 'source_url', (
    is  => 'rw',
    isa => 'Maybe[Str]',
);

has 'image_url', (
    is  => 'rw',
    isa => 'Maybe[Str]',
);

__PACKAGE__->meta->make_immutable;

use overload
    '""' => 'stringify',
    fallback => 1;

sub stringify { "$_[0]->{title} <$_[0]->{url}> from $_[0]->{source_url}" }

1;
