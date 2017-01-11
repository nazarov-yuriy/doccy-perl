package Doccy::Controller::FileCtl;
use Mojo::Base 'Mojolicious::Controller';
use Data::Dumper;

sub get_file {
    my $self = shift;
    $self->reply->static('images/800x500.png')
}

1;