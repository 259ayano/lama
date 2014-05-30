#!/usr/bin/perl;
use strict;

chomp(my $radius = <STDIN>);
if($radius < 0){
 $radius = 0;
}
my $lengthCircle = $radius * 2 * 3.14;
print '‰~ü‚Ì’·‚³F'.$lengthCircle;