package Weather::Web::Controller::Position;
use Moose;
use namespace::autoclean;
use CGI::Expand qw/expand_hash/;
use Data::Dumper;
use LWP::UserAgent;
use HTML::TreeBuilder;
use List::MoreUtils qw/uniq/;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

Weather::Web::Controller::Position - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;
	my $params = expand_hash($c->req->params);
	my $hint = $params->{search}{hint} || '静岡';
	my $position = $params->{p};

	my $url = "http://www.yr.no/soek/soek.aspx?sted=$hint";
	my $ua  = LWP::UserAgent->new;
	my $res = $ua->get($url);
	my $con = $res->content;

	my $tree = HTML::TreeBuilder->new;
	$tree->parse($con);
	my $id = 'ctl00_contentBody';
	my %href = map {$_->attr('title'),$_->attr('href')} $tree->look_down('id',$id)->find('a');

	
	$c->stash->{search}   = $params->{search};
	$c->stash->{href}     = \%href;
	$position =~ s/\/sted\/(.+)/$1/;
	$c->stash->{position} = $position;
    $c->stash->{template} = 'position.tt';
}



=encoding utf8

=head1 AUTHOR

HIRAYAMA, Ayano,U-jun\ayano,S-1-5-21-2431647466-285064000-64130578-1001

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
