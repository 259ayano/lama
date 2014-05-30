#!/usr/bin/perl;
use strict;

print 'Please input word, then pless Crel Z :';
chomp(my @inputWord = <STDIN>);
print reverse @inputWord;