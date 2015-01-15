use strict;
use warnings;

use Test::More tests => 1;                      # last test to print

use Parallel::ForkManager;

my $pm = Parallel::ForkManager->new(4);

local $SIG{ALRM} = sub {
    fail "test hanging, forever waiting for child process";
    exit;
};
alarm 10;

for ( 1..4 ) {
    $pm->start and next;
    sleep 2;
    $pm->finish;
}

my $pid = waitpid -1, 0;

diag "code outside of P::FM stole $pid";

$pm->wait_all_children;

pass "all children are accounted for";
