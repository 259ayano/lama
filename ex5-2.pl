#!/usr/bin/perl;
use strict;

print "Please type word, per one line:";
chomp(my @people = <STDIN>);

#「x」繰り返し。
print "1234567890" x 3, "\n";

foreach(@people){

  #%○s　ある文字列と空白を含め○文字表示する。 
  printf "%20s\n",$_;

}