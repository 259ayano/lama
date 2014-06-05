#!/usr/bin/perl;
use strict;

my %people = (
 "hirayama" => "ayano",
 "nishimura" => "misaki",
 "asakura" => "sakiho"
);

chomp(my $name = <STDIN>);
print $people{$name};