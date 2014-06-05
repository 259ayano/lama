#!/usr/bin/perl;
use strict;

chomp(my $inputString = <STDIN>);
chomp(my $inputNum = <STDIN>);
print 'The result:'.$inputString x $inputNum;

