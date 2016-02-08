#!/usr/bin/env perl

# 気象庁の管理するポジション情報を取得する

use common::sense;
use Data::Dumper;
use LWP::UserAgent;
use HTML::TreeBuilder;

my $ua  = LWP::UserAgent->new;
my $dir = './tsv';
my @precs;


# 県のデータを取得

my $prec_url = "http://www.data.jma.go.jp/obd/stats/etrn/select/prefecture00.php?prec_no=&block_no=&year=&month=&day=&view=";

my $prec_res = $ua->get($prec_url);
my $prec_con = $prec_res->content;

for (split('\n',$prec_con)){
	next unless $_ =~ /<area shape="rect" alt="(.+)" coords="(.+)" href="prefecture\.php\?prec_no=(.+)&block_no=&year=&month=&day=&view=">/;
	my ($name,$coords,$prec_no) = ($1,$2,$3);
	
	open my $fh, '>>', "$dir/prec" or die $!;
	say $fh join(',', $name,$prec_no);
	close $fh;

	push @precs, $prec_no;
}


# 市のデータを取得

for my $p (@precs){

	my $url = "http://www.data.jma.go.jp/obd/stats/etrn/select/prefecture.php?prec_no=$p&block_no=&year=&month=&day=&view=";

	my $res = $ua->get($url);
	my $content = $res->content;

	for (split('\n',$content)){
		next unless $_ =~ /<area shape="rect" alt="(.+)" coords="(.+)" href="\.\.\/index\.php\?prec_no=(.+)&block_no=(.+)&year=&month=&day=&view="/;
		my ($name,$coords,$prec_no,$block_no) = ($1,$2,$3,$4);
		open my $fh, '>>', "$dir/block" or die $!;
		say $fh join(',', $name,$prec_no,$block_no);
		close $fh;
	}
}
