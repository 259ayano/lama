#!/usr/bin/env perl

use Data::Dumper;

my $ERRMSG="";

open(DF, "/bin/df -k |");
while (<DF>) {
	chomp($_);
	warn Dumper $_;
	my @wk = split(/[\s\t]+/, $_);
	my $device  = $wk[0];
	my $percent = $wk[4];
	my $mount   = $wk[5];
	$percent =~ s/%//;

	if ($device =~ /\/dev/) {
		if ($percent > $p) {
			$ERRMSG .= "device $device ($mount) useage is $percent %.\n"
		}
	}
}
close(DF);

print $ERRMSG;

exit 0;
