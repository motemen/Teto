package Cache::LRU::Peekable;
use strict;
use warnings;
use parent 'Cache::LRU';

sub peek {
    my ($self, $key) = @_;
    my $value_ref = $self->{_entries}->{$key};
    return undef unless $value_ref;

    # no _update_fifo
    $$value_ref;
}

1;
