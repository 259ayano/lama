#!usr/bin/perl
use common::sense;

=Q1
my $input = "beforematchafter";

if ($input =~ /(match)/) {
    print "Matched: |$`<$&>$'|\n";
    print "    And memory one got <$1>\n";
    # print "    And memory two got <$2>\n";
} else {
    print "No match.\n";
}
=cut

my @words = <DATA>;
=Q2
for(@words){
    if (/a$/) {
	print "Matched: |$`<$&>$'|\n";
    } else {
	print "No match.\n";
    }
}
=cut

=Q3
for(@words){
    if (/(.*a)$/) {
	print "\$1 is '$1'\n";
    } else {
	print "No match.\n";
    }
}
=cut

=Q4
my $key = "word";
for(@words){
    if (/(?<$key>.*a)$/) {
	print "$key is $+{$key}\n";
    } else {
	print "No match.\n";
    }
}
=cut

#Q5
for(@words){
    if (/^(.*a)(.{0,5})$/) {
	print "$1 : $2\n";
    } else {
	print "No match.\n";
    }
}



__DATA__
Mrs. Wilma Filintstone
wilma&fred
Fred
Nao
frederick
Alfred
Ayano
minako
Mr.Fred
Mr.Masato
FRED
Mississippi
Bamm-Bamm
lama
\\**
barney \\\***
*wilma\  　
\*ayano
wilma
barney
ayano
suruga 
kai
