use strict;
use warnings;

use Oa::Buying;

my $app = Oa::Buying->apply_default_middlewares(Oa::Buying->psgi_app);
$app;

