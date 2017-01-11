package Doccy::Model::Base;
use strict;
use warnings FATAL => 'all';
use utf8;

sub TO_JSON {
    my $self = shift;
    return { %$self };
}

1;