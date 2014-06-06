#!/usr/bin/perl
use strict;

my $a = "# -*- mode: perl; coding: utf-8; -*-\n";

=try1

#追記はできるんだけど、ファイルの最後に追記されちゃう。
my @files = `ls *.pl`;

for(@files){
    open (PERL_FILE,">> $_") || die("失敗しちゃいました。");    
    print PERL_FILE "\n$a";
    close(PERL_FILE);
}

=cut

=test
my @files = `ls *.pl`;

for(@files){
    open (PERL_FILE,"$_") || die("失敗しちゃいました。");    
    my @file = <PERL_FILE>;
    close(PERL_FILE);

    for (@file){
	print;
    }
}
=cut

# http://perldoc.jp/docs/perl/5.6.1/perlrun.pod
# かっこ良い次のようなやり方もあるけど、少し難しいかもしれないね。
# 
# #!/usr/bin/perl -pi
# print "# -*- mode: perl; coding: utf-8; -*-\n" if $. == 2;

# 改良として、次のようなことを考えてみるのもいいかもしれません。
# 1. 対象のファイルをコマンドラインの引数として与えるようする
# 2. すでに対象の行が存在する場合には、何もしない

my @files = `ls *.pl`;

for (@files){
    chomp;
    my $baseFile = $_;
    my $tempfile = "temp$_";
    open( OLD, "< $baseFile");
    open( NEW, "> $tempfile");
    while( <OLD> ){
print NEW $_;
print NEW $a if($. == 4);
    }
    close(OLD);
    close(NEW);
    
    print "mv $tempfile $baseFile", "\n";

}
