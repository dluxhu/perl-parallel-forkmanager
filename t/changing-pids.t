use strict;
use warnings;

use Test::More tests => 1;
use Parallel::ForkManager;

my $data;

my $inner = Parallel::ForkManager->new(1);
$inner->run_on_finish(sub{ $data = $_[5]; });

my $outer = Parallel::ForkManager->new(1);
$outer->run_on_finish(sub{ $data = $_[5]; });

unless( $outer->start ) {
    unless( $inner->start ) {
        $inner->finish( 0, [ 'yay' ] );
    }
    $inner->wait_all_children;

    $outer->finish(0, $data );
}

$outer->wait_all_children;

ok $data, "received reference";
