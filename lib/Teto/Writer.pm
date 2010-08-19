package Teto::Writer;
use Any::Moose;
use Any::Moose 'X::Types::Path::Class';

has 'server', (
    is  => 'rw',
    isa => 'Teto::Server',
    weak_ref => 1,
);

has 'ua', (
    is  => 'rw',
    isa => 'LWP::UserAgent',
);

has 'cache_dir', (
    is  => 'rw',
    isa => 'Path::Class::Dir',
    coerce  => 1,
    default => '.cache',
);

has 'client', (
    is  => 'rw',
    isa => 'WWW::NicoVideo::Download',
    lazy_build => 1,
);

has 'store_file', (
    is  => 'rw',
    isa => 'Bool',
    default => 1,
);

__PACKAGE__->meta->make_immutable;

use AnyEvent::HTTP;
use AnyEvent::Util;

use Coro::Handle;
use Coro::LWP;

use Teto::Logger qw($logger);

use WWW::NicoVideo::Download;
use HTML::TreeBuilder::XPath;
use HTTP::Request::Common;
use Config::Pit;
use Encode;

sub transcode {
    my ($self, $file_or_fh, $cb) = @_;
    my @args = (
        '>',  $cb,
        '2>', sub {
            $logger->log(debug => "ffmpeg: @_") unless "@_" =~ /configuration:/;
        },
    );
    
    my $file;
    if (ref $file_or_fh) {
        $file = '-';
        push @args, ( '<', $file_or_fh );
    } else {
        $file = $file_or_fh;
        $file = Encode::encode_utf8 $file if Encode::is_utf8 $file;
    }

    my @command = (qw(ffmpeg -i), $file, qw(-ab 192k -acodec libmp3lame -f mp3 -)); # TODO config
    $logger->log(debug => qq(running '@command'));

    return run_cmd \@command, @args;
}

sub write {
    my ($self, $url) = @_;

    $url =~ m<^http://(?:www\.nicovideo\.jp/watch|nico\.ms)/([sn]m\d+)> or return;

    my $video_id = $1;
    Encode::_utf8_off($video_id) if Encode::is_utf8 $video_id;

    # from cache
    if (-d (my $dir = $self->cache_dir->subdir($video_id))) {
        if (my $file = (grep { -f $_ } $dir->children)[0]) {
            my ($title) = $file->basename =~ /^(.+?)\.$video_id.\w+$/; # XXX
            unless (Encode::is_utf8 $title) {
                $title = decode_utf8 $title;
            }

            $self->server->playlist->add_entry(
                title      => $title,
                source_url => $url,
                url        => "file://$file",
                image_url  => 'http://tn-skr1.smilevideo.jp/smile?i=' . do { $video_id =~ /(\d+)/; $1 },
            );

            return $self->transcode("$file", sub {
                my $data = shift;
                return unless defined $data;
                $self->server->update_status(title => $title);
                $self->server->push_buffer($data);
            });
        }
    }

    my $res = $self->client->user_agent->get($url);
    unless ($res->is_success) {
        $logger->log(warn => "$url: " . $res->message);
        if ($res->code == 403) {
            $logger->log(notice => 'Got 403, sleep for 30s');
            sleep 30;
        }
        return;
    }
    
    my $title = $self->extract_title($res);
    my $media_url = eval { $self->client->prepare_download($video_id) };
    if ($@) {
        $logger->log(error => "$@");
        return;
    }

    $self->server->playlist->add_entry(
        title      => $title,
        url        => $media_url,
        source_url => $url,
        image_url  => 'http://tn-skr1.smilevideo.jp/smile?i=' . do { $video_id =~ /(\d+)/; $1 },
    );

    my $fh;
    my ($reader, $writer) = portable_pipe;
    $writer = unblock $writer;

    http_get $media_url, headers => $self->prepare_headers($media_url),
        on_header => sub {
            my ($headers) = @_;

            if ($headers->{Status} != 200) {
                $logger->log(error => "$media_url: $headers->{Status} $headers->{Reason}");
                return;
            }

            my $ext = (split '/', $headers->{'content-type'})[1] || 'flv';
               $ext = 'swf' if $ext =~ /flash/;

            if ($self->store_file) {
                my $file = $self->cache_dir->file($video_id, "$title.$video_id.$ext");
                $logger->log(notice => ">> $file");
                $file->dir->mkpath;
                $fh = $file->openw;
            }
        },
        on_body => sub {
            my ($content, $headers) = @_;
            $writer->print($content);
            $fh->print($content) if $fh;
        },
        sub {
            $writer->close;
            $fh->close if $fh;
            $logger->log(notice => "done $media_url");
        };

    return $self->transcode($reader, sub {
        my $data = shift;

        if (!defined $data) {
            $writer->close;
            $reader->close;
            $fh->close if $fh;
            return;
        }

        $self->server->update_status(title => $title); # TODO
        $self->server->push_buffer($data);
    });
}

sub extract_title {
    my ($self, $res) = @_;

    my $tree = HTML::TreeBuilder::XPath->new_from_content($res->decoded_content);
    return $tree->findvalue('//h1');
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

sub _build_client {
    my $self = shift;

    my $config = pit_get('nicovideo.jp');
    return WWW::NicoVideo::Download->new(
        email    => $config->{username},
        password => $config->{password},
    );
}

1;
