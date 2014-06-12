#!/usr/bin/perl
use strict;
use Data::Dumper;
use utf8;
use Encode;

my @files = @ARGV;
my @door_list;
for (@files){
    my $file = do $_;
    push @door_list, @$file;
}

=xxx
print Encode::encode('utf8',"$yuta->[0][0]\n");
print Encode::encode('utf8',"$yuta->[0][1]\n");
print Encode::encode('utf8',"$yuta->[0][2]\n");
print Encode::encode('utf8',"$yuta->[0][3]\n");
print Encode::encode('utf8',"$yuta->[0][4]\n");
print Encode::encode('utf8',"$yuta->[0][5]\n");
=cut


my %data;

for (0..$#door_list){
    my @date = split(/T/,$door_list[$_][0]);
    my ($year,$month,$day) = split(/-/,@date[0]);
    my $staff = Encode::encode('utf8',$door_list[$_][2]);
    $data{"$year-$month"}->{$staff} += 1;
}
#print Dumper \%data;

print "year-month | ";
for (0..$#files){
    $files[$_] =~ s/.pl//;
    print "$files[$_] | ";
}
print "\n";

for (keys %data){
    printf ("%10s",$_);
    print " | ";
    my %a = %{$data{$_}};
    for (keys %a){
	printf ("%5s",$a{$_ });
	print " | "
    }
    print "\n";
}
