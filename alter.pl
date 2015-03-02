#!/usr/bin/perl
use strict;
use common::sense;
use Data::Dumper;


my ($table, $col, $type) = @ARGV;

print "ALTER TABLE $table ADD ( $col $type )";
