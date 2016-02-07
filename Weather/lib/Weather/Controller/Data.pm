package Weather::Controller::Data;
use Moose;
use namespace::autoclean;
use CGI::Expand qw/expand_hash/;
use Data::Dumper;
use LWP::UserAgent;
use HTML::TreeBuilder;
use Data::Recursive::Encode;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

Weather::Controller::Data - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;
	my $param = expand_hash($c->req->params);
	my $search = $param->{search};
	my $prec_tbl  = "tsv/prec";
	my $block_tbl = "tsv/block";

	my $target = $search->{hint} || 50; # XXXXX 
	my @prec   = `grep -e $target $prec_tbl`;

	my ($show,$list);
	for (@prec) {
		chomp;
		my ($prec_name, $prec_code) = split "," , $_;
		my @block   = `grep -e ',$prec_code,' $block_tbl`;

		for (@block) {
			chomp;
			my ($block_name, $prec_code, $block_code) = split "," , $_;
			my $url = 'http://www.data.jma.go.jp/obd/stats/etrn/view/hourly_s1.php?';
			my %param = (
				prec_no => $prec_code,
				block_no => $block_code,
				year => $search->{year},
				month => $search->{month},
				day => $search->{day},
				elm => 'hourly',
				view => '',
				);

			my $ua  = LWP::UserAgent->new;
			my $res = $ua->get($url . join('&', map { "$_=$param{$_}" } keys %param));
			my $con = $res->content;
			
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
				$line->{prec}  = $prec_code;
				$line->{block} = $block_code;
				for ($tr->find('td')){
					$line->{hour} = $_->as_text if $count == 0;
					$line->{kiatsu1} = $_->as_text if $count == 1;
					$line->{kiatsu2} = $_->as_text if $count == 2;
					$line->{rain} = $_->as_text if $count == 3;
					$line->{temp} = $_->as_text if $count == 4;
					$line->{roten} = $_->as_text if $count == 5;
					$line->{jyoki} = $_->as_text if $count == 6;
					$line->{wet} = $_->as_text if $count == 7;
					$line->{wind1} = $_->as_text if $count == 8;
					$line->{wind2} = $_->as_text if $count == 9;
					$line->{sun1} = $_->as_text if $count == 10;
					$line->{sun2} = $_->as_text if $count == 11;
					$line->{snow1} = $_->as_text if $count == 12;
					$line->{snow2} = $_->as_text if $count == 13;
					$line->{tenki} = $_->as_text if $count == 14;
					$line->{cloud} = $_->as_text if $count == 15;
					$line->{see} = $_->as_text if $count == 16;
					$count++;
				}
				push @$list, $line;
				push @{$show->{$prec_code}->{$block_code}}, $line;
			}
		}
	}

	if($param->{csv}){
		my $file = 'tenki.csv';
		my $data = &list2csv($list);
		$c->stash(data => $data, current_view => 'CSV', filename => $file);
		return;
	}
	
	my $year_list  = ['',1872..2016];
	my $month_list = ['',1..12];
	my $day_list   = ['',1..31];
	$c->stash->{year_list}  = $year_list;
	$c->stash->{month_list} = $month_list;
	$c->stash->{day_list}   = $day_list;
	$c->stash->{show} = $show;
	$c->stash->{search} = $search;
    $c->stash->{template} = 'data.tt';
}


sub list2csv {
	my $list = $_[0];
	my @field = qw/prec block hour kiatsu1 kiatsu2 rain temp
		roten jyoki wet wind1 wind2 sun1 sun2 snow1 snow2
		tenki cloud see/;
	my $csv = [
		[ map { $_ } @field ],
		map { my $x = $_; [ map { $x->{$_} } @field ]; } @$list
		];
	Data::Recursive::Encode->encode('utf8', $csv);
}

=encoding utf8

=head1 AUTHOR

HIRAYAMA Ayano

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
