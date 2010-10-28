package Teto::Writer;
use Any::Moose;
use Any::Moose 'X::Types::Path::Class';

# is
# - buffer writer
# - transcoder
# has
# - server
# - nicovideo url
# does
# - get nicovideo media
# - transcode
# - write bytes to buffer

has server => (
    is  => 'rw',
    isa => 'Teto::Server',
    weak_ref => 1,
    handles => [ 'file_cache' ],
);

has url => (
    is  => 'rw',
    isa => 'Str',
    required => 1,
);

has client => (
    is  => 'rw',
    isa => 'WWW::NicoVideo::Download',
    lazy_build => 1,
);

sub _build_client {
    my $self = shift;

    # 共有する
    return our $Client ||= do {
        my $config = pit_get('nicovideo.jp');
        WWW::NicoVideo::Download->new(
            email    => $config->{username},
            password => $config->{password},
        );
    };
}

has wrote => (
    is  => 'rw',
    isa => 'Bool',
    default => 0,
);

has error => (
    is  => 'rw',
    isa => 'Str',
);

__PACKAGE__->meta->make_immutable;

no Any::Moose;

use Teto::Logger qw($logger);

use AnyEvent;
use AnyEvent::HTTP;
use AnyEvent::Util;
use AnyEvent::Handle;

use WWW::NicoVideo::Download;
use HTML::TreeBuilder::XPath;
use HTTP::Request::Common;
use Config::Pit;

sub transcode {
    my ($self, $file_or_fh, $cb) = @_;
    my %args = (
        '>'  => $cb,
        '2>' => sub {
            $logger->log(debug => "ffmpeg: @_") unless "@_" =~ /configuration:/;
        },
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

    my @command = (qw(ffmpeg -i), $filename, qw(-ab 192k -acodec libmp3lame -f mp3 -)); # TODO config
    $logger->log(debug => qq(running '@command'));

    my $cv = AE::cv;

    my $cmd_cv = run_cmd \@command, %args;

    $logger->log(info => qq(ffmpeg pid: $pid));

    $cmd_cv->cb(sub {
        my $exit_code = $_[0]->recv;
        $logger->log(debug => "ffmpeg exited with code $exit_code");

        if ($exit_code != 0) {
            $self->error("ffmpeg exited with code $exit_code");
        }

        $self->wrote(1);

        $cv->send;
    });

    return $cv;
}

sub write {
    my $self = shift;

    $self->url =~ m<^http://(?:www\.nicovideo\.jp/watch|nico\.ms)/([sn]m\d+)> or return;

    my $video_id = $1;
    utf8::downgrade $video_id, 1;

    # from cache
    if (my $file = $self->file_cache->file_to_read($self->url)) {
        my $meta = $self->file_cache->get_meta($file);

        return $self->transcode("$file", sub {
            my $data = shift;
            return unless defined $data;
            $self->server->update_status(title => $meta->{title});
            $self->server->push_buffer($data);
        });
    }

    my $res = $self->client->user_agent->get($self->url);
    unless ($res->is_success) {
        $logger->log(error => "$self->{url}: " . $res->message);
        if ($res->code == 403) {
            $logger->log(notice => 'Got 403, sleep for 30s');
            sleep 30;
        }
        return;
    }
    
    my $title = $self->extract_title($res);
    $logger->log(info => "title: $title");
    my $media_url = eval { $self->client->prepare_download($video_id) };
    if ($@) {
        $logger->log(error => "$@");
        return;
    }

    $self->file_cache->set_meta($self->url, title => $title);

    my $fh;
    my ($reader, $writer) = portable_pipe;
    my $write_handle = AnyEvent::Handle->new(
        fh => $writer,
        on_error => sub {
             my ($hdl, $fatal, $msg) = @_;
             $logger->log(error => "AnyEvent::Handle: $msg");
             $hdl->destroy;
        }
    );

    http_get $media_url, headers => $self->prepare_headers($media_url),
        on_header => sub {
            my ($headers) = @_;

            if ($headers->{Status} != 200) {
                $logger->log(error => "$media_url: $headers->{Status} $headers->{Reason}");
                return;
            }

            $fh = $self->file_cache->fh_to_write(
                $self->url,
                { title => $title, content_type => $headers->{'content-type'} },
            );

            return 1;
        },
        on_body => sub {
            my ($content, $headers) = @_;
            print $fh $content;
            $write_handle->push_write($content);
            return 1;
        },
        sub {
            close $fh;
            $write_handle->on_drain(sub { close $_[0]->fh; $_[0]->destroy });

            $logger->log(notice => "done $media_url");
        };

    return $self->transcode($reader, sub {
        my $data = shift;

        if (!defined $data) {
            $_->close for $reader, $fh;
            return;
        }

        $self->server->update_status(title => $title); # TODO
        $self->server->push_buffer($data);
    });
}

sub extract_title {
    my ($self, $res) = @_;
    my $tree = HTML::TreeBuilder::XPath->new_from_content($res->decoded_content);
    my $title = $tree->findvalue('//h1') || $tree->findvalue('//p[@class="video_title"]');
    $tree->delete;
    return $title;
}

sub prepare_headers {
    my ($self, $url) = @_;

    my %headers = (
        'Referer' => undef,
        'User-Agent' => $self->client->user_agent->agent,
    );
    $self->client->user_agent->prepare_request(GET $url)->scan(sub { $headers{$_[0]} = $_[1] });

    return \%headers;
}

1;
