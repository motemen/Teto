package Teto::Tatsumaki::Application;
use strict;
use warnings;
use parent 'Tatsumaki::Application';
use Teto::Tatsumaki::Handler::Index;
use Teto::Tatsumaki::Handler::Stream;
use Teto::Tatsumaki::Handler::Debug;
use Teto::Tatsumaki::Handler::API;
use Path::Class;

sub new {
    my $class = shift;
    my $self = Tatsumaki::Application->new([
        '/'          => 'Teto::Tatsumaki::Handler::Index',
        '/stream'    => 'Teto::Tatsumaki::Handler::Stream',
        '/debug'     => 'Teto::Tatsumaki::Handler::Debug',
        '/api/(\w+)' => 'Teto::Tatsumaki::Handler::API',
    ]);
    $self->template_path(file(__FILE__)->dir->parent->parent->parent->subdir('root').q());
    $self->static_path  (file(__FILE__)->dir->parent->parent->parent->subdir('root').q());
    return $self;
}

1;
