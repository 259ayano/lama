#!/usr/bin/perl
use Data::Dumper;
use common::sense;
use IO::File;

my $log = IO::File->new('log_file.txt') or die "no file. : $!";
my %person_info;
my $fh;

while(<$log>){
    next unless (/^(.+):/);
    my $name = $1;
    $person_info{$name} = IO::File->new(">> $name.txt") or die "Can't create file" unless $person_info{$name};
    print {$person_info{$name}} $_;

}

#print Dumper \%person_info;
