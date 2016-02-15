package Weather::Web::View::TT;
use Moose;
use namespace::autoclean;

extends 'Catalyst::View::TT';

__PACKAGE__->config(
    TEMPLATE_EXTENSION => '.tt',
    render_die => 1,
);

=head1 NAME

Weather::Web::View::TT - TT View for Weather

=head1 DESCRIPTION

TT View for Weather.

=head1 SEE ALSO

L<Weather>

=head1 AUTHOR

HIRAYAMA, Ayano,U-jun\ayano,S-1-5-21-2431647466-285064000-64130578-1001

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
