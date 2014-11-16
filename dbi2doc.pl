#!/usr/bin/perl;
use common::sense;

while(<>){

	if ($_ =~ /^\s*(sub.*csv)/){
		print $1,"\n";
	}
	if ($_ =~ /^\t{2,}('.*'),/){
		next if /join/;
		print $1,"\n";
	}

}


=memo
csv(受発注/売上の一覧,商品の一覧)の項目を抜き出します。
引数にDBI.pm を与えてください。
ドキュメント作成用
=cut
