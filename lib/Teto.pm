package Teto;
use Any::Moose;

our $VERSION = '0.01';

with any_moose('X::Getopt::Strict');

# --port=9090
has port => (
    is  => 'rw',
    isa => 'Int',
    default => 9090,
    metaclass => 'Getopt',
);

# --readonly
has readonly => (
    is  => 'rw',
    isa => 'Bool',
    default => 0,
    metaclass => 'Getopt',
);

# --cache-dir=.cache
has cache_dir => (
    is  => 'rw',
    isa => 'Str',
    default => '.cache',
    metaclass => 'Getopt',
    cmd_flag  => 'cache-dir',
);

# --debug
has debug => (
    is  => 'rw',
    isa => 'Bool',
    default => 0,
    metaclass => 'Getopt',
);

## Components

has file_cache => (
    is  => 'rw',
    isa => 'Teto::FileCache',
    lazy_build => 1,
);

sub _build_file_cache {
    my $self = shift;
    return Teto::FileCache->new(
        readonly  => $self->readonly,
        cache_dir => $self->cache_dir,
    );
}

has server => (
    is  => 'rw',
    isa => 'Teto::Server',
    lazy_build => 1,
);

sub _build_server {
    my $self = shift;
    return Teto::Server->new(
        file_cache => $self->file_cache,
        port       => $self->port,
    );
}

no Any::Moose;

__PACKAGE__->meta->make_immutable;

use Teto::Server;
use Teto::FileCache;
use Teto::Logger qw($logger);

use AnyEvent;
use Coro;

sub setup {
    my $self = shift;
    $self->server->setup_callbacks;
    $logger->add_logger(screen => { min_level => $self->debug ? 'debug' : 'notice' });
}

sub run {
    my $self = shift;
    $self->setup;

    foreach (@{ $self->extra_argv }) {
        $self->server->enqueue($_);
    }

    # async {
        $self->server->queue->start;
    # };

    AE::cv->wait;
}

1;

__END__

=head1 NAME

Teto - nicovideo audio player

=head1 SYNOPSIS

  use Teto;

=head1 DESCRIPTION

Teto is

=head1 AUTHOR

motemen E<lt>motemen@gmail.comE<gt>

=head1 SEE ALSO

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
