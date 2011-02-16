package Teto::Track;
use Mouse;
use MouseX::Types::URI;
use AnyEvent;
use AnyEvent::Util;
use AnyEvent::HTTP;
use AnyEvent::Handle;
use Coro;
use LWP::UserAgent;
use HTTP::Request::Common;
use UNIVERSAL::require;
use Path::Class;
use File::Temp ();

with 'Teto::Role::Log';

has url => (
    is  => 'rw',
    isa => 'URI',
    required => 1,
    coerce   => 1,
);

has write_cb => (
    is  => 'rw',
    isa => 'CodeRef',
    # required => 1,
);

has user_agent => (
    is  => 'rw',
    isa => 'LWP::UserAgent',
    default => sub { LWP::UserAgent->new }
);

has error => (
    is  => 'rw',
    isa => 'Str',
);

before error => sub {
    my $self = shift;
    $self->log(error => @_);
};

__PACKAGE__->meta->make_immutable;

no Mouse;

sub recv_cv ($) {
    my $cv = shift;
    $cv->cb(rouse_cb);
    rouse_wait;
    return $cv->recv;
}

sub ffmpeg {
    my ($self, $file_or_fh) = @_;
    my %args = (
        '>'  => sub { $self->write($_[0]) if defined $_[0] },
        '2>' => sub { $self->log_coro("ffmpeg: @_") },
        '$$' => \my $pid,
    );
    
    my $filename;
    if (ref $file_or_fh) {
        $filename = '-';
        $args{'<'} = $file_or_fh;
    } else {
        $filename = $file_or_fh;
        utf8::encode $filename if utf8::is_utf8 $filename;
    }

    my @command = (qw(ffmpeg -i), $filename, qw(-ab 192k -ar 44100 -acodec libmp3lame -ac 2 -f mp3 -)); # TODO make configurable
    $self->log(debug => qq(running '@command'));

    my $cmd_cv = run_cmd \@command, %args;
    $self->log(info => qq(ffmpeg pid: $pid));

    my $exit_code = recv_cv $cmd_cv;
    $self->log(debug => "ffmpeg exited with code $exit_code");

    if ($exit_code != 0) {
        $self->error("ffmpeg exited with code $exit_code");
    }
}

sub url_to_fh {
    my ($self, $url, %args) = @_;

    my $cb = delete $args{cb};

    my ($reader, $writer) = portable_pipe;
    my $write_handle = AnyEvent::Handle->new(
        fh => $writer,
        on_error => sub {
             my ($handle, $fatal, $msg) = @_;
             $self->error("AnyEvent::Handle: $msg");
             $handle->destroy;
             # TODO 即座に write を終える
        }
    );

    $self->log(debug => "GET $url");

    my $bytes_wrote = 0;
    http_get(
        $url,
        headers => $self->prepare_headers($url),
        on_header => sub {
            my ($headers) = @_;
            if ($headers->{Status} != 200) {
                $self->error("$url: $headers->{Status} $headers->{Reason}");
                return;
            }
            1;
        },
        on_body => sub {
            my ($content) = @_;
            if (defined $content) {
                $write_handle->push_write($content);
                $bytes_wrote += length $content;
            }
            1;
        },
        sub {
            $write_handle->on_drain(sub { close $_[0]->fh; $_[0]->destroy });
            $self->log(info => "GET $url -> $bytes_wrote bytes");
            $cb && $cb->();
        },
    );

    return $reader;
}

sub write {
    my $self = shift;
    $self->write_cb->(@_);
}

sub prepare_headers {
    my ($self, $url) = @_;

    my %headers = (
        'Referer' => undef,
        'User-Agent' => $self->user_agent->agent,
    );
    $self->user_agent->prepare_request(GET $url)->scan(sub { $headers{$_[0]} = $_[1] });

    return \%headers;
}

# FIXME
sub subclasses {
    my $class = shift;
    return map { $_->require; $_ } qw(Teto::Track::NicoVideo);
}

sub from_url {
    my ($class, $url) = @_;
    foreach my $impl ($class->subclasses) {
        my $args = $impl->buildargs_from_url($url) or next;
        return $impl->new(url => $url, %$args);
    }
}

sub tempfile {
    my $self = shift;
    return File::Temp->new(UNLINK => 0, @_);
}

sub tmpnam {
    my $self = shift;
    return File::Temp::tmpnam(@_);
}

1;
