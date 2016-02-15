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
    my $hint = $search->{hint};
    my $year  = $search->{year};
    my $month = sprintf("%02d",$search->{month});
    my $day   = sprintf("%02d",$search->{day});
    my $ymd  = $year."/".$month."/".$day;

    my @where = (
	{ 'type'    => { like => "%$hint%" } },
	{ 'date'    => { like => "$ymd%"   } },
	{ 'fscale'  => { like => "%$hint%" } },
	{ 'damage1' => { like => "%$hint%" } },
	{ 'damage2' => { like => "%$hint%" } },
	{ 'dead'    => $hint },
	{ 'hurt1'   => $hint },
	{ 'alldestroy' => $hint },
	{ 'halfdestroy' => $hint },
	{ 'detail'  => { like => "%$hint%" } },
	);

#    date,detail
    my @tornado = $csv->tornado(\@where);
    my @title = qw/type date position fscale damage1 damage2 dead
                   hurt1 alldestroy halfdestroy detail/;
    
    my $year_list  = ['',1900..2016];
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
