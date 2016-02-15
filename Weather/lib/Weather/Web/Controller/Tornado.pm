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
    my $search = $params->{search};
    my $h = $search->{hint};
    my $d = $search->{date} || '';

    my @where = (
	{ $h ? ('type' => { like => "%$h%" }) : (),
	  $d ? ('date' => { like => "$d%"  }) : ()},
	{ $h ? ('position' => { like => "%$h%" }) : (),
	  $d ? ('date' => { like => "$d%" }) : ()},
	{ $h ? ('fscale'  => { like => "%$h%" }) : (),
	  $d ? ('date' => { like => "$d%" }) : ()},
	{ $h ? ('damage1' => { like => "%$h%" }) : (),
	  $d ? ('date' => { like => "$d%" }) : ()},
	{ $h ? ('damage2' => { like => "%$h%" }) : (),
	  $d ? ('date' => { like => "$d%" }) : ()},
	{ $h ? ('dead'    => $h) : (),
	  $d ? ('date' => { like => "$d%" }) : ()},
	{ $h ? ('hurt1'   => $h) : (),
	  $d ? ('date' => { like => "$d%" }) : ()},
	{ $h ? ('alldestroy' => $h) : (),
	  $d ? ('date' => { like => "$d%" }) : ()},
	{ $h ? ('halfdestroy' => $h) : (),
	  $d ? ('date' => { like => "$d%" }) : ()},
	{ $h ? ('detail'  => { like => "%$h%" }) : (),
	  $d ? ('date' => { like => "$d%" }) : ()},
	);

    my @tornado = $csv->tornado(\@where);
    my @title = qw/type date position fscale damage1 damage2 dead
                   hurt1 alldestroy halfdestroy detail/;
    
    my $year_list  = ['',1950..2016];
    my $month_list = ['',1..12];
    my $day_list   = ['',1..31];
    $c->stash->{year_list}  = $year_list;
    $c->stash->{month_list} = $month_list;
    $c->stash->{day_list}   = $day_list;
    $c->stash->{search} = $params->{search};
    $c->stash->{th} = \@title;
    $c->stash->{list} = \@tornado;
    $c->stash->{template} = 'tornado.tt';
}

__PACKAGE__->meta->make_immutable;

1;
