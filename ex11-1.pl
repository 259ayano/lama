#!/usr/bin/perl;
use strict;

use Module::CoreList;

my %modules = %{ $Module::CoreList::version{5.008}};

foreach(keys %modules){
    print "$_ : $modules{$_}\n";
}
