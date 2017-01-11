package Doccy;
use Mojo::Base 'Mojolicious';

use Mojo::Pg;

sub startup {
    my $self = shift;

    $self->helper(pg => sub { state $pg = Mojo::Pg->new('postgresql://root@127.0.0.1/doccy') });
    $self->helper(documents => sub { state $documents = Doccy::Service::DocumentService->new(pg => shift->pg) });

    my Mojolicious::Routes $r = $self->routes();
    $r->get('/')->to(cb => sub {shift->reply->static('index.html')});

    $r->get('/api/documents/count')->to(controller => 'document_ctl', action => 'count');
    $r->get('/api/documents')->to(controller => 'document_ctl', action => 'all');
    $r->get('/api/documents/:id')->to(controller => 'document_ctl', action => 'get');

    $r->get('/api/files/:id')->to(controller => 'file_ctl', action => 'get_file');

    $r->get('/api/subscribers')->to(controller => 'subscriber_ctl', action => 'all');
    $r->post('/api/subscribers')->to(controller => 'subscriber_ctl', action => 'create');

    $r->get('/api/suggestions')->to(controller => 'suggestion_ctl', action => 'all');
    $r->post('/api/suggestions')->to(controller => 'suggestion_ctl', action => 'create');
    $r->get('/api/suggestions/:id')->to(controller => 'suggestion_ctl', action => 'get');
    $r->post('/api/suggestions/:id/approve')->to(controller => 'suggestion_ctl', action => 'approve');
}

1;
