use strict;
use warnings;

use Test::More tests => 1;

diag 'This test can take 2-6 seconds, please wait. Started at ' . localtime;

my @out = qx{$^X -Ilib examples/callback_data.pl};
@out = sort @out;

my @expected = do { open my $fh, '<', 't/callback_data.txt'; <$fh> };
@expected = sort @expected;
is_deeply \@out, \@expected, 'callback_data worked' or diag explain @out;

