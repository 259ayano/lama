#!/usr/bin/perl
use strict;

while(1){

    chomp(my $pattern = <STDIN>);    
    unless ( defined $pattern && length $pattern ){
	last;
    }else{
	my @files = grep { eval { /$pattern/ } } `ls`;
	print @files;
	last if(@files);
    }
    

}


