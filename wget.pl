#!/usr/bin/perl

use Data::Dumper;

#my @HTTP  = ('https://www.monita-web.com/yazaki/login-admin');
my @HTTP  = ('https://www.googlayabo.co.jp');
my @add = qw/super_green77777@yahoo.co.jp/;     # 監視メール対象アドレス

for my $http (@HTTP){
	#  write all log
	`wget --user=mgr --password=jimas -o log/http_all.log ${http}`;
	
	my $err = `wget --user=mgr --password=jimas -q -O /dev/null ${http} || echo "${http} : NG"`;

	warn Dumper $err;
	
	#  send mail
	if ($err) {
		unless (-f "log/${now}_http.lock"){
			`echo $http : NG | mail -s "$http access NG" $_ > log/http.log` for (@add);
			`touch log/${now}_http.lock`;
		}
	}else{
		if (-f "log/${now}_http.lock"){
			`echo $http : RECOVERY | mail -s "$http access RECOVERY" $_ > log/http.log` for (@add);
			`rm -f log/*_http.lock`
		}
	}
}

