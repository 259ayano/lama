use strict;
use warnings;
use Test::More;


use Catalyst::Test 'Weather';
use Weather::Controller::Data;

ok( request('/data')->is_success, 'Request should succeed' );
done_testing();
