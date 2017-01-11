package Doccy::Controller::SuggestionCtl;
use Mojo::Base 'Mojolicious::Controller';

sub all {
    my $self = shift;
    $self->render(json => $self->suggestions->all($self->param('offset'), $self->param('limit')));
}

sub create {
    my $self = shift;
    $self->render(json => $self->stash);
}

sub get {
    my $self = shift;
    $self->render(json => $self->suggestions->get($self->stash->{id}));
}

sub approve {
    my $self = shift;
    $self->render(json => $self->stash);
}

1;