package Teto;
use Mouse;
use Teto::Queue;
use Teto::Buffer;

our $VERSION = '0.2';

has queue => (
    is  => 'rw',
    isa => 'Teto::Queue',
    default => sub { Teto::Queue->new },
);

has buffer => (
    is  => 'rw',
    isa => 'Teto::Buffer',
    default => sub { Teto::Buffer->new },
);

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
