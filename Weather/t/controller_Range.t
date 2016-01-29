use strict;
use warnings;
use Test::More;


use Catalyst::Test 'Weather';
use Weather::Controller::Range;

ok( request('/range')->is_success, 'Request should succeed' );
done_testing();
