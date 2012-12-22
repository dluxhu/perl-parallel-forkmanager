#!/usr/bin/perl
use strict;
use warnings;

if (not @ARGV) {
  die <<"DIE";
Usage: $0  URL URL...
 e.g.: $0 http://cpan.metacpan.org/authors/id/D/DL/DLUX/Parallel-ForkManager-0.7.9.tar.gz
DIE
}

use Parallel::ForkManager;
use LWP::Simple;

my $pm = Parallel::ForkManager->new(10);

for my $link (@ARGV) {
  $pm->start and next;

  my ($fn) = $link =~ /^.*\/(.*?)$/;

  if (!$fn) {
    warn "Cannot determine filename from $fn\n";
  } else {
    $0 .= " $fn";
    print "Getting $fn from $link\n";
    my $rc = getstore($link, $fn);
    print "$link downloaded. response code: $rc\n";
  };

  $pm->finish;
};
