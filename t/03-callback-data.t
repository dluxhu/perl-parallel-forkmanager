use strict;
use warnings;

use Test::More 0.94 tests => 2;
use File::Temp qw(tempdir);

diag 'This test can take 2-6 seconds, please wait. Started at ' . localtime;


my @expected = do { open my $fh, '<', 't/callback_data.txt'; <$fh> };
@expected = sort @expected;


subtest direct => sub {
	my @out = sort qx{$^X -Ilib examples/callback_data.pl};
	is_deeply \@out, \@expected, 'callback_data worked' or diag explain @out;
};

subtest tempdir => sub {
	my $dir = tempdir( CLEANUP => 1 );
	my $tempdir = "$dir/abc";
	mkdir $tempdir;
	my @out = sort qx{$^X -Ilib examples/callback_data.pl $tempdir};
	is_deeply \@out, \@expected, 'callback_data worked' or diag explain @out;
	ok -d $tempdir, 'tempdir was left there';
};



