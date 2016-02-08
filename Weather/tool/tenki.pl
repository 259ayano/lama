#!/usr/bin/env perl

# 任意のポジションの気象データを取得する。

use common::sense;
use Data::Dumper;
use LWP::UserAgent;
use HTML::TreeBuilder;

my $prec_tbl  = './tsv/prec';
my $block_tbl = './tsv/block';

my @target = @ARGV ? @ARGV : 50; # XXXXX 
my $e = join(' ', map {"-e $_"} @target);
my @prec   = `grep $e $prec_tbl`;

for (@prec) {
	chomp;
	my ($prec_name, $prec_code) = split "," , $_;
	my @block   = `grep -e ',$prec_code,' $block_tbl`;
	warn Dumper \@block;
	exit;

	for (@block) {
		chomp;
		my ($block_name, $prec_code, $block_code) = split "," , $_;
		my $url = 'http://www.data.jma.go.jp/obd/stats/etrn/view/hourly_s1.php?';
		my %param = (
			prec_no => $prec_code,
			block_no => $block_code,
			year => 2011, month => 6, day => 24,
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
		my @title = $tree->find('h3');
		next unless @title;
		print '-------------'. "\n";
		print $_->as_text . "\n" for @title;

		for my $tr ($tree->look_down('id','tablefix1')->find('tr')) {
			my @td = $tr->find('td');
			print join(',', map { $_->as_text } @td), "\n";
		}
	}
}

