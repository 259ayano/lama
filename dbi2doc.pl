#!/usr/bin/perl;
use common::sense;

while(<>){

	if ($_ =~ /^\s*(sub.*csv)/){
		print $1,"\n";
	}
	if ($_ =~ /^\t{2,}('.*'),/){
		next if /join/;
		print $1,"\n";
	}

}


=memo
csv(�󔭒�/����̈ꗗ,���i�̈ꗗ)�̍��ڂ𔲂��o���܂��B
������DBI.pm ��^���Ă��������B
�h�L�������g�쐬�p
=cut
