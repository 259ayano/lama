package Oa::Buying::View::TT;
use Moose;
use namespace::autoclean;

extends 'Catalyst::View::TT';

__PACKAGE__->config(
    TEMPLATE_EXTENSION => '.tt',
    render_die => 1,
);

=head1 NAME

Oa::Buying::View::TT - TT View for Oa::Buying

=head1 DESCRIPTION

TT View for Oa::Buying.

=head1 SEE ALSO

L<Oa::Buying>

=head1 AUTHOR

HIRAYAMA Ayano

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
