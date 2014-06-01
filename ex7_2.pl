#!/usr/bin/perl;
use strict;
use 5.010;

#どうやってオンオフ切り替えるの？
#変数に値がない場合、//の右辺の値を返します。値を持っていればその値が返ります。

# 環境変数 DEBUG を使ってデバグ出力をコントロールします。デフォルトは有
# 効とするので、デバグ出力を止める場合には、シェルで export DEBUG=1 と
# してください。プログラム実行時だけ環境変数を設定するには、export をせ
# ずに、DEBUG=0 ./ex7_2.pl とすれば良いでしょう。

# XXX - わかっているかもしれませんが、DEBUG=0 ./ex7_2.pl としてプログラ
# ムを実行するのはなんだか不自然ですね。通常であればデバグスイッチはデ
# フォルト無効で、有効にする場合に DEBUG=1 ./ex7_2.pl としてあげる方が
# 自然です。

my $debug = $ENV{DEBUG} // 1;	# ここでは、$ENV{DEBUG} || 1 でもよい

my $msg = "Please input number form 1 to 100 : ";
my $secret_num = int(1 + rand 100);

print "debug: secret_num is $secret_num\n" if $debug;

while(1){

    chomp(my $input_num = <STDIN>);

    # 入力可能文字列の判定式がわからない。$a =~ /quit|exit|^\s*$i/
    # 
    # おそらく i の位置が間違っています。正しくは $a =~
    # /quit|exit|^\s*$/i だと思います。i は大文字と小文字を区別しないと
    # いうオプションです。つまり、EXIT や Quit でもプログラムを終了でき
    # るようになります。^\s*$ で、^ は先頭、$ は最後を意味します。\s*
    # は 0個以上の空白です。つまり、空白(または空)だけの入力の場合にも
    # プログラムを終了させます。

    if($input_num eq '' || $input_num eq 'quit' || $input_num eq 'exit'){
	print "$msg\n";
	last;
    }elsif($input_num == $secret_num){
	print "That's it!\n";
	last;
    }elsif($input_num > $secret_num){
	print "That's too large.\n";
    }else{
	print "That's too small.\n";
    }

}
