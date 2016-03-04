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
    my $p = $search->{prec}  || '50'; 
    my $b = $search->{block}; 
    my $y = $search->{year} || '2016';
    my $m = $search->{month} || '';
    my $d = $search->{day} || '';
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


    if($param->{csv}){
	my $file = 'tenki.csv';
	my $data = &list2csv($list,$key);
	$c->stash(data => $data, current_view => 'CSV', filename => $file);
	return;
    }
    
    my $year_list  = ['',1872..2016];
    my $month_list = ['',1..12];
    my $day_list   = ['',1..31];
    $c->stash->{year_list}  = $year_list;
    $c->stash->{month_list} = $month_list;
    $c->stash->{day_list}   = $day_list;
    $c->stash->{th} = $key;
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
