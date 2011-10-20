package Teto::Tatsumaki::Application;
use strict;
use warnings;
use parent 'Tatsumaki::Application';
use Teto::Tatsumaki::Handler::Index;
use Teto::Tatsumaki::Handler::Stream;
use Teto::Tatsumaki::Handler::Debug;
use Teto::Tatsumaki::Handler::API;
use Path::Class;
use File::ShareDir qw(dist_dir);
use FindBin;

my $root = eval { dist_dir('Teto') } || dir($FindBin::Bin)->subdir('root').q();

sub new {
    my $class = shift;
    my $self = $class->SUPER::new([
        '/'          => 'Teto::Tatsumaki::Handler::Index',
        '/stream'    => 'Teto::Tatsumaki::Handler::Stream',
        '/debug'     => 'Teto::Tatsumaki::Handler::Debug',
        '/api/(\w+)' => 'Teto::Tatsumaki::Handler::API',
    ]);
    $self->template_path($root);
    $self->static_path  ($root);
    return $self;
}

1;
