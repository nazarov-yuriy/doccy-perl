package Doccy::Model::Subscriber;
use strict;
use warnings FATAL => 'all';
use utf8;
use parent 'Doccy::Model::Base';

sub new {
    my $class = shift;
    my $args = shift;
    for my $key (keys %$args) {
        my $val = $args->{$key};
        delete $args->{$key};
        $args->{lc $key} = $val;
    }

    my $self = {
        id       => 0,
        email    => "i\@i.i",
        createTs => "2017-01-11 2:00:00.000",
        %$args
    };
    return bless $self, $class;
}

1;