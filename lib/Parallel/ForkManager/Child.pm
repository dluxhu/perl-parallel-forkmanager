package Parallel::ForkManager::Child;

use strict;
use warnings;

use Carp;
use Storable qw(store);

use Moo;

extends 'Parallel::ForkManager';

sub in_child { 1 }
sub is_child { 1 }
sub is_parent { 0 }

sub start {
    croak "Cannot start another process while you are in the child process";
}

sub finish {
  my ($s, $x, $r)=@_;

    if (defined($r)) {  # store the child's data structure
      my $storable_tempfile = File::Spec->catfile($s->{tempdir}, 'Parallel-ForkManager-' . $s->{parent_pid} . '-' . $$ . '.txt');
      my $stored = eval { return &store($r, $storable_tempfile); };

      # handle Storables errors, IE logcarp or carp returning undef, or die (via logcroak or croak)
      if (not $stored or $@) {
        warn(qq|The storable module was unable to store the child's data structure to the temp file "$storable_tempfile":  | . join(', ', $@));
      }
    }

    CORE::exit($x || 0);
}

1;
