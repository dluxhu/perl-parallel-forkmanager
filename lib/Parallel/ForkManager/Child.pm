package Parallel::ForkManager::Child;
# ABSTRACT: role adopted by forked Parallel::ForkManager processes 

=head1 SYNOPSIS 

   use 5.10.0;

   use Parallel::ForkManager;

   my $fm = Parallel::ForkManager->new;

   say "parent does not consume the child role: ", $fm->does('Parallel::ForkManager::Child');

   $fm->start_child(sub{ 
        sleep $_;
        say "but the child does: ", $fm->does('Parallel::ForkManager::Child');
        say "child $_ says hi!"

   }) for 1..3;


=head1 DESCRIPTION 

When the parent L<Parallel::ForkManager> object forks a child process,
its forked incarnation consumes this role. The role doesn't do much: it 
changes the returning values of C<is_child> and C<is_parent> in the way you'd expect,
change C<start> so that it'd die if called from within the child, and change 
the implementation of C<finish> to potentially send data back to the parent process.

=cut
    

use strict;
use warnings;

use Carp;

use Moo::Role;

sub is_child  { 1 }
sub is_parent { 0 }

sub start {
    croak "Cannot start another process while you are in the child process";
}

sub finish {
  my ($s, $x, $r)=@_;

  $s->store($r);

    CORE::exit($x || 0);
}

1;
