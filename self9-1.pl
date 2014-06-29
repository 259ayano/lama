#!/usr/bin/perl
use common::sense;
use Data::Dumper;

my $HOME = "Shizuoka";
my $OTHER = "Other City";

my %member;
my %living;


while(<DATA>){
    if(/^(\S*):(\S*),(\S*)$/){
	my $name = $1;
	my $live = $2;
	my $possision = $3;
	
	push @{$member{$name}},$2,$3;

    }
}

#print Dumper \%member;

for my $key(keys %member){
    if( $member{$key}->[0] =~ /shizuoka/i ){
	push @{$living{$HOME}}, $key;
	say "$key live in $HOME";
    }else{
	push @{$living{$OTHER}}, $key;
	say "$key live in $OTHER";
    }
}

print Dumper \%living;


__DATA__
ayano:shizuoka,guard
hitomi:shizuoka,guard
mari:shizuoka,Forward
tomoco:iwate,Forward
misato:tokyo,CenterForward
