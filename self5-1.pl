#!/usr/bin/perl
use strict;
use Data::Dumper;
use utf8;
use Encode;
use Time::Piece;

my @files = @ARGV;
my @door_list;
for (@files){
    my $file = do $_;
    push @door_list, @$file;
}


=xxx
print Encode::encode('utf8',"$door_list[0][0]\n");
print Encode::encode('utf8',"$door_list[0][1]\n");
print Encode::encode('utf8',"$door_list[0][2]\n");
print Encode::encode('utf8',"$door_list[0][3]\n");
print Encode::encode('utf8',"$door_list[0][4]\n");
print Encode::encode('utf8',"$door_list[0][5]\n");
=cut

my %data;

for (0..$#door_list){
    my $date = Time::Piece->strptime($door_list[$_][0],"%Y-%m-%dT%H:%M:%S");
    my $staff = Encode::encode('utf8',$door_list[$_][2]);
    $data{$date->strftime("%Y-%m-%d")}->{$staff} += 1;
}

print "   date    | ";
for (0..$#files){
    $files[$_] =~ s/.pl//;
    print "$files[$_] | ";
}
print "\n";
print "-" x 30,"\n";

for (sort keys %data){
    printf ("%10s | ",$_);
    my %a = %{$data{$_}};
    for (keys %a){
	printf ("%5s | ",$a{$_ });
    }
    print "\n";
}

