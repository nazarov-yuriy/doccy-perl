package Doccy::Model::Document;
use strict;
use warnings FATAL => 'all';
use utf8;

sub new {
    my $class = shift;
    my $args = shift;
    for my $key (keys %$args) {
        my $val = $args->{$key};
        delete $args->{$key};
        $args->{lc $key} = $val;
    }
    if (exists $args->{tags}) {
        utf8::encode($args->{tags});
        $args->{tags} = Mojo::JSON::decode_json( $args->{tags} );
    }

    my $self = {
        id       => 0,
        title    => "Title",
        summary  => "Summary",
        createTs => "2017-01-11 2:00:00.000",
        url      => "http://doccy/123456",
        tags     => { },
        preview  => 0,
        %$args
    };
    return bless $self, $class;
}

sub TO_JSON {
    my $self = shift;
    return { %$self };
}

1;