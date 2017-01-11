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
    my $self = shift;
    my $suggestion = Doccy::Model::Suggestion->new(shift);
    my $sql = 'insert into "DOCCY_SUGGESTION" ("TITLE", "SUMMARY", "CREATE_TS", "URL", "EMAIL", "TAGS", "PREVIEW")'.
        ' values (?, ?, ?, ?, ?, ?::json, ?) returning "ID"';
    return $self->pg->db->query($sql,
        $suggestion->{title},
        $suggestion->{summary},
        $suggestion->{createTs},
        $suggestion->{url},
        $suggestion->{email},
        { json => $suggestion->{tags} },
        $suggestion->{preview},
    )->hash->{id};
}

1;