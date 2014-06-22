#!/usr/bin/perl
use common::sense;
use IO::File;
use IO::Scalar;
use IO::Tee;

my $scalar;
my $fh;

say "Please chouse input type, file or scolor or both";

chomp(my $input = <STDIN>);


if ( $input =~ /^f/ ){
    $fh = IO::File->new('>> log.txt');
    
}elsif ( $input =~ /^s/ ){
    $fh = IO::Scalar->new( \$scalar );

}elsif ( $input =~ /^b/ ){
    open my $scalar_fh,'>>',\$scalar;
    open my $file_fh,'>>','log.txt';
    $fh = IO::Tee->new( $file_fh , $scalar_fh );

}else{
    say "Please input correct pattern.";
}


#sec,min,hour,mday,mon,year,wday,yday,isdst
my @week = qw(Sun Mon Tue Wed Thu Fri Sat);
my @localtime = localtime;
my $date_data = $localtime[3]."(".$week[$localtime[6]].")";

eval{
print $fh $date_data;
print STDOUT $scalar;
};
