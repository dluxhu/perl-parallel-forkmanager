use strict;
use warnings;

use Test::More tests => 1;

use Parallel::ForkManager;

my $pm = Parallel::ForkManager->new(2);

$pm->set_waitpid_blocking_sleep(5);
my $start = time;

for(1) {
    $pm->start and last;
    sleep 1;
    $pm->finish;
}

$pm->wait_one_child;

# if the sleep works correctly, we shouldn't
# check if the child is gone before 5 seconds
# in the future

cmp_ok abs( 5 - time + $start ), '<=', 2;






