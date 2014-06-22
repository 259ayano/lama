#!/usr/bin/perl
use Data::Dumper;
use common::sense;
use IO::File;

my $log = IO::File->new('log_file.txt') or die "no file. : $!";
my %person_info;

while(<$log>){
    if(/(^.*):/){
	my $fh = IO::File->new(">> $1.txt");
	$person_info{$1} = $fh;
	print $fh $_;
    }
}

#print Dumper \%person_info;
