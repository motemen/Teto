package Teto::Track;
use Mouse;
use MouseX::Types::URI;
use AnyEvent;
use AnyEvent::Util;
use AnyEvent::HTTP;
use AnyEvent::Handle;
use Coro;
use Coro::LWP;
use Coro::AIO;
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

# TODO -> fh?
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

sub recv_cv {
    my ($self, $cv) = @_;
    $cv->cb(Coro::rouse_cb);
    Coro::rouse_wait;
    return $cv->recv;
}

sub run_command {
    my ($self, $command, $args) = @_;

    my $head = $command->[0];

    $args ||= {};
    $args->{'>'}  ||= sub {
        $self->log(debug => "$head: STDOUT: $_[0]") if defined $_[0];
    };
    $args->{'2>'} ||= sub {
        $self->log(debug => "$head: STDERR: $_[0]") if defined $_[0];
    };
    $args->{'$$'} = \my $pid;

    $self->log(debug => qq(running '@$command'));
    my $cmd_cv = run_cmd $command, %{ $args || {} };
    $self->log(debug => "$head: pid=$pid");

    my $exit_code = $self->recv_cv($cmd_cv);
    if ($exit_code != 0) {
        $self->error("$head exited with code $exit_code");
    } else {
        $self->log(debug => "$head exited with code $exit_code");
    }
    return $exit_code;
}

sub ffmpeg {
    my ($self, $file_or_fh) = @_;
    my %args = (
        '>'  => sub { $self->write($_[0]) if defined $_[0] },
        '2>' => sub { $self->log_coro("ffmpeg: @_") },
    );
    
    my $filename;
    if (ref $file_or_fh) {
        $filename = '-';
        $args{'<'} = $file_or_fh;
    } else {
        $filename  = $file_or_fh;
    }

    $self->run_command(
        [ qw(ffmpeg -i), $filename, qw(-ab 192k -ar 44100 -acodec libmp3lame -ac 2 -f mp3 -) ],
        \%args,
    );
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
    return map { local $_ = "Teto::Track::$_"; $_->require; $_ } qw(NicoVideo NicoVideo::nm);
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
    return File::Temp::tempfile(UNLINK => 0, @_);
}

sub temporary_filename {
    my $self   = shift;
    my $suffix = shift;
    my (undef, $filename) = $self->tempfile(OPEN => 0, SUFFIX => $suffix, @_);
    return $filename;
}

sub download_temporary {
    my ($self, $url, $suffix) = @_;
    my $filename = $self->temporary_filename($suffix);
    my $res = $self->user_agent->mirror($url, $filename);
    die $res->message unless $res->is_success;
    return $filename;
}

sub read_file_to_buffer {
    my ($self, $file) = @_;
    my $fh = aio_open $file, IO::AIO::O_RDONLY, 0 or die "$file: $!";
    while (aio_read $fh, undef, 1024 * 1024, my $buf = '', 0) {
        $self->write($buf);
    }
    aio_close $fh;
}

1;
