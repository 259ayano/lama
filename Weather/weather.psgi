use strict;
use warnings;

use Weather;

my $app = Weather->apply_default_middlewares(Weather->psgi_app);
$app;

