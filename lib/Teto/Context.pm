package Teto::Context;
use Mouse;
use Teto::Playlist;
use Teto::Buffer;

has playlist => (
    is  => 'rw',
    isa => 'Teto::Playlist',
    default => sub { Teto::Playlist->new },
);

has buffer => (
    is  => 'rw',
    isa => 'Teto::Buffer',
    default => sub { Teto::Buffer->new },
);

__PACKAGE__->meta->make_immutable;

no Mouse;

1;
