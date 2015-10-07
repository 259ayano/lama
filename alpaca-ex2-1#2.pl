#!/usr/bin/env perl

use Data::Dumper;
use common::sense;

my $files = `ls`;
for my $filename (split('\n',$files)){
	my $result = `ls -l $filename`;
	my @data   = split(" ",$result);

	say "$filename : $data[4]" if $data[4] =~ /^\d*$/ && $data[4] <= 1000; 

	
	#	`ls -l $_ | cut -f5 -d' '`;
	#	`ls -l $_ | awk '{ print \$5 }'`;
}
