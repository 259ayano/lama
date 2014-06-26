#!/usr/bin/perl
use Data::Dumper;
use common::sense;
use IO::File;

my $log = IO::File->new('log_file.txt') or die "no file. : $!";
my %person_info;
my $fh;

while(<$log>){
    next unless (/^(.+):/);
    push @{$person_info{$1}}, $_;

}

#print Dumper \%person_info;

for my $key(keys %person_info){

    $fh = IO::File->new(">> $key.txt");
    for my $line( @{$person_info{$key}} ){
	print $fh $line;
    }
}
