use strict;
use warnings;

use Test::More tests => 10;

use Parallel::ForkManager;

my $pm = Parallel::ForkManager->new(4);

for(1..3) {
    $pm->start("proc $_") and next;
    sleep $_;
    $pm->finish;
}

my $nbr = $pm->running_procs;
my @pids = $pm->running_procs;
my %pwi = $pm->running_procs_with_identifiers;

is_deeply(
  [ sort keys %pwi ],
  [ sort @pids ],
  "running_procs_with_identifiers keys are pids",
);

is_deeply(
  [ sort values %pwi ],
  [ "proc 1", "proc 2", "proc 3" ],
  "running_procs_with_identifiers values are as expected",
);

is $pm->max_procs => 4, 'max procs is 4';

is $nbr => 3, '3 children';

is scalar(@pids) => 3, '3 children';

# on Windows they'll be negative
like $_ => qr/^-?\d+$/, "looks like a pid" for @pids;

$pm->wait_for_available_procs(3);

is $pm->running_procs => 1, 'only one process left';

$pm->wait_all_children;

is $pm->running_procs => 0, "all done";




