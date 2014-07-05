#!/usr/bin/perl
use strict;
use Getopt::Std;

{ package LivingCreature;
  sub speak {
      my $class = shift;
      if ( @_ ){
	  print "a $class goes @_ !\n";	  
      }else{
	  print "a $class goes ", $class->sound, "!\n";	  
      }
  }
}

{ package Animal;
  our @ISA = qw(LivingCreature);
}

{ package Person;
  our @ISA = qw(LivingCreature);
  sub sound { 'Oh,Yes' }
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

print "Please input c(Cow) or h(Horse) or s(Sheep) or m(Mouse) or p(Person)\n";
chomp( my @creatures = <STDIN>);
our %opts;
getopts('c:',\%opts);

for ( @creatures ){
    my $c = 
	/^c+$/i ? "Cow" : 
	/^h+$/i ? "Horse" : 
	/^S+$/i ? "Sheep" :
	/^m+$/i ? "Mouse" :
	/^p+$/i ? "Person" :
	"Other";
    
    if ( $c eq "Other" ){
	print "Please input correct Creature.";
    }else{
	$c->speak($opts{c});
    }
}
