package Teto;
use strict;
use warnings;

our $VERSION = '0.31';

sub context {
    our $Context ||= Teto::Context->new;
}

sub reload {
    require Module::Reload;
    Module::Reload->check;
}

package Teto::Context;
use Mouse;
use Coro;

has playlists => (
    is  => 'rw',
    isa => 'HashRef[Teto::Playlist]',
    default => sub {
        require Teto::Playlist;
        return  Teto::Playlist->all;
    },
);

with 'Teto::Role::Log';

sub _build_buffer {
    my $self = shift;
    require Teto::Buffer;
    return Teto::Buffer->new;
}

__PACKAGE__->meta->make_immutable;

package Teto;

for my $method (Teto::Context->meta->get_attribute_list) {
    no strict 'refs';
    *$method = sub { shift->context->$method };
}

1;

__END__

=head1 NAME

Teto - nicovideo audio streaming server

=head1 SYNOPSIS

  ./teto [playlist_url]

=head1 DESCRIPTION

Teto is a nicovideo audio streaming server.

=head1 AUTHOR

motemen E<lt>motemen@gmail.comE<gt>

=head1 SEE ALSO

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
