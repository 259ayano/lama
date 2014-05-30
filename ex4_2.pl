#!/usr/bin/perl;
use strict;

sub total{
 my $sum = 0;
 foreach(@_){
  $sum += $_;
 }
 $sum; 
}
print &total(1..1000);
