#!/usr/bin/perl
use strict;
use warnings;
use common::sense;

my @data = <DATA>;

#フレッドに一致するものを表示する。
print grep /fred/i, @data;

say "--------------------------";

#ドットが入っているものだけ表示する。
print grep /\./, @data;

say "--------------------------";

#頭文字だけ大文字のものを表示する。
print grep /^[A-Z][a-z]+/, @data;


say "--------------------------";

#連続しているものを表示する。
#駄目だった。
#print grep /(\S){2}/, @data;
#答え見た。
print grep /(\S)\1/, @data;

say "--------------------------";

#フレッドと文乃に一致しているものを表示する。
print grep /fred|ayano/i, @data;

__DATA__
Fred
Nao
frederick
Alfred
Ayano
minako
Mr.Fred
Mr.Masato
FRED
AYANO
Mississippi
Bamm-Bamm
llama
