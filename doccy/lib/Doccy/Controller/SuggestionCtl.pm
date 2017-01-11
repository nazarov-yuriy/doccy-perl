package Doccy::Controller::SuggestionCtl;
use Mojo::Base 'Mojolicious::Controller';
use Mojo::JSON;
use utf8;

sub all {
    my $self = shift;
    $self->render(json => $self->suggestions->all($self->param('offset'), $self->param('limit')));
}

sub create {
    my $self = shift;
    #ToDo: create file from $self->req->content->parts->[0]->asset->slurp
    my $json = $self->req->content->parts->[1]->asset->slurp;
    $self->render(json => $self->suggestions->create(
            Mojo::JSON::decode_json($json)
        ));
}

sub get {
    my $self = shift;
    $self->render(json => $self->suggestions->get($self->stash->{id}));
}

sub approve {
    my $self = shift;
    $self->render(json => $self->documents->create(
            $self->suggestions->get($self->param('id'))
        ));
}

1;