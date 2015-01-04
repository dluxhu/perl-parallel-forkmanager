use strict;
use warnings;

use Test::More;
use Parallel::ForkManager;

plan tests => 2;

my $fork = Parallel::ForkManager->new( 1 );
is $fork->get_max_procs, 1;
$fork->set_max_procs( 2 );
is $fork->get_max_procs, 2;
