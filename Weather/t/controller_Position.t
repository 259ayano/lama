use strict;
use warnings;
use Test::More;


use Catalyst::Test 'Weather';
use Weather::Controller::Position;

ok( request('/position')->is_success, 'Request should succeed' );
done_testing();
