package Doccy;
use Mojo::Base 'Mojolicious';

sub startup {
    my $self = shift;
    my Mojolicious::Routes $r = $self->routes();
    $r->get('/api/documents/count')->to(controller => 'document', action => 'count');
    $r->get('/api/documents')->to(controller => 'document', action => 'all');
    $r->get('/api/documents/:id')->to(controller => 'document', action => 'get');

    $r->get('/api/files/:id')->to(controller => 'file', action => 'get_file');

    $r->get('/api/subscribers')->to(controller => 'subscriber', action => 'all');
    $r->post('/api/subscribers')->to(controller => 'subscriber', action => 'create');

    $r->get('/api/suggestions')->to(controller => 'suggestion', action => 'all');
    $r->post('/api/suggestions')->to(controller => 'suggestion', action => 'create');
    $r->get('/api/suggestions/:id')->to(controller => 'suggestion', action => 'get');
    $r->post('/api/suggestions/:id/approve')->to(controller => 'suggestion', action => 'approve');
}

1;
