use strict;
use warnings;

use Test::More tests => 4;
use Parallel::ForkManager;
use File::Temp qw(tempdir);

my @numbers = (1 .. 20);

for my $processes ( 1, 3 ) {
    for my $pseudo_block ( 0, 1 ) {
        my $chrono = time;
        is_deeply count($processes,$pseudo_block) => \@numbers,
            "procs: $processes, pseudo-block: $pseudo_block";
        $chrono = time - $chrono;
        diag "time: $chrono seconds";
    };
}


sub count {
    my ($concurrency,$blocking_time) = @_;

    my $dir = tempdir(CLEANUP => 1);

    my $fork = Parallel::ForkManager->new( $concurrency );
    $fork->set_waitpid_blocking_sleep( $blocking_time );

    foreach my $n (@numbers) {
	    my $pid = $fork->start and next;
        open my $fh, '>', "$dir/$n" or die;
        close $fh or die;
	    $fork->finish;
    }
    $fork->wait_all_children;
    opendir my $dh, $dir or die;
    my @results = grep { $_ !~ /\./ } readdir $dh;
    closedir $dh or die;
    return [sort {$a <=> $b} @results];
}

