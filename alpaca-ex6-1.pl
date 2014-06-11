#!/usr/bin/perl
use strict;
use Data::Dumper;
use Storable;

my $file_name = "data-file.txt";
my $file_data;

$file_data = retrieve $file_name if(-e $file_name);

while(<>){

    next if( /^#.*/ );
    my ($sorce, $des, $byte) = split;
    $file_data->{$sorce}{des}{$des} += $byte;
    $file_data->{$sorce}{total} +=  $byte;
}

store $file_data, $file_name;


for my $src (sort {$file_data->{$b}{total} <=> $file_data->{$a}{total}}keys %$file_data){
    print "$src $file_data->{$src}{total}\n";
    my $des_ref = $file_data->{$src}{des};
    for my $dst (sort { $des_ref->{$b} <=> $des_ref->{$a} } keys %$des_ref){
	print "\t$dst $des_ref->{$dst} \n";
    }
}
