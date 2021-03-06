#!/usr/bin/perl
use strict;

{ package Animal;
  sub speak {
      my $class = shift;
      print "a $class goes ", $class->sound, "!\n";
  }
}
{ package Cow;
  our @ISA = qw(Animal);
  sub sound { 'Moooo' }
}
{ package Horse;
  our @ISA = qw(Animal);
  sub sound { 'heeeeen' }
}
{ package Sheep;
  our @ISA = qw(Animal);
  sub sound { 'meeeeeee' }
}
{ package Mouse;
  our @ISA = qw(Animal);
  sub sound { 'cho-cho-' }
  sub speak {
      my $class = shift;
      $class->SUPER::speak;
      print "[but you can barely hear it!]\n";
  }
    
}

print "Please input c(Cow) or h(Horse) or s(Sheep) or m(Mouse)\n";
chomp( my @animals = <STDIN>);

for ( @animals ){
    my $animal = 
	/^c+$/i ? "Cow" : 
	/^h+$/i ? "Horse" : 
	/^S+$/i ? "Sheep" :
	/^m+$/i ? "Mouse" :
	"Other";
    
    if ( $animal eq "Other" ){
	print "Please input correct animal.";
    }else{
	$animal->speak;
    }
}
