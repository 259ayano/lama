package Oa::Buying::Controller::Estimate;
use Moose;
use namespace::autoclean;
BEGIN { extends 'Catalyst::Controller'; }

use utf8;
use Encode;
use Time::Piece;
use Time::Seconds;
use CGI::Expand qw/expand_hash/;
use Text::CSV;
use List::MoreUtils qw/uniq/;
use Data::Dumper;
use File::Basename;

=head1 NAME

Oa::Buying::Controller::Estimate - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;
	$c->stash->{template} = 'estimate.tt';

}

sub edit :Local {
    my ( $self, $c ) = @_;
#	my $db = Alife::DBI->connect;
	my $param = expand_hash($c->req->params);
	my $code = $param->{code};
	my $message;

	# insert or update for ORDERS
	if ($param->{type} eq 'commit') {

		my $r = {
			orderh => $param->{orderh},
			orderb => $param->{orderb},
			#updated_by => $c->session->{user},
		};

		$c->form($c->config->{rule}{order});
		if ($c->form->has_error) {
			$c->flash->{error} = $c->form;
		} else {
			delete $c->flash->{error};
			$code = $r->{orderh}{code};
#			($code, $message) = $db->create_order($r);
		}

	} else {
#		delete $c->flash->{error}; #XXX
	}

	# set default datas
	if ($code) {

        # remove data for copy
		if ($param->{type} eq 'copy') {

			my %orderh = %{$param->{orderh}};
			my @orderb = map { defined($_) ? $_ : ()} @{$param->{orderb}};
			$orderh{twins} = $orderh{code};
			my @remove = qw /code xmonth closed state updated_on updated_by created_on created_by/;
			map $orderh{$_} = '' , @remove;
			my $ob = [ map { $_->{code} = ''; { orderb => $_ } } @orderb ];
			$c->stash->{orderh} = \%orderh;
			$c->stash->{ob} = $ob;

		}else{

=x
			my $oh = $db->select_orderh({ 'orderh.code' => $code })->one;
			$c->stash(expand_hash $oh);
=cut
		}
	}

    $c->stash->{history} = ['75','76','77'];
    $c->stash->{success} = $message;
    $c->stash->{template} = 'estimate-edit.tt';

}


=encoding utf8

=head1 AUTHOR

HIRAYAMA Ayano

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
