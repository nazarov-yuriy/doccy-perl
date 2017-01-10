package Doccy::Controller::Subscriber;
use Mojo::Base 'Mojolicious::Controller';
use Data::Dumper;

sub all {
    my $self = shift;
    $self->render(json => $self->stash);
}

sub create {
    my $self = shift;
    $self->render(json => $self->stash);
}

1;