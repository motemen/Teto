package Teto::Logger;
use Any::Moose;

use Log::Dispatch;
use UNIVERSAL::require;

has 'dispatcher', (
    is  => 'rw',
    isa => 'Log::Dispatch',
    lazy_build => 1,
);

__PACKAGE__->meta->make_immutable;

use Exporter;
our @EXPORT_OK = qw($logger);

our $logger = __PACKAGE__->new;

sub log {
    my ($self, $level, $message) = @_;
    my $pkg = caller;
    $pkg =~ s/^Teto:://;
    $message .= "\n" unless $message =~ /[\n\r]$/;
    $self->dispatcher->log(
        level   => $level,
        message => "[$level] $pkg $message",
    ) if $self->dispatcher;
}

sub _build_dispatcher {
    Log::Dispatch->new;
}

sub add_logger {
    my ($self, $name, $args) = @_;
    my $logger_class = 'Log::Dispatch::' . ucfirst $name;
    $logger_class->require or die $@;
    $self->dispatcher->add(
        $logger_class->new(
            name => $name,
            %{$args || {}},
        )
    );
}

1;
