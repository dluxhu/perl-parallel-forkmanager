use strict;
use warnings;

use Test::More tests => 1;

my @out = qx{$^X -Ilib examples/callback.pl};
$_ =~ s/pid:\s*\d+/pid:/g for @out;
$_ =~ s/PID\s*\d+/PID/g for @out;


my @expected = do { open my $fh, '<', 't/callback.txt'; <$fh> };
$_ =~ s/pid:\s*\d+/pid:/g for @expected;
$_ =~ s/PID\s*\d+/PID/g for @expected;
is_deeply \@out, \@expected, 'callback worked';

# The lists might need to be sorted before comparing.

