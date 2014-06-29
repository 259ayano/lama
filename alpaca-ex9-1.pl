#!/usr/bin/perl
use common::sense;
use Data::Dumper;

#my @sorted = sort { -s $a <=> -s $b } glob "/bin/*";

my @s_sorted = 
map $_->[0], 
sort { $a->[1] <=> $b->[1]} 
map [ $_, -s $_], glob "/bin/*";

#print Dumper \@s_sorted;

for(@s_sorted){
    say;
}
