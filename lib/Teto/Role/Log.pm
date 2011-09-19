package Teto::Role::Log;
use Mouse::Role;
use Data::Dumper;
use POSIX qw(strftime);
use Coro::Debug;
use Carp;

my $LOG_LEVEL_TO_NUM = {
    DEBUG   => 9,
    INFO    => 3,
    NOTICE  => 2,
    WARNING => 1,
    ERROR   => 0,
};

sub log_extra_info { '' }

sub log {
    my ($self, $level, @args) = @_;
    my $pkg = ref $self;
    $pkg =~ s/^Teto:://;
    if (my $extra = $self->log_extra_info) {
        $pkg .= " <$extra>";
    }

    my $message = join ' ', map {
        local $Data::Dumper::Indent = 0;
        local $Data::Dumper::Maxdepth = 1;
        local $Data::Dumper::Terse = 1;
        !ref $_ || overload::Method($_, '""') ? "$_" : Data::Dumper::Dumper($_);
    } @args;

    utf8::encode $message if utf8::is_utf8 $message;

    if (defined (my $n = $LOG_LEVEL_TO_NUM->{ uc $level })) {
        Coro::Debug::log $n, $message;
    } else {
        carp qq(Could not convert log level '$level' into Coro::Debug::log level);
    }

    my $full_message = sprintf "[%d %s] %-6s %s - %s\n",
        0+$Coro::current, strftime('%T', localtime()), uc $level, $pkg, $message;

    print STDERR $full_message;
}

sub log_coro {
    my ($self, @args) = @_;
    my ($pkg, $filename) = caller;
    $pkg =~ s/^Teto:://;
    $pkg = $filename if $filename !~ /\.pm$/;
    my $msg = sprintf "%s - %s\n",
        $pkg,
        join ' ', map {
            local $Data::Dumper::Indent = 0;
            local $Data::Dumper::Maxdepth = 1;
            local $Data::Dumper::Terse = 1;
            !ref $_ || overload::Method($_, '""') ? "$_" : Data::Dumper::Dumper($_);
        } @args;
    $msg =~ s/[\r\n]//g;
    $Coro::current->desc($msg);
}

1;
