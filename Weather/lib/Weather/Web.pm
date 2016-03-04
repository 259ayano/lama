package Weather::Web;
use Moose;
use namespace::autoclean;
use Data::Dumper;

use Catalyst::Runtime 5.80;

# Set flags and add plugins for the application.
#
# Note that ORDERING IS IMPORTANT here as plugins are initialized in order,
# therefore you almost certainly want to keep ConfigLoader at the head of the
# list if you're using it.
#
#         -Debug: activates the debug mode for very useful log messages
#   ConfigLoader: will load the configuration from a Config::General file in the
#                 application's home directory
# Static::Simple: will serve static files from the application's root
#                 directory

use Catalyst qw/
    -Debug
    ConfigLoader
    Static::Simple
/;

extends 'Catalyst';

our $VERSION = '0.01';

# Configure the application.
#
# Note that settings in weather_web.conf (or other external
# configuration file that you set up manually) take precedence
# over this when using ConfigLoader. Thus configuration
# details given here can function as a default configuration,
# with an external configuration file acting as an override for
# local deployment.

__PACKAGE__->config(
    name => 'Weather::Web',
    # Disable deprecated behavior needed by old applications
    disable_component_resolution_regex_fallback => 1,
    enable_catalyst_header => 1, # Send X-Catalyst header
    default_view => 'TT',
);

# Start the application
__PACKAGE__->setup();

my @monthly = qw/month kiatsu1 kiatsu2 rain_sum rain_d_max rain_h_max rain_10_max
                     temp_d_ave temp_d_max temp_d_min temp_max temp_min
                     wet_ave wet_min wind_ave wind_max1 wind_max_dir1
                     wind_max2 wind_max_dir2 sun1 sun2 snow_sum snow_sum_max snow_max
                     cloud_ave snow_day mist_day Thunder_day/;
my @daily   = qw/day kiatsu1 kiatsu2 rain_sum rain_h_max rain_10_max
                     temp_d_ave temp_d_max temp_d_min wet_ave wet_min wind_ave
                     wind_max1 wind_max_dir1 wind_max2 wind_max_dir2 sun
                     snow_sum snow_max tenki tenki_n/;
my @hourly  = qw/hour kiatsu1 kiatsu2 rain temp roten jyoki wet wind wind_dir
                     sun1 sun2 snow1 snow2 tenki cloud see/;

my $block_tbl = "tsv/block";
my $prec_tbl  = "tsv/prec";

sub pdata {
	my ($class,$p) = @_;
    my @prec  = `grep -e $p $prec_tbl`;
	@prec;
}

sub bdata {
	my ($class,$prec_code,$b) = @_;
	my @block;
	if ($b ne ''){
		my @b1   = `grep -e ',$prec_code,$b' $block_tbl`;
		my @b2   = `grep -e '$b,$prec_code,' $block_tbl`;
		@block = (@b1,@b2);
	} else {
		@block   = `grep -e ',$prec_code,' $block_tbl`;
	}
	@block;
}

sub gettype {
	my ($class,$y,$m,$d) = @_;
    my $type = $y && $m && $d ? 'hourly' : $y && $m ? 'daily' : $y ? 'monthly' : '';
    my @key = $type eq 'hourly' ? @hourly :
		      $type eq 'daily'  ? @daily  : $type eq 'monthly' ? @monthly  : ();
	
	$type,\@key;
}

sub getjma {
	my ($class,$p_code,$b_code,$y,$m,$d,$type) = @_;
	my $url = "http://www.data.jma.go.jp/obd/stats/etrn/view/${type}_s1.php?";
	my %param = (
		prec_no => $p_code,
		block_no => $b_code,
		year => $y || '2016',
		month => $m,
		day => $d,
		view => '',
		);

	my $ua  = LWP::UserAgent->new;
	my $res = $ua->get($url . join('&', map { "$_=$param{$_}" } keys %param));
	my $con = $res->content;
	$con;
}
=encoding utf8

=head1 NAME

Weather::Web - Catalyst based application

=head1 SYNOPSIS

    script/weather_web_server.pl

=head1 DESCRIPTION

[enter your description here]

=head1 SEE ALSO

L<Weather::Web::Controller::Root>, L<Catalyst>

=head1 AUTHOR

HIRAYAMA, Ayano,U-jun\ayano,S-1-5-21-2431647466-285064000-64130578-1001

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
