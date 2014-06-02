#!/usr/bin/perl
use strict;

#joinのメソッドを作ってみる。

my @a = ('a'..'z');
print &join(',',@a);


sub join{
    my @return_value;
    my $first = shift;
    my @second = @_;

    for (@second){
	$_ = $_.$first unless $_ eq $a[-1];
	push @return_value , $_;
    }
    return @return_value;
}
