package Doccy::Service::SuggestionService;
use Mojo::Base '-base';
use Doccy::Model::Suggestion;

has 'pg';

sub all {
    my $self = shift;
    my $offset = shift || 0;
    my $limit = shift || 20;
    my @res;
    my $pg_res = $self->pg->db->query('select * from "DOCCY_SUGGESTION" offset ? limit ?', $offset, $limit);
    while (my $val = $pg_res->hash()) {
        push @res, Doccy::Model::Suggestion->new($val);
    }
    return \@res;
}

sub get {
    my $self = shift;
    my $id = shift;
    return Doccy::Model::Suggestion->new(
        $self->pg->db->query('select * from "DOCCY_SUGGESTION" where "ID" = ?', $id)->hash()
    );
}

sub create {
    ...;
}

1;