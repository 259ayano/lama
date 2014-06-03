#!/usr/bin/perl
use strict;


#-sは、ファイルサイズを取得する演算子

=test1
my @files = @ARGV;
my @files = grep -s $_ < 1000, @files; 
print map "    $_\n", @files;
=cut

=test2
my @files = grep -s $_ < 1000, @ARGV; 
print map "    $_\n", @files;
=cut

print map "    $_\n", grep -s $_ < 1000, @ARGV;
