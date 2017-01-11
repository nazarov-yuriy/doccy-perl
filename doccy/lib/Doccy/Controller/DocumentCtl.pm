package Doccy::Controller::DocumentCtl;
use Mojo::Base 'Mojolicious::Controller';

sub all {
    my $self = shift;
    $self->render(json => $self->documents->all($self->param('offset'), $self->param('limit')));
}

sub count {
    my $self = shift;
    $self->render(json => $self->documents->count());
}

sub get {
    my $self = shift;
    $self->render(json => $self->documents->get($self->stash->{id}));
}

1;
