package Weather::Web::Controller::Data;
use Moose;
use namespace::autoclean;
use CGI::Expand qw/expand_hash/;
use Data::Dumper;
use LWP::UserAgent;
use HTML::TreeBuilder;
use Data::Recursive::Encode;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

Weather::Web::Controller::Data - Catalyst Controller

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
    my @monthly = qw/month kiatsu1 kiatsu2 rain_sum rain_d_max rain_h_max rain_10_max
                     temp_d_ave temp_d_max temp_d_min temp_max temp_min
                     wet_ave wet_min wind_ave wind_max1 wind_max_dir1
                     wind_max2 wind_max_dir2 sun1 sun2 snow_sum snow_sum_max snow_max
                     cloud_ave snow_day mist_day Thunder_day/;
    my @daily   = qw/day kiatsu1 kiatsu2 rain_sum rain_h_max rain_10_max
                     temp_d_ave temp_d_max temp_d_min wet_ave wet_min wind_ave
                     wind_max1 wind_max_dir1 wind_max2 wind_max_dir2 sun
                     snow_sum snow_max tenki tenki_n/;
    my @hourly  = qw/hour kiatsu1 kiatsu2 rain temp roten jyoki wet wind wind_dir
                     sun1 sun2 snow1 snow2 tenki cloud see/;
    my $t = $search->{hint} || '50'; # XXXXX 
    my @prec   = `grep -e $t $prec_tbl`;
    my $y = $search->{year} || '2016';
    my $m = $search->{month} || '';
    my $d = $search->{day} || '';
    my $type = $y && $m && $d ? 'hourly' : $y && $m ? 'daily' : $y ? 'monthly' : '';
    my @key = $type eq 'hourly' ? @hourly : $type eq 'daily' ? @daily : $type eq 'monthly' ? @monthly  : ();

    my ($show,$list);
    for (@prec) {
	chomp;
	my ($prec_name, $prec_code) = split "," , $_;
	my @block   = `grep -e ',$prec_code,' $block_tbl`;

	for (@block) {
	    chomp;
	    my ($block_name, $prec_code, $block_code) = split "," , $_;
	    my $url = "http://www.data.jma.go.jp/obd/stats/etrn/view/${type}_s1.php?";
	    my %param = (
		prec_no => $prec_code,
		block_no => $block_code,
		year => $y || '2016',
		month => $m,
		day => $d,
#				elm => $elm,
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
		    $line->{$key[$count]} = $_->as_text;
		    $count++;
		}
		push @$list, $line;
		push @{$show->{$prec_code}->{$block_code}}, $line;
	    }
	}
    }

    if($param->{csv}){
	my $file = 'tenki.csv';
	my $data = &list2csv($list,\@key);
	$c->stash(data => $data, current_view => 'CSV', filename => $file);
	return;
    }
    
    my $year_list  = ['',1872..2016];
    my $month_list = ['',1..12];
    my $day_list   = ['',1..31];
    $c->stash->{year_list}  = $year_list;
    $c->stash->{month_list} = $month_list;
    $c->stash->{day_list}   = $day_list;
    $c->stash->{th} = \@key;
#	$c->stash->{type} = $type;
    $c->stash->{show} = $show;
    $c->stash->{search} = $search;
    $c->stash->{template} = 'data.tt';
}


sub list2csv {
    my $list = $_[0];
    my $title = $_[1];
    my $csv = [
	[ map { $_ } @$title ],
	map { my $x = $_; [ map { $x->{$_} } @$title ]; } @$list
	];
#	Data::Recursive::Encode->encode('utf-8', $csv);
    $csv;
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
