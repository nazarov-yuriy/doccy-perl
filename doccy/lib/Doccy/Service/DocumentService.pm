package Doccy::Service::DocumentService;
use Mojo::Base '-base';
use Doccy::Model::Document;

has 'pg';

sub all {
    my $self = shift;
    my $offset = shift;
    my $limit = shift;
    my @res;
    my $pg_res = $self->pg->db->query('select * from "DOCCY_DOCUMENT" offset ? limit ?', $offset, $limit);
    while (my $val = $pg_res->hash()) {
        push @res, Doccy::Model::Document->new($val);
    }
    return \@res;
}

sub count {
    my $self = shift;
    return $self->pg->db->query('select count(*) from "DOCCY_DOCUMENT"')->text();
}

sub get {
    my $self = shift;
    my $id = shift;
    return Doccy::Model::Document->new(
        $self->pg->db->query('select * from "DOCCY_DOCUMENT" where "ID" = ?', $id)->hash()
    );
}

1;