#!/usr/bin/perl
use strict;
use Business::ISBN;
use Data::Dumper;

my $isbn10 = Business::ISBN->new('4873113059');
#print Dumper \$isbn10;

print "国別コード(group_code) : ".$isbn10->group_code."\n";
print "出版社コード(publisher_code) : ".$isbn10->publisher_code."\n";
