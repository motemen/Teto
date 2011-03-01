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
use Coro::Timer ();
use LWP::UserAgent;
use HTTP::Request::Common;
use Class::Load;
use Path::Class;
use File::Temp ();
use Cache::LRU::Peekable;
use Scalar::Util qw(refaddr weaken);

use overload '""' => 'as_string', fallback => 1;

with 'Teto::Role::Log';

has url => (
    is  => 'rw',
    isa => 'URI',
    required => 1,
    coerce   => 1,
);

has media_url => (
    is  => 'rw',
    isa => 'Maybe[Str]', # Maybe[URI]
    coerce => 1,
    lazy_build => 1,
);

has title => (
    is  => 'rw',
    isa => 'Str',
);

has image => (
    is  => 'rw',
    isa => 'Maybe[Str]',
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

has buffer_signal => (
    is  => 'rw',
    isa => 'Coro::Signal',
    default => sub { Coro::Signal->new },
);

before error => sub {
    my $self = shift;
    if (@_) {
        $self->log(error => @_);
        $self->done;
    }
};

### Track status

use constant {
    TRACK_STATUS_STANDBY => 'standby',
    TRACK_STATUS_PLAYING => 'playing',
    TRACK_STATUS_DONE    => 'done',
};

has status => (
    is  => 'rw',
    isa => 'Str',
    default => 'standby',
);

sub is_standby {
    my $self = shift;
    return 1 if not $self->has_buffer;
    return 1 if $self->status eq TRACK_STATUS_STANDBY;
    return 0;
}

sub is_playing {
    my $self = shift;
    return 0 unless $self->status eq TRACK_STATUS_PLAYING;
    return 0 unless $self->has_buffer;
    return 1;
}

sub is_done {
    my $self = shift;
    return 0 unless $self->status eq TRACK_STATUS_DONE;
    return 0 unless $self->has_buffer;
    return 1;
}

sub done {
    my $self = shift;
    $self->status(TRACK_STATUS_DONE);
    # TODO buffer_signal->broadcast?
}

__PACKAGE__->meta->make_immutable;

no Mouse;

### Buffers
# buffers are stored in Cache::LRU as reference, so recently
# unused buffers are automatically purged.
# TODO FIXME currently playing track's buffer should not be purged!!!

our $BufferCache = Cache::LRU::Peekable->new(size => 20);

sub track_id { refaddr $_[0] }

sub buffer_ref {
    my $self = shift;
    return $BufferCache->get($self->track_id) || $BufferCache->set($self->track_id, \(my $s = ''));
}

sub buffer {
    my $self = shift;
    return ${ $self->buffer_ref };
}

sub append_buffer {
    my ($self, $buf) = @_;
    my $ref = $self->buffer_ref;
    $$ref .= $buf;
}

sub buffer_length {
    my $self = shift;
    return length $self->buffer;
}

sub has_buffer {
    my $self = shift;
    return !! $BufferCache->peek($self->track_id);
}

sub peek_buffer_length {
    my $self = shift;
    no warnings 'once';
    local *Cache::LRU::Peekable::get = \&Cache::LRU::Peekable::peek;
    return $self->buffer_length;
}

### Instantiation

our $UrlToInstance;
our $IdToInstance;

sub BUILD {
    my $self = shift;
    weaken($UrlToInstance->{ $self->url } = $self);
    weaken($IdToInstance->{ $self->track_id } = $self);
}

my @subclasses;
sub subclasses {
    my $class = shift;
    return @subclasses if @subclasses;
    file(__FILE__)->dir->subdir('Track')->recurse(
        callback => sub {
            my $pm = shift;
            $pm = $pm->relative(file(__FILE__)->parent->parent);
            $pm =~ s/\.pm$// or return;
            $pm =~ s/\//::/g;
            Class::Load::load_class($pm);
            return unless $pm->meta->get_method('_play');
            push @subclasses, $pm;
        },
    );
    return @subclasses;
}

# below does not create instance
sub of_url {
    my ($class, $url) = @_;
    return $UrlToInstance->{$url};
}

sub of_track_id {
    my ($class, $id) = @_;
    return $IdToInstance->{ $id };
}

sub from_url {
    my ($class, $url, %args) = @_;
    if (my $track = $class->of_url($url)) {
        return $track;
    }
    foreach my $impl ($class->subclasses) {
        my $args = $impl->buildargs_from_url($url) or next;
        return $impl->new(url => $url, %$args, %args);
    }
}

### Subclasses must implement these

sub buildargs_from_url {
    my $class = shift;
    die 'override';
}

sub _play {
    my $self = shift;
    die 'override';
}

###

sub add_error {
    my ($self, $error) = @_;
    $self->log(error => $error);
    $self->{error} = $self->{error} ? "$self->{error}; $error" : $error;
}

sub is_track_url {
    my ($class, $url) = @_;
    foreach my $impl ($class->subclasses) {
        $impl->buildargs_from_url($url) and return 1;
    }
    return 0;
}

sub is_system { 0 }

sub log_extra_info {
    my $self = shift;
    return $self->url->path_query;
}

sub prepare {
    my $self = shift;
    $self->log(debug => 'prepare');
    $self->media_url; # build
}

sub play {
    my $self = shift;

    if ($self->is_playing) {
        $self->log(debug => 'already playing');
        return $self->error ? 0 : 1;
    } elsif ($self->is_done) {
        $self->log(debug => 'already done');
        return $self->error ? 0 : 1;
    }

    $self->log(info => 'start playing');
    $self->status(TRACK_STATUS_PLAYING);
    $self->buffer; # initialize
    $self->_play;

    if ($self->error) {
        $self->done;
        $self->buffer_signal->broadcast;
        return 0;
    }

    return 1;
}

sub write {
    my $self = shift;
    $self->append_buffer($_[0]);
    $self->buffer_signal->broadcast;
}

sub buffer_read_fh {
    my $self = shift;
    open my $fh, '<', \$self->{buffer};
}

### Utility methods

sub recv_cv {
    my ($self, $cv) = @_;
    $cv->cb(Coro::rouse_cb);
    Coro::rouse_wait;
    return $cv->recv;
}

sub sleep {
    my ($self, $n) = @_;
    $self->log(info => "sleep for $n secs");
    Coro::Timer::sleep $n;
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
        $self->add_error("$head exited with code $exit_code");
    } else {
        $self->log(debug => "$head exited with code $exit_code");
    }
    return $exit_code;
}

