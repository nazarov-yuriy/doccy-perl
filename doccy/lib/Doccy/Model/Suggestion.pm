package Doccy::Model::Suggestion;
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
    if (exists $args->{tags}) {
        if ('SCALAR' eq ref $args->{tags}) {
            utf8::encode($args->{tags});
            $args->{tags} = Mojo::JSON::decode_json( $args->{tags} );
        }
    }

    my $self = {
        id         => 0,
        title      => "Title",
        summary    => "Summary",
        createTs   => strftime("%Y-%m-%d %H:%M:%S.000", localtime),
        url        => "http://doccy/123456",
        email      => "i\@i.i",
        tags       => { },
        documentId => 0,
        preview    => 0,
        %$args
    };
    return bless $self, $class;
}

1;