#!/usr/bin/perl
use strict;

use File::Find;
use Time::Local;

my $target_dow = 1; 
my @starting_directories = glob("*");

my $seconds_per_day = 24 * 60 * 60;
my ($sec,$min,$hour,$day,$mon,$yr,$dow) = localtime;
my $start = timelocal(0,0,0,$day,$mon,$yr);

while ($dow != $target_dow) {
    #一日戻る
    $start -= $seconds_per_day;
    if (--$dow < 0){
	$dow += 7;
    }
}
my $stop = $start + $seconds_per_day;

my($gather,$yield) = gather_mtime_between($start,$stop);

#ファイルを一つずつ第一引数のサブルーチン(リファレンス）で処理してくれる。
find($gather, @starting_directories);

#テスト用コードには、my @files = $yield->( );とあるが、理解できてないので、また後で修正。
my @files = @$yield; 

for my $file (@files){
    my $mtime = (stat $file)[9];
    my $when = localtime $mtime;
    print "$when: $file\n";
}

sub gather_mtime_between {
#    print "@_\n";
    my $start = shift;
    my $stop = shift;

    my @files;

    #first
    my $gather = sub {
	my $file = $_;
	my $time_stamp = (stat $file)[9];
#	print "$time_stamp\n" if ( $time_stamp < $stop and $time_stamp > $start);
	push @files, $_ if ( $time_stamp < $stop and $time_stamp > $start);
    };

    #second
    my $yield = \@files;

    return ($gather, $yield);
}
