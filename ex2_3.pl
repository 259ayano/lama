#!/usr/bin/perl;
# -*- mode: perl; coding: utf-8; -*-

use strict;

chomp(my $radius = <STDIN>);

$radius = 0 if ($radius < 0);

my $lengthCircle = $radius * 2 * 3.14;
print "円周の長さ：$lengthCircle\n";
