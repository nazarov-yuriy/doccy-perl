package Doccy::Controller::SubscriberCtl;
use Mojo::Base 'Mojolicious::Controller';

sub all {
    my $self = shift;
    $self->render(json => $self->subscribers->all($self->param('offset'), $self->param('limit')));
}

sub create {
    my $self = shift;
    $self->render(json => $self->stash);
}

1;