use strict;
use warnings;

use Test::More tests => 2;

use Parallel::ForkManager;

subtest 'classic' => sub {
    my @results;

    my $fm = Parallel::ForkManager->new(4);

    @results = ();

    $fm->run_on_finish(sub{ 
        push @results, @{$_[5]};
    });

    for ( 1..5 ) {
        $fm->start and next;
        $fm->finish(0, [ $_ ]);
    }

    $fm->wait_all_children;

    is_deeply [ sort @results ] => [ 1..5 ], 'get expected results';
};

subtest 'callback' => sub {
    my @results;

    my $fm = Parallel::ForkManager->new(4);

    @results = ();

    $fm->run_on_finish(sub{ 
        push @results, @{$_[5]};
    });

    for ( 1..5 ) {
        $fm->start_child(sub{
            return [ $_ ];
        });
    }

    $fm->wait_all_children;

    is_deeply [ sort @results ] => [ 1..5 ], 'get expected results';
};








