#!/usr/bin/perl;
use strict;


#ÇÌÇ©ÇÁÇ»Ç¢ÅB
foreach my $key(sort keys %ENV){
    printf "$key, $ENV{$key}","\n";
}
