#!/usr/bin/perl;
use strict;

print "Please type width:";
chomp(my $width = <STDIN>);
print "Please type word, per one line:";
chomp(my @people = <STDIN>);

#「x」繰り返し。
print "1234567890" x (($width+9)/10), "\n";

foreach(@people){

  #%○s　ある文字列と空白を含め○文字表示する。 
  printf "%${width}s\n",$_;
}
