#!/usr/bin/perl

use strict;

#joinのメソッドを作ってみる。
=ayano
my @a = ('a'..'z');
print &join(',',@a);

sub join{
    my @return_value;
    my $first = shift;
    my @second = @_;

    for (@second){
	$_ = $_.$first unless $_ eq $a[-1];
	push @return_value , $_;
    }
    return @return_value;
}
=cut

# サブルーチンの中でグローバル変数を参照すると、部品として使い回しがで
# きないので不便です。セパレータを最後の要素に付けないようにするために、
# 最後の要素だけ処理を分けて考えても良いかもしれません。
# 
# あと、上のコードでは、戻り値が配列となっていますが、ここは連結された
# 文字列が返るのでスカラーが正しいでしょう。配列にプッシュするのではな
# く、文字列の連結 .= を使います。

my @a = ('a'..'z');
print &myjoin(',', @a);

sub myjoin {
    my $sep = shift;
    my @arr = @_;
    my $str;
    $str .= $arr[$_] . $sep for (0..$#_-1);
    $str .= $arr[-1];
}

sub join_easy {
    local $" = shift;
    "@_";
}
