package Teto::Role::Log;
use Mouse::Role;
use Data::Dumper;
use POSIX qw(strftime);

sub log_extra_info { '' }

sub log {
    my ($self, $level, @args) = @_;
    my $pkg = ref $self;
    $pkg =~ s/^Teto:://;
    if (my $extra = $self->log_extra_info) {
        $pkg .= " <$extra>";
    }
    my $message = sprintf "[%d %s] %-6s %s - %s\n",
        0+$Coro::current, strftime('%T', localtime()), uc $level, $pkg,
        join ' ', map {
            local $Data::Dumper::Indent = 0;
            local $Data::Dumper::Maxdepth = 1;
            local $Data::Dumper::Terse = 1;
            !ref $_ || overload::Method($_, '""') ? "$_" : Data::Dumper::Dumper($_);
        } @args;
    utf8::encode $message if utf8::is_utf8 $message;
    print STDERR $message;
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
