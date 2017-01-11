package Doccy::Service::SubscriberService;
use Mojo::Base '-base';
use Doccy::Model::Subscriber;

has 'pg';

sub all {
    my $self = shift;
    my @res;
    my $pg_res = $self->pg->db->query('select * from "DOCCY_SUBSCRIBER"');
    while (my $val = $pg_res->hash()) {
        push @res, Doccy::Model::Subscriber->new($val);
    }
    return \@res;
}

sub create {

}

1;