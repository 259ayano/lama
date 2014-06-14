#!/usr/bin/perl
use strict;
use Data::Dumper;

my @numbers = (1,2,22,35,41,56,98);

#grepの練習
#test1
my @bigger_than_30 = grep $_ > 30, @numbers;
print "@bigger_than_30\n";

#test2
my @last_num_2 = grep /2$/, @numbers;
print "@last_num_2\n";

#test3
my @odds = grep &odd($_),@numbers;
sub odd{
    my $num = shift;
    return $num if($num % 2);
}
print "@odds\n";

#test4
my @evens = grep {
    my $num = $_;
    $num if($num % 2 == 0);
} @numbers;
print "@evens\n";



#mapの練習
my @result;

#test1
@result = map $_ + 100, @numbers;
print "@result\n";

#test2
@result = map {$_, $_ * 3} @numbers;
my %result_hash = map {$_, $_ * 3} @numbers;
#print "@result\n";
#print Dumper \%result_hash;

#test3
@result = map { 
    my @a = split //,$_;
    if($a[-1] == 1){
	$_;
    }else{
	();
    }
} @numbers;
print "@result\n";
