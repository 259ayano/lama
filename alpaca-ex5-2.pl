#!/usr/bin/perl
use strict;
use Data::Dumper;

=image
my %coconet = (
   sorce => {
	byte => 0,
	des => []
    }
);
=cut

=first
my %coconet;
while(<>){

#こめんとは省く
    unless ( /^#.*/ ){
#	print "$. : $_\n";
	my ($sorce, $des, $byte) = split;
	$coconet{$sorce}->{$des} += $byte;
	$coconet{$sorce}->{"total"} +=  $byte;
    }
}

#print Dumper \%coconet;


for my $src (sort {$coconet{$b}->{"total"} <=> $coconet{$a}->{"total"}}keys %coconet){
    print "$src\n";
    for my $dst (sort { $coconet{$src}->{$b} <=> $coconet{$src}->{$a} } keys %{$coconet{$src}}){
	print "\t$dst ${$coconet{$src}}{$dst} \n";
    }
}
=cut

my %coconet;
while(<>){

#こめんとは省く
    next if( /^#.*/ );
    my ($sorce, $des, $byte) = split;
    $coconet{$sorce}->{des}->{$des} += $byte;
    $coconet{$sorce}->{total} +=  $byte;
    
}

#print Dumper \%coconet;

for my $src (sort {$coconet{$b}->{total} <=> $coconet{$a}->{total}}keys %coconet){
    print "$src $coconet{$src}->{total}\n";
    my $des_ref = $coconet{$src}->{des};
    for my $dst (sort { $des_ref->{$b} <=> $des_ref->{$a} } keys %$des_ref){
	print "\t$dst $des_ref->{$dst} \n";
    }
}
