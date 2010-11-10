package Teto::Server::Queue::Entry;
use Any::Moose;
use overload
        '""' => 'stringify',
        fallback => 1;

has url => (
    is  => 'rw',
    isa => 'Str',
);

has code => (
    is  => 'rw',
    isa => 'CodeRef',
);

has name => (
    is  => 'rw',
    isa => 'Str',
);

has icon_url => (
    is  => 'rw',
    isa => 'Str',
);

around BUILDARGS => sub {
    my ($orig, $class, @args) = @_;
    if (@args == 1) {
        my $arg = $args[0];
        if (ref $arg eq 'CODE') {
            @args = ( code => $arg );
        } elsif (!ref $arg) {
            @args = ( url  => $arg );
        }
    }
    return $orig->($class, @args);
};

__PACKAGE__->meta->make_immutable;

sub as_html {
    my $self = shift;
    if (my $url = $self->url) {
        my $name = $self->name || $url;
        return qq#<a href="$url">$name</a>#;
    } else {
        return $self->name || '#CODE';
    }
}

sub thumbnail {
    my $self = shift;
    my $url = $self->url || '';
    if ($url =~ m#\.nicovideo\.jp/watch/sm(\d+)#) {
        return "http://tn-skr1.smilevideo.jp/smile?i=$1";
    } elsif ($url =~ m#\byoutube\.com/watch\?.*?\bv=([^&]+)#) {
        return "http://i.ytimg.com/vi/$1/default.jpg";
    } else {
        return 'about:blank';
    }
}

sub stringify {
    my $self = shift;

    my $string = '(null)';
    if ($self->url) {
        $string = "<$self->{url}>";
    } elsif ($self->code) {
        $string = '#CODE';
    }

    if ($self->name) {
        $string = $self->name . ' ' . $string;
    }

    return $string;
}

1;
