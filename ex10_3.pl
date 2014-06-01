#!/usr/bin/perl;
use strict;
use 5.010;

$ENV{ayano} = undef;


foreach my $key(keys %ENV){
    
    print "$key : ",$ENV{$key} // "undefined" ,"\n";

}
