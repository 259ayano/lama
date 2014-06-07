#!/usr/bin/perl
use strict;
use Data::Dumper;

sub check_required_item {
    my $who = shift;
    my $items = shift;
    my @miss;
    my @required = qw (preserver sunscreen water_bottle jacket);
    for my $req_item(@required){
	unless(grep $req_item eq $_, @$items){
	    print "$who is missing $req_item.","\n";
	    push @miss, $req_item;
	}
    }
    
    if (@miss) {
	push @$items, @miss;
	print "add missing items.", "\n";
	print "@$items", "\n";
    }
}

sub check_item_for_all{
    for my $who (keys %{$_[0]}) {
	check_required_item($who,$_[0]->{$who});
    }
}

my @gilligan = qw (red_shirt hat lucky_socks water_bottle);
my @skipper = qw (blue_shirt hat jacket preserver sunscreen);
my @professor = qw (sunscreen water_bottle slide_rule batteries radio);
my %all = (
    Gilligan => \@gilligan,
    Skipper => \@skipper,
    Professor => \@professor,
    );

check_item_for_all(\%all);

