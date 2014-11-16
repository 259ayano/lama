#!/usr/bin/perl;
use common::sense;

while(<>){
	if ($_ =~ /^\s*push(\(|\s)\@error,\s('|")(.*)('|")\)/){
		print $3,"\n";
	}
	if ($_ =~ /^\s*sub\scheck_(.*){/){
		print $1,"\n";
	} 
}


=memo
ファイルによるデータ取込み時の、データチェックメッセージを抜き出します。
引数にはOrder.pmもしくはSales.pmを与えてください。
ドキュメント作成用
=cut
