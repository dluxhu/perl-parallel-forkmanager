#!/usr/bin/perl
use strict;
use warnings;

use Parallel::ForkManager;

my $max_procs = 2;
my @names = qw( Fred Jim );

my $pm = Parallel::ForkManager->new($max_procs, @ARGV);

# Setup a callback for when a child finishes up so we can
# get it's exit code and any data it collected
$pm->run_on_finish( sub {
  my ($pid, $exit_code, $ident, $exit_signal, $core_dump, $data_structure_reference) = @_;
  print "$ident just got out of the pool ".
    "with exit code: $exit_code and data: @$data_structure_reference\n";
});

$pm->run_on_start( sub {
  my ($pid,$ident)=@_;
  print "$ident started\n";
});

foreach my $child ( 0 .. $#names ) {
  my $pid = $pm->start($names[$child]) and next;

  # This code is the child process
  # We can do here anything and obtain any data.
  # The result can be any array or hash.
  my @result = ($names[$child], length $names[$child]);
  sleep 1+rand(3);

  # pass an exit code and data stucture to finish
  $pm->finish($child, \@result );
}

#print "Waiting for Children...\n";
$pm->wait_all_children;
print "Everybody is out of the pool!\n";


