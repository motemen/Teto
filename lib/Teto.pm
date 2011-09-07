package Teto;
use strict;
use warnings;

our $VERSION = '0.2';

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

use constant URL_SCRATCH => 'teto:scrath';

has buffer => (
    is  => 'rw',
    isa => 'Teto::Buffer',
    lazy_build => 1,
);

has feeders => (
    is  => 'rw',
    isa => 'HashRef[Teto::Feeder]',
    default => sub {
        require Teto::Feeder;
        return +{
            URL_SCRATCH() => Teto::Feeder->new(url => URL_SCRATCH, title => '*scratch*'),
        };
    },
);

has server => (
    is  => 'rw',
    isa => 'Teto::Server',
    lazy_build => 1,
);

sub _build_buffer {
    my $self = shift;
    require Teto::Buffer;
    return Teto::Buffer->new;
}

sub _build_server {
    my $self = shift;
    require Teto::Server;
    return Teto::Server->new;
}

sub _build_control {
    my $self = shift;
    require Teto::Control;
    return Teto::Control->new(buffer => $self->buffer);
}

sub feed_url {
    my ($self, $url) = @_;

    require Teto::Feeder;
    require Teto::Track;

    if (Teto::Track->is_track_url($url)) {
        my $feeder = $self->feeders->{+URL_SCRATCH};
        async { $feeder->push_track_url($url); $feeder->signal->broadcast };
        return $feeder;
    } else {
        my $feeder = Teto::Feeder->new(url => $url);
        async { $feeder->feed };
        return $self->feeders->{ Teto::Feeder->uri_canonical($url) } ||= $feeder;
    }
}

__PACKAGE__->meta->make_immutable;

package Teto;

for my $method (Teto::Context->meta->get_attribute_list) {
    no strict 'refs';
    *$method = sub { shift->context->$method };
}

sub feed_url {
    my $self = shift;
    $self->context->feed_url(@_);
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
