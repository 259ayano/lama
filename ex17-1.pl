#!/usr/bin/perl
use strict;


=first
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
=cut


chomp(my $pattern = <STDIN>);

eval{

    #0個以上の空白文字にマッチ
    last if $pattern =~ /^\s*$/;

    print grep /$pattern/, <DATA>;

};

if ( $@ ){
    print "Please input another pattern.: $@\n";
}


__DATA__

hirayama ayano:26:161:sushi
hirayama nao:24:158:sushi
