package Teto;
use Any::Moose;

our $VERSION = '0.01';

use Getopt::Long ':config' => qw(pass_through);

with any_moose('X::Getopt::Strict');

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
    );
}

has coro_debug_server_guard => (
    is  => 'rw',
    isa => 'Guard',
);

no Any::Moose;

__PACKAGE__->meta->make_immutable;

use Teto::Server;
use Teto::FileCache;
use Teto::Logger qw($logger);

use AnyEvent;
use Coro;

sub BUILD {
    my $self = shift;

    our $instance = $self;

    if ($self->debug) {
        require Coro::Debug;
        $self->coro_debug_server_guard(
            Coro::Debug->new_unix_server('/tmp/teto_debug')
        );
    }
}

sub start_psgi {
    my $self = shift;

    $logger->add_logger(screen => { min_level => $self->debug ? 'debug' : 'info' });

    foreach (@{ $self->extra_argv || [] }) {
        next unless $_ =~ m(^https?://);
        $self->server->enqueue($_);
    }

    $self->server->queue->start_async;

    return $self->server->to_psgi_app;
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
