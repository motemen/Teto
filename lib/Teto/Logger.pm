package Teto::Logger;
use Mouse;

has dispatcher => (
    is  => 'rw',
    isa => 'Log::Dispatch',
    default => sub { Log::Dispatch->new },
);

use Log::Dispatch;
use UNIVERSAL::require;

__PACKAGE__->meta->make_immutable;

use Exporter::Lite;
our @EXPORT_OK = qw($logger);

our $logger = __PACKAGE__->new;

sub log {
    my ($self, $level, $message) = @_;
    my $pkg = caller;
    $pkg =~ s/^Teto:://;
    $message .= "\n" unless $message =~ /[\n\r]$/;
    utf8::encode $message if utf8::is_utf8 $message;
    $self->dispatcher->log(
        level   => $level,
        message => "[$level] $pkg $message",
    ) if $self->dispatcher;
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
