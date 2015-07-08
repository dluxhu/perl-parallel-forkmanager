use strict;
use warnings;

use Test::More;

use Parallel::ForkManager;

my $pm = Parallel::ForkManager->new(4);

local $SIG{ALRM} = sub {
    fail "test hanging, forever waiting for child process";
    exit 1;
};

for ( 1 ) {
    $pm->start and next;
    sleep 2;
    $pm->finish;
}

my $pid = waitpid -1, 0;

diag "code outside of P::FM stole $pid";

TODO: {
    local $TODO = 'MacOS and FreeBDS seem to have issues with this';

    eval {
        alarm 10;
        $pm->wait_all_children;
        pass "wait_all_children terminated";
    };

    is $pm->running_procs => 0, "all children are accounted for";

}

done_testing;
