#!/usr/bin/perl
use strict;

my $a = "# -*- coding: utf-8; mode: perl; -*-";
# -*- coding: utf-8; mode: perl; -*-# -*- coding: utf-8; mode: perl; -*-
=try1

#追記はできるんだけど、ファイルの最後に追記されちゃう。
my @files = `ls *.pl`;

for(@files){
    open (PERL_FILE,">> $_") || die("失敗しちゃいました。");    
    print PERL_FILE "\n$a";
    close(PERL_FILE);
}

=cut

=test
my @files = `ls *.pl`;

for(@files){
    open (PERL_FILE,"$_") || die("失敗しちゃいました。");    
    my @file = <PERL_FILE>;
    close(PERL_FILE);

    for (@file){
	print;
    }
}
=cut

my @files = `ls *.pl`;

for (@files){
    chomp;
    my $baseFile = $_;
    my $tempfile = "temp$_"; 
    open( OLD, "< $baseFile");
    open( NEW, "> $tempfile");
    while( <OLD> ){
	print NEW $_;
	print NEW $a if($. == 4);
    }
    close(OLD);
    close(NEW);
    
    print "mv $tempfile $baseFile", "\n";

}
