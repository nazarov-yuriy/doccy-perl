package Doccy::Model::Subscriber;
use strict;
use warnings FATAL => 'all';
use utf8;
use parent 'Doccy::Model::Base';
use POSIX;

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
        createTs => strftime("%Y-%m-%d %H:%M:%S.000", localtime),
        %$args
    };
    return bless $self, $class;
}

1;