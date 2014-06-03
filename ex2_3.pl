!/usr/bin/perl;
# -*- coding: utf-8; mode: perl; -*-

use strict;

#【問題】
#円の円周の長さを求めるプログラムを書いて下さい。
#プロンプトを表示して、プログラムを起動した人に半径を入力してもらうようにしてください。
#ユーザが0より小さい数を入力した場合には、（入力された）負の値の代わりに、0を半径として使うようにしてください。
#円周の長さは半径の2π倍（だいたい2×3.141592654）です。


chomp(my $radius = <STDIN>);
if($radius < 0){
 $radius = 0;
}
my $lengthCircle = $radius * 2 * 3.14;
print '円周の長さ：'.$lengthCircle;
