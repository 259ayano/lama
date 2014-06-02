#!/usr/bin/perl;
# -*- coding:utf-8; mode:perl; -*-

use strict;
use 5.010;

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
