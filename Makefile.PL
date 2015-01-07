use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.

system qq{$^X -MPod::Text -e "pod2text(q(lib/Parallel/ForkManager.pm))" > README};
WriteMakefile(
    NAME	      => 'Parallel::ForkManager',
    VERSION_FROM  => 'lib/Parallel/ForkManager.pm', # finds $VERSION
    ABSTRACT_FROM => 'lib/Parallel/ForkManager.pm',
    AUTHOR        => 'Balazs Szabo (dLux)',
    LICENSE       => 'perl',
    PREREQ_PM     => {
           'POSIX'          => 0,
           'Storable'       => 0,
           'File::Spec'     => 0,
           'File::Temp'     => 0,
           'File::Path'     => 2.0,
    },
    BUILD_REQUIRES => {
           'Test::More'     => '1.001',
    },
    META_MERGE        => {
		'meta-spec' => { version => 2 },
		resources => {
			repository => {
				type       => 'git',
				url        => 'https://github.com/dluxhu/perl-parallel-forkmanager.git',
				web        => 'https://github.com/dluxhu/perl-parallel-forkmanager',
				license    => 'http://dev.perl.org/licenses/',
			},
       },
       x_contributors => [
           'SZABGAB',
           'YANICK',
           'Michael Gang',
           'Noah Robin <sitz@onastick.net>',
           'Chuck Hirstius <chirstius@megapathdsl.net>',
           'Grant Hopwood <hopwoodg@valero.com>',
           'Mark Southern <mark_southern@merck.com>',
           'Ken Clarke <www.perlprogrammer.net>',
       ],
    },
    dist => {
      PREOP => $^X.' -MPod::Text -e "pod2text(q(lib/Parallel/ForkManager.pm))" > README'
    }
);
