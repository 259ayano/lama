#!/usr/bin/perl
#use 5.010;
use feature qw(say);

#warningsプラグマは、コンパイルエラーにはならないが、望ましくないことを警告する機能がある。
use warnings;
use strict;

=eval
#evalを使ってみる。
#エラーをキャッチした場合、そのブロックの実行は終了する。
#エラー内容は$@に格納される。

chomp(my $dino = <STDIN>);
my $fred = 5;
my $barney;
eval {$barney = $fred / $dino};


if ( $@ ){
    print "$@\n";
    
}else{
    print $barney,"\n";
}
=cut


=grep
#grepを使ってみる。
#リストから要素を選び出す。

my @red = qw(ichigo chi taiyou sakuranbo bara ringo);
my @fruits = qw(mikan banana ichigo sakuranbo ringo);
my @red_fruits;
my @i_list;

for my $a(@red){
    push @red_fruits, grep $a eq $_ , @fruits;
}

push @i_list, grep /i/, @red;
print "@red_fruits","\n","@i_list";
=cut


=map
#mapを使ってみる。
#リストの要素を変換する。

print "Some powers of two are:\n", map "\t". (2 ** $_) . "\n", 0..15;

my %hash = ( ayano => "genki",
	     nao => "sugokugenki");
my @s = map $_ , %hash;
print "@s";
=cut


=slice
#スライスを使ってみる
#配列のうち指定したインデックスの値を取得する。

my @files = @ARGV;
for my $file(@files){
    open(FILE, $file) or die "nothing";
    while(<FILE>){

        #使ってないver
	my @obj = split /:/;
	my($name,$favorite) = ($obj[0],$obj[3]);

	#使っているver1
	$name = (split /:/)[0];
	$favorite = (split /:/)[3];

	#使っているver2
        ($name, $favorite) = (split /:/)[0, 3];
	print "$name $favorite\n";

    }
}
=cut



#配列スライス
my @line = 0..15;
my @newline = @line[1, 3, 5, 7];
for (@newline){
    say $_;
} 



=hash_slice
#ハッシュスライス
#配列スライスと同じ感じ。

my @name = qw(name age height favorite);
my %people = (
    name => "ayano",
    age => 26,
    height => 161,
    favorite => "sushi"
    );

my @select = ($people{$name[0]}, $people{$name[3]});
print "@select";

=cut
