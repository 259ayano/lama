use strict;
use warnings;
use Test::More;


use Catalyst::Test 'Oa::Buying';
use Oa::Buying::Controller::Mainte;

ok( request('/mainte')->is_success, 'Request should succeed' );
done_testing();
