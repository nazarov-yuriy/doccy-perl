package Doccy::Controller::SuggestionCtl;
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

sub get {
    my $self = shift;
    $self->render(json => $self->stash);
}

sub approve {
    my $self = shift;
    $self->render(json => $self->stash);
}

1;