# transcode file or fh to buffer
sub ffmpeg {
    my ($self, $file_or_fh) = @_;
    my %args = (
        '>'  => unblock_sub { $self->write($_[0]) if defined $_[0] },
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
    $self->done;
    $self->buffer_signal->broadcast;
}

sub url_to_fh {
    my ($self, $url, %args) = @_;

    my $cb = delete $args{cb};

    my ($reader, $writer) = portable_pipe;
    my $write_handle = AnyEvent::Handle->new(
        fh => $writer,
        on_error => sub {
             my ($handle, $fatal, $msg) = @_;
             $self->add_error("AnyEvent::Handle: $msg");
             $handle->destroy;
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
                $self->add_error("$url: $headers->{Status} $headers->{Reason}");
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

sub prepare_headers {
    my ($self, $url) = @_;

    my %headers = (
        'Referer' => undef,
        'User-Agent' => $self->user_agent->agent,
    );
    $self->user_agent->prepare_request(GET $url)->scan(sub { $headers{$_[0]} = $_[1] });

    return \%headers;
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
    unless ($res->is_success) {
        $self->log(error => "mirroring $url to $filename:", $res->code, $res->message);
        return undef;
    }
    return $filename;
}

sub send_file_to_buffer {
    my ($self, $file) = @_;
    my $fh = ref $file ? $file : aio_open $file, IO::AIO::O_RDONLY, 0 or do {
        $self->add_error("aio_open $file: $!");
        return;
    };
    while (aio_read $fh, undef, 1024 * 1024, my $buf = '', 0) {
        $self->write($buf);
    }
    aio_close $fh;
    $self->done;
    $self->buffer_signal->broadcast;
}

sub as_string {
    my $self = shift;
    my $string = "<$self->{url}>";
    $string = $self->title . ' ' . $string if $self->title;
    return $string;
}

1;
