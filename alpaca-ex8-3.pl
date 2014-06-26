#!usr/bin/perl
use common::sense;
use IO::Dir;

my @files = grep { -d } @ARGV;

unless ( defined( @files ) ){
    say "Plase input dir";

}else{
    for (@files){
	say $_;
	my $dir_fh = IO::Dir->new( $_ ) or die "Can't open dir handler\n";
	while( my $file = $dir_fh->read ){
	    print "$file\n";
	}
    }
}
