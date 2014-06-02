!/usr/bin/perl;
# -*- coding: utf-8; mode: perl; -*-

use strict;

chomp(my $radius = <STDIN>);
if($radius < 0){
 $radius = 0;
}
my $lengthCircle = $radius * 2 * 3.14;
print '円周の長さ：'.$lengthCircle;
