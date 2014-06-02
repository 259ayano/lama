#!/usr/bin/perl;
use strict;

sub total{
 my $sum = 0;
 foreach(@_){
  $sum += $_;
 }
 $sum; 
}

sub average{
 my $size = @_;

 return total(@_)/$size;
}

sub above_average{
 my @result;
 my $avg = average(@_);
 foreach (@_){
  if($_ > $avg){
   push @result , $_;
  }
 }
 @result;
}
my @fred = above_average(1..10);
print join (',' , @fred),"\n";
