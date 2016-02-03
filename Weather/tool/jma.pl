#!/usr/bin/perl

use common::sense;
use Data::Dumper;
use LWP::UserAgent;
use HTML::TreeBuilder;

for my $prec_no (50){

	my $url = "http://www.data.jma.go.jp/obd/stats/etrn/select/prefecture.php?prec_no=$prec_no&block_no=&year=&month=&day=&view=";

    # LWP = PerlでWWWアクセスするためのライブラリでHTMLの内容を取得
	my $ua  = LWP::UserAgent->new;
	my $res = $ua->get($url);
	my $content = $res->content;

	for (split('\n',$content)){
		next unless $_ =~ /<area shape="rect"./;
#		<area shape="rect" alt="静岡空港" coords="183,220,236,232" href="../index.php?prec_no=50&block_no=1601&year=&month=&day=&view="
		print $_. "\n";
	}
}
