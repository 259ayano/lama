package Weather::Web::Controller::Tornado;
use Moose;
use namespace::autoclean;
use CGI::Expand qw/expand_hash/;
use Data::Dumper;
use Weather::CSV;

BEGIN { extends 'Catalyst::Controller'; }

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;
    my $csv = Weather::CSV->connect;
	my $params = expand_hash($c->req->params);
	
	my $where = { 'type' => $params->{search}{hint} };
   my @tornado = $csv->tornado($where);
	my @title = qw/type date position fscale damage1 damage2 dead
                   hurt1 alldestroy halfdestroy detail/;

	$c->stash->{th} = \@title;
	$c->stash->{list} = \@tornado;
    $c->stash->{template} = 'tornado.tt';
}

__PACKAGE__->meta->make_immutable;

1;
