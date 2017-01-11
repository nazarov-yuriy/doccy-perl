package Doccy::Controller::DocumentCtl;
use Mojo::Base 'Mojolicious::Controller';
use Data::Dumper;
use Doccy::Model::Document;
use Doccy::Service::DocumentService;

sub all {
    my $self = shift;
    my $offset = $self->param('offset') || 0;
    my $limit = $self->param('limit') || 20;
    $self->render(json => $self->documents->all($offset, $limit));
}

sub count {
    my $self = shift;
    $self->render(json => $self->documents->count());
}

sub get {
    my $self = shift;
    my $id = $self->stash->{id};
    $self->render(json => $self->documents->get($id));
}

1;
