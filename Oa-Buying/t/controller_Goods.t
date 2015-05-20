use strict;
use warnings;
use Test::More;


use Catalyst::Test 'Oa::Buying';
use Oa::Buying::Controller::Goods;

ok( request('/goods')->is_success, 'Request should succeed' );
done_testing();
