#!/usr/bin/perl

use common::sense;

my %bytes;

while (<>) {
    next if /^\#/;
    my ($src, $dst, $bytes) = split;
    $bytes{$src}{$dst} += $bytes;
}

use List::Util qw(sum);

my @src = map +{ src => $_, bytes => sum(values %{$bytes{$_}}) }, keys %bytes;
for (sort { $b->{bytes} <=> $a->{bytes} } @src) {
    print "$_->{src} $_->{bytes}\n";
    my %bytes = %{$bytes{$_->{src}}};
    my @dst = map +{ dst => $_, bytes => $bytes{$_} }, keys %bytes;
    for (sort { $b->{bytes} <=> $a->{bytes} } @dst) {
	print "\t$_->{dst} $_->{bytes}\n";
    }
}
