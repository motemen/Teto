package Teto;
use strict;
use warnings;

our $VERSION = '0.2';

sub context {
    our $Context ||= Teto::Context->new;
}

package Teto::Context;
use Mouse;

has playlist => (
    is  => 'rw',
    isa => 'Teto::Playlist',
    default => sub { require Teto::Playlist; Teto::Playlist->new },
);

has buffer => (
    is  => 'rw',
    isa => 'Teto::Buffer',
    default => sub { require Teto::Buffer; Teto::Buffer->new },
);

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
