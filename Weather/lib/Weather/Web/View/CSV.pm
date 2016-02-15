package Weather::Web::View::CSV;

use base qw ( Catalyst::View::CSV );
use strict;
use warnings;

__PACKAGE__->config (
	sep_char => ",",
	suffix => "csv",
#	charset => 'utf-8',
	binary => 1,
#	always_quote => 1,
	);


=head1 NAME

Weather::Web::View::CSV - CSV view for Weather

=head1 DESCRIPTION

CSV view for Weather

=head1 SEE ALSO

L<Weather>, L<Catalyst::View::CSV>, L<Text::CSV>

=head1 AUTHOR

HIRAYAMA, Ayano,U-jun\ayano,S-1-5-21-2431647466-285064000-64130578-1001

=head1 LICENSE

This library is free software . You can redistribute it and/or modify
it under the same terms as perl itself.

=cut

1;
