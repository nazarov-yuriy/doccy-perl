package Doccy::Controller::Document;
use Mojo::Base 'Mojolicious::Controller';
use Data::Dumper;

sub all {
    my $self = shift;
    $self->render(json => $self->stash);
}

sub count {
    my $self = shift;
    $self->render(json => $self->stash);
}

sub get {
    my $self = shift;
    $self->render(json => $self->stash);
}

1;
