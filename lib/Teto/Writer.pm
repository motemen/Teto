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

__PACKAGE__->meta->make_immutable;

use AnyEvent::HTTP;
use AnyEvent::Util;

use Teto::Logger qw($logger);

use WWW::NicoVideo::Download;
use HTML::TreeBuilder::XPath;
use HTTP::Request::Common;
use Config::Pit;
use Encode;

sub transcode {
    my ($self, $file, $cb) = @_;
    $file = Encode::encode_utf8 $file if Encode::is_utf8 $file;
    my @command = (qw(ffmpeg -i), $file, qw(-ab 192k -acodec libmp3lame -f mp3 -)); # TODO config
    $logger->log(debug => qq(running '@command'));
    run_cmd \@command, '>', $cb, '2>', sub { $logger->log(debug => "ffmpeg: @_") };
}

sub write {
    my ($self, $url) = @_;

    $url =~ m<^http://www\.nicovideo\.jp/watch/(s\w+\d+)> or return;

    my $video_id = $1;
    Encode::_utf8_off($video_id) if Encode::is_utf8 $video_id;

    # from cache
    if (-d (my $dir = $self->cache_dir->subdir($video_id))) {
        if (my $file = (grep { -f $_ } $dir->children)[0]) {
            my ($title) = $file->basename =~ /^(.+?)\.$video_id.\w+$/; # XXX

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

    my $config = pit_get('nicovideo.jp');
    my $client = WWW::NicoVideo::Download->new(
        email    => $config->{username},
        password => $config->{password},
    );

    # share ua
    if ($self->ua) {
        $client->user_agent($self->ua);
    } else {
        $self->ua($client->user_agent);
        $self->ua->show_progress(1);
    }

    my $res = $client->user_agent->get($url); # TODO AnyEvent 化…
    unless ($res->is_success) {
        $logger->log(info => "$url: " . $res->message);
        if ($res->code == 403) {
            # XXX そもそもこれが出ないようにするべき
            $logger->log(notice => 'Got 403, sleep 30s');
            sleep 30;
        }
        my $cv = AE::cv;
        $cv->send;
        return $cv;
    }

    my $tree  = HTML::TreeBuilder::XPath->new_from_content($res->decoded_content);
    my $title = $tree->findvalue('//h1');

    my $media_url = $client->prepare_download($video_id);
    my $media_res = $client->user_agent->head($media_url);
    my $ext = (split '/', $media_res->header('Content-Type'))[1] || 'flv';
    $ext = 'swf' if $ext =~ /flash/;

    $self->server->playlist->add_entry(
        title      => $title,
        url        => $media_url,
        source_url => $url,
        image_url  => 'http://tn-skr1.smilevideo.jp/smile?i=' . do { $video_id =~ /(\d+)/; $1 },
    );

    my $req = GET $media_url;
    $client->user_agent->cookie_jar->add_cookie_header($req);

    my %headers;
    $headers{'Referer'} = undef;
    $headers{'User-Agent'} = $client->user_agent->agent;
    $req->headers->scan(sub { $headers{$_[0]} = $_[1] });

    my $file = $self->cache_dir->file($video_id, "$title.$video_id.$ext");
    $logger->log(info => ">> $file");

    $file->dir->mkpath;
    my $fh = $file->openw;

    my $cv = AE::cv;
    http_get $media_url, headers => \%headers, sub {
        my ($data, $headers) = @_;
        if ($headers->{Status} =~ /^2/) {
            $fh->print($data);
            $fh->close;
            my $transcode_cv = $self->transcode("$file", sub {
                my $data = shift;
                return unless defined $data;
                $self->server->update_status(title => $title); # TODO
                $self->server->push_buffer($data);
            });
            $transcode_cv->cb(sub { $cv->send });
        }
    };

    return $cv;
}

1;
