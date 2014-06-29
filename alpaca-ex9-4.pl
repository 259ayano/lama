#!usr/bin/perl
use common::sense;
#use IO::Dir;

#ディレクトとファイルの階層構造を図にしたい。
#-d はパスがディレクトか否かを判断するのではなくて、パスにディレクトリが存在するかを判断する？

chomp(my $dir = <STDIN>);

opendir(DIR, $dir);
my @dir = readdir(DIR);
closedir(DIR);

for my $file(@dir){
    &viewDir($file,0);
}

sub viewDir(){
    my ($name,$level) = @_;

    next if ($name eq "." or $name eq "..");

    print "  " x $level, "$name\n";
    &viewDir($_, $level + 1) for glob "$dir/$name/*";
    
}
