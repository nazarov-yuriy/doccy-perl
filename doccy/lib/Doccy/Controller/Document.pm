package Doccy::Controller::Document;
use Mojo::Base 'Mojolicious::Controller';
use Data::Dumper;
use Doccy::Model::Document;

sub all {
    my $self = shift;
    my $offset = $self->param('offset') || 0;
    my $limit = $self->param('limit') || 20;
    my @res;
    my $pg_res = $self->pg->db->query('select * from "DOCCY_DOCUMENT" offset ? limit ?', $offset, $limit);
    while (my $val = $pg_res->hash()) {
        push @res, Doccy::Model::Document->new($val);
    }
    $self->render(json => \@res);
}

sub count {
    my $self = shift;
    $self->render(json => $self->pg->db->query('select count(*) from "DOCCY_DOCUMENT"')->text());
}

sub get {
    my $self = shift;
    my $id = $self->stash->{id};
    $self->render(
        json => Doccy::Model::Document->new(
            $self->pg->db->query('select * from "DOCCY_DOCUMENT" where "ID" = ?', $id)->hash()
        ));
}

1;
