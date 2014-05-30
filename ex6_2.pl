#!/usr/bin/perl;
use strict;

my @people;
my %count;

chomp(@people = <STDIN>);

foreach(@people){
 $count{$_} += 1;	
}

foreach(keys %count){
 print "$_ was seen $count{$_}\n";
}
