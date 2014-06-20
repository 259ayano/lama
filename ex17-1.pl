#!/usr/bin/perl
use strict;

my @files = @ARGV;
chomp(my $pattern = <STDIN>);


for my $file(@files){
    open(FILE, $file) or die "no file.";
    
    #0個以上の空白文字にマッチ
    last if $pattern =~ /^\s*$/;

    print eval{grep /$pattern/, <FILE>};
}

if ( $@ ){
    print "Please input another pattern.: $@\n";
}
