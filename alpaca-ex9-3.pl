#!/usr/bin/perl
use common::sense;
use Data::Dumper;

my @words = <DATA>;

my @swords = 
    map $_->[0],
    sort { $a->[1] cmp $b->[1] }
    map {
	my $fword = $_;
	$fword =~ tr/A-Z/a-z/;
	$fword =~ tr/a-z//cd;
	[$_, $fword] } @words;

print @swords;


__DATA__
Professor
skipper
SKY
Piano*
Pianissimo
guiter
GUITERIST
X-MAN
