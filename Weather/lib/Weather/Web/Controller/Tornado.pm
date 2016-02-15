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
    my @tornado = $csv->tornado();
    warn Dumper \@tornado;
    $c->stash->{template} = 'tornado.tt';
}

__PACKAGE__->meta->make_immutable;

1;
