#!/usr/bin/perl;
# -*- coding:utf-8; mode:perl; -*-

use strict;
use 5.010;

#【問題】
#人の名前を渡すと、その人に挨拶するサブルーチンgreetを書いて下さい。
#新しく会った人に、それまでに挨拶した全員の名前を知らせるようにしてください。


#挨拶します。
sub greet{
 state @last_person;
 my $name = $_[0];

 print "Hi! $name. ";
 
 if(@last_person){
  print "@last_person is also here!\n";
 }else{
  print "You are the first one here!\n";
 }

 push @last_person,$name;
}

greet("Fred");
greet("Barney");
greet("Wilma");
greet("Betty");
