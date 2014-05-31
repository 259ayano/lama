#!/usr/bin/perl;
use strict;
use 5.010;

#どうやってオンオフ切り替えるの？

#変数に値がない場合、//の右辺の値を返します。値を持っていればその値が返ります。
my $ debug = $ENV{DEBUG} // 1;


my $msg = "Please input number form 1 to 100 : ";
my $secret_num = int(1 + rand 100);

print "debug: secret_num is $secret_num\n" if $debug;

while(1){
    print "$msg";
    chomp(my $input_num = <STDIN>);


    #入力可能文字列の判定式がわからない。$a =~ /quit|exit|^\s*$i/

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
