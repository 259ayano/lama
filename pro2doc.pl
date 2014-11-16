#!/usr/bin/perl;
use common::sense;

while(<>){
	next if $. == 1;
	if ($_ =~ /^\t{1}(\S+)\s/){
		next if $_ =~ /]/;
		print $1,"\n";
	}
	if ($_ =~ /^\t{2,}(.*)/){
		next if $_ =~ /\(|\)/;
		print $1,"\n";
	}
}


=memo
データ登録/編集時のデータチェック項目を抜き出します。
引数にはprofiles.plを与えてください。
ドキュメント作成用
=cut
