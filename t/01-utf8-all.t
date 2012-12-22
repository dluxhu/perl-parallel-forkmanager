use strict;
use warnings;

use Test::More;
use Parallel::ForkManager;

eval "use utf8::all";
plan skip_all => 'Need utf8::all for this test crashing on Windows' if ($@);
plan tests => 1;

my $fork = Parallel::ForkManager->new( 1 );
foreach (1) {
    my $pid = $fork->start and next;
	$fork->finish;
}
$fork->wait_all_children;

ok(1);

