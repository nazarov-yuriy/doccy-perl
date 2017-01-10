package Doccy;
use Mojo::Base 'Mojolicious';

sub startup {
    my $self = shift;
    my Mojolicious::Routes $r = $self->routes();
}

1;
