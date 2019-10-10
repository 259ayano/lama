#!/usr/bin/env perl

use strict;
use 5.14.3;
use Data::Dumper;
use File::Basename;
use Getopt::Lucid qw( :all );
 
my @specs = (
    Switch("csv|c"),
    Switch("md|m")
    );

my $opt = Getopt::Lucid->getopt( \@specs )->validate;

my @files = @ARGV;
my $regex_suffix = qr/\.[^\.]+$/;

for my $file ( @files ) {

    my ($base_name, $dir, $suffix) = fileparse($file, $regex_suffix);
    next unless $suffix eq (".xls"||".xlsx" );

    if ( $opt->get_csv ){
	# xls 2 csv
	print "xls 2 csv"."\n";
    }

    if ( $opt->get_md ){
	# xls 2 md
	print "xls 2 md"."\n";
    }

}



