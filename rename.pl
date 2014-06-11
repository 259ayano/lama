#!/usr/perl/bin
use strict;

my @files = @ARGV;

for (@files){
   chomp;
   # s/_/-/;
   # print $n;
   my $newname = $_;
   $newname =~ s/_/-/;
   $newname =~ s/^2/alpaca-/g;
   print "git mv $_ $newname","\n";
}
 
 
