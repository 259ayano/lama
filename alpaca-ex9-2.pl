#!/usr/bin/perl
use common::sense;
use Data::Dumper;
use Benchmark qw(:all);

my $after_t = timeit(1, 'sort { -s $a <=> -s $b } glob "/bin/*"');

my $before_t = timeit(1, 
'map $_->[0], 
sort { $a->[1] <=> $b->[1]} 
map [ $_, -s $_], glob "/bin/*"');

#print "\$after_t :",timestr($after_t),"\$before_t :",timestr($before_t);

my $result = timethese(1,
 {
    code1 => sub {sort { -s $a <=> -s $b } glob "/bin/*"},
    code2 => sub {map $_->[0], 
		  sort { $a->[1] <=> $b->[1]} 
		  map [ $_, -s $_], glob "/bin/*"}
 }
);

print timestr($result);
