#!/usr/bin/perl;
use strict;

my @people = qw(fred betty barney dino wilma pebbles bamm-bamm);
chomp(my @inputNum = <STDIN>);
foreach (@inputNum){
	print "$people[$_-1]\n";
}
