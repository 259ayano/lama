package Weather::Web::Controller::Tornado;
use Moose;
use namespace::autoclean;
use CGI::Expand qw/expand_hash/;
use Data::Dumper;
use Weather::CSV;
use Encode;

BEGIN { extends 'Catalyst::Controller'; }

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;
    my $csv = Weather::CSV->connect;
    my $params = expand_hash($c->req->params);
    my $search = $params->{search};
    my $h = decode('utf-8',$search->{hint});
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
    my $year_list  = ['',1950..2016];
    my $month_list = ['',1..12];
    my $day_list   = ['',1..31];
    $c->stash->{year_list}  = $year_list;
    $c->stash->{month_list} = $month_list;
    $c->stash->{day_list}   = $day_list;
    $c->stash->{search} = $params->{search};
    $c->stash->{list} = \@tornado;
    $c->stash->{template} = 'tornado.tt';
}


sub detail :Local {
    my ( $self, $c ) = @_;
	my $params  = $c->req->params;
	my @date = split(' ',$params->{date});
	my ($y,$m,$d) = split('/',$date[0]);
	
	$date[1] =~ s/(^.+)時頃$/$1/g;
	$date[1] =~ s/(^.+)頃$/$1/g;
	my $hour = $date[1] =~ /^(%d{2})$/ ? $1 : (split(":",$date[1]))[0];
	my $min  = $date[1] =~ /^(%d{2})$/ ? '' : (split(":",$date[1]))[1];

	my ($p,$b) = split(" ",$params->{position});
	$p =~ s/(^.+)県$/$1/g;
	$b =~ s/(^.+)市$/$1/g;
	my ($type,$key) = $c->gettype($y,$m,$d);

    my ($show,$list);
    my @prec   = $c->pdata($p);
	for (@prec) {
		chomp;
		my ($p_name, $p_code) = split "," , $_;
		my @block = $c->bdata($p_code,$b);

		for (@block) {
			chomp;
			my ($b_name, $p_code, $b_code) = split "," , $_;

			# 気象庁のサイトにアクセスしてコンテンツを取得

			my $con = $c->getjma($p_code,$b_code,$y,$m,$d,$type);
			
			# HTML::TreeBuilderで解析する

			my $tree = HTML::TreeBuilder->new;
			$tree->parse($con);

			# データの部分を抽出する

			my $title;
			my @h3 = $tree->find('h3');
			next unless @h3;
			push @$title, $_->as_text for @h3;

			for my $tr ($tree->look_down('id','tablefix1')->find('tr')) {
				my $line;
				my $count = 0;
				$line->{prec}  = $p_code;
				$line->{block} = $b_code;
				for ($tr->find('td')){
					$line->{$key->[$count]} = $_->as_text;
					$count++;
				}
				push @$list, $line;
				push @{$show->{"$p_code:$p_name"}->{"$b_code:$b_name"}}, $line;
			}
		}

	}

    $c->stash->{th} = $key;
    $c->stash->{show} = $show;
    $c->stash->{template} = 'tornado-detail.tt';
}

__PACKAGE__->meta->make_immutable;

1;
