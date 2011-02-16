package Teto;
use strict;
use warnings;

our $VERSION = '0.2';

sub context {
    require Teto::Context;
    our $Context ||= Teto::Context->new;
}

for my $method qw(playlist buffer) {
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
