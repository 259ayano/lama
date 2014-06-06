#!/usr/bin/perl
#use strict;

#初めてのPerlの目次をwiki用の形に変換してみよう。

chomp(my $title = <STDIN>);
my $common = "初めてのPerl/$title";

while(<>){

    #取得した一行分の文字を置換
    #s/~~~~~/という形が置換
    #すぺーす８個分を：に置き換える。
    s/\s{8}/:/g;

    #/~~~~~/という形がぱたーんまっち
    if(/^(:*)(.*)　(.*)$/){
	my $koron = $1;
	my $number = $2;
	my $content = $3;

	print "${koron}[[${common}#${number}|${number}　${content}]]","\n";
    }    
}
