#!/usr/bin/env perl

use Data::Dumper;
use Net::Ping::External qw/ping/;

my $host  = "124.83.235.204";
my $alive = ping(host => $host);
warn Dumper $alive;
open(LOG, '>>ping.log') or die("can not open file.");

pring LOG "$host is alive\n" if $alive;
