package Doccy::Controller::File;
use Mojo::Base 'Mojolicious::Controller';
use Data::Dumper;

sub get_file {
    my $self = shift;
    $self->render(json => $self->stash);
}

1;