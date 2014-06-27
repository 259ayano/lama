#!/usr/bin/perl
use common::sense;


=Q1
my $what = "fred|barney";

while(<DATA>){
    if(/($what){3}/){
	print;
    }
}
=cut

=Q2
open OUT, ">>text.out" or die "can not open.";

 
while(<DATA>){
    s/barney/larry/gi;
    print;
}
=cut

=Q3
while(<DATA>){
    s/Fred/\t/gi;
    s/Wilma/Fred/gi;
    s/\t/Wilma/gi;
    print;
}
=cut

#Q4,5
$^I = ".bak";
while(<>){
    if(/^#!/){
	$_ = $_."## Copyright (C) 20XX by Yours Turly"."\n";
    }
    print;
}

__DATA__
fredfredfred
fredfredbarney
barneyfredfred
barneybarneykitty
babibubebo
mamimumemo
Fred
FRED
