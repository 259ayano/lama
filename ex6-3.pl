#!/usr/bin/perl;
# -*- coding:utf-8; mode:perl; -*-

use strict;



#わからない。
foreach my $key(sort keys %ENV){
    printf "$key, $ENV{$key}","\n";
}
