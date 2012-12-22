use strict;
use warnings;

use Test::More tests => 3;
use Parallel::ForkManager;
use File::Temp qw(tempdir);

ok(1, 'loaded');


my @numbers = (1 .. 20);

is_deeply count(1), \@numbers, 'count 1';
is_deeply count(3), \@numbers, 'count 3';



sub count {
    my ($concurrency) = @_;

    my $dir = tempdir(CLEANUP => 1);

    my $fork = Parallel::ForkManager->new( $concurrency );
    foreach my $n (@numbers) {
	    my $pid = $fork->start and next;
        #diag $n;
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

