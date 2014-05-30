#!/usr/bin/perl;
use strict;

#逆クォートで囲んで指定すると外部コマンドを実行できる。
my @lines = `perldoc -u -f atan2`;
foreach(@lines){
 s/\w<([^>]+)>/U$1/g;
 print;
}
