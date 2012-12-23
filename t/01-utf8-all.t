use strict;
use warnings;

use Test::More;
use Parallel::ForkManager;

plan skip_all => 'This is a bug in perl itself on Windows' if $^O eq 'MSWin32';
# It is broken on 5.16.2 and on blead Perl:
# It was reported to the Perl 5 porters:
# http://www.nntp.perl.org/group/perl.perl5.porters/2012/12/msg196821.html

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

