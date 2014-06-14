#!/usr/bin/perl
use strict;
use File::Spec;
use Cwd;

my $cur_dir = getcwd;
my @all_files = glob "*";

#my $full = File::Spec->catfile( $cur_dir, $all_files[0]);
#print "$full\n";

=first
my @fulls = map {
my $full = File::Spec->catfile( $cur_dir, $_);
$full = "    $full\n";
} @all_files;
print "@fulls";
=cut

my @fulls = map {"    ".File::Spec->catfile( $cur_dir, $_)."\n"} @all_files;
print "@fulls";
