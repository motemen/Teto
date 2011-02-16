package Teto::Role::Log;
use Mouse::Role;
use Data::Dumper;

sub log {
    my ($self, $level, @args) = @_;
    my ($pkg, $filename) = caller;
    $pkg =~ s/^Teto:://;
    $pkg = $filename if $filename !~ /\.pm$/;
    printf STDERR "[%s] %-6s %s - %s\n",
        scalar(localtime), uc $level, $pkg,
        join ' ', map {
            local $Data::Dumper::Indent = 0;
            local $Data::Dumper::Maxdepth = 1;
            local $Data::Dumper::Terse = 1;
            !ref $_ || overload::Method($_, '""') ? "$_" : Data::Dumper::Dumper($_);
        } @args;
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
