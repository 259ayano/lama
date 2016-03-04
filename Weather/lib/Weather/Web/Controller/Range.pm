package Weather::Web::Controller::Range;
use Moose;
use namespace::autoclean;
use CGI::Expand qw/expand_hash/;
use Data::Dumper;
use LWP::UserAgent;
use HTML::TreeBuilder;
use Data::Recursive::Encode;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

Weather::Web::Controller::Range - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;
	my $prec_tbl  = 'tsv/prec';
	my $block_tbl = 'tsv/block';
	my $url = 'http://www.data.jma.go.jp/obd/stats/etrn/view/monthly_s1.php?';
	my $param = expand_hash($c->req->params);
	my $search = $param->{search};
	my $prec_hint  = $search->{prec_hint}  || 50; # XXXXX 
	my $block_hint = $search->{block_hint} || 47656; # XXXXX 
	my @prec  = `grep -e $prec_hint $prec_tbl`;
	my @block = `grep -e $block_hint $block_tbl`;

	my %param = (
		prec_no => $prec_hint,
		block_no => $block_hint,
		year => $search->{year} || '2016',
		month => '',day => '',view => '',
		);

	my $ua  = LWP::UserAgent->new;

	my $temp = $url . join('&', map { "$_=$param{$_}" } keys %param);
	warn Dumper $temp;

	my $res = $ua->get($url . join('&', map { "$_=$param{$_}" } keys %param));
	my $con = $res->content;
	
	my $tree = HTML::TreeBuilder->new;
	$tree->parse($con);

	my $title;
	my @h3 = $tree->find('h3');
	next unless @h3;

	my $list;
	for my $tr ($tree->look_down('id','tablefix1')->find('tr')) {
		my $line;
#		$line->{prec}  = $prec_hint;
#		$line->{block} = $block_hint;
		push @$line, $_->as_text for ($tr->find('td'));
		push @$list, $line;
	}

	$c->stash->{prec_list} = \@prec;
	$c->stash->{block_list} = \@block;
    $c->stash->{list} = $list;
    $c->stash->{template} = 'range.tt';
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
