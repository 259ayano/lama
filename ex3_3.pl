#!/usr/bin/perl;
use strict;

#「sort」はASCIIコード順に並べ替える。

chomp(my @people = <STDIN>);
@people = sort @people;
print "@people\n";
