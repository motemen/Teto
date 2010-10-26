package Teto::Playlist;
use Any::Moose;

has entries => (
    is  => 'rw',
    isa => 'ArrayRef[Teto::Playlist::Entry]',
    default => sub { [] },
);

__PACKAGE__->meta->make_immutable;

use Teto::Playlist::Entry;

sub add_entry {
    my $self = shift;
    my $entry = ref $_[0] eq 'HASH' ? $_[0] : { @_ };
    push @{$self->entries}, Teto::Playlist::Entry->new($entry);
}

1;
