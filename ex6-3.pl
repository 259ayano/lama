#!/usr/bin/perl;
# -*- coding:utf-8; mode:perl; -*-

use strict;



#わからない。
foreach my $key(sort keys %ENV){
    printf "$key, $ENV{$key}","\n";
}

# ハッシュの代りに配列を使う。
my @env = %ENV;
my @key_index = grep { $_ % 2 == 0 } 0 .. $#env;
for my $i (sort { $env[$a] cmp $env[$b] } @key_index) {
    print "$env[$i], $env[$i + 1]\n";
}
