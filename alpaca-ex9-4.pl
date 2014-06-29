#!usr/bin/perl
use common::sense;
use IO::Dir;

chomp(my $dir = <STDIN>);

&viewDir($dir);

sub viewDir(){
    my $name = shift;
    opendir(DIR, $name);
    my @dir = readdir(DIR);
    closedir(DIR);
    for my $file(@dir){
	if (-d $file){
	    next if ($file =~ /^.+$/);
	    print "$file\n";
	    &viewDir($dir."/".$file);
	}else{
	    print "  $file\n"
	}

    }
}
