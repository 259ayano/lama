#!/usr/bin/perl
use common::sense;


my($file,$scolor,$both);
my $fh;

say "Please chouse input type, file or scolor or both";

my $input = <STDIN>;


if ( $input =~ /^f/ ){
#ファイルを選択した場合
    open $fh,'>>',\$file;
    
}elsif ( $input =~ /^s/ ){

    open $fh,'>>','log.txt';

}elsif ( $input =~ /^b/ ){
    open my $file_fh,'>>',\$file;
    open my $scolor_fh,'>>','log.txt';
    $fh = IO::Tee->new( $file_fh , $scolor_fh );

}else{
    say "Please input correct pattern.";
}


#sec,min,hour,mday,mon,year,wday,yday,isdst
my @week = qw(日 月 火 水 木 金 土);
my @localtime = localtime;
my $date_data = $localtime[3]."(".$week[$localtime[6]].")";

eval{
print $fh $date_data;
};
