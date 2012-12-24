use strict;
use warnings;

use Test::More tests => 2;

diag 'This test can take 10-20 seconds, please wait. Started at ' . localtime;

my @out = qx{$^X -Ilib examples/callback.pl};
$_ =~ s/pid:\s*-?\d+/pid:/g for @out;
$_ =~ s/PID\s*-?\d+/PID/g for @out;
my @wait  = grep { /Have to wait for one children/ } @out;
@out = grep { !/Have to wait for one children/ } @out;
@out = sort @out;
cmp_ok scalar(@wait), '>', 10, 'Have to wait for one children at least 10 times';


my @expected = do { open my $fh, '<', 't/callback.txt'; <$fh> };
$_ =~ s/pid:\s*-?\d+/pid:/g for @expected;
$_ =~ s/PID\s*-?\d+/PID/g for @expected;
@expected = sort @expected;
is_deeply \@out, \@expected, 'callback worked' or diag explain @out;

