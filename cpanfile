requires "Carp" => "0";
requires "File::Path" => "0";
requires "File::Spec" => "0";
requires "File::Temp" => "0";
requires "POSIX" => "0";
requires "Storable" => "0";
requires "strict" => "0";

on 'test' => sub {
  requires "ExtUtils::MakeMaker" => "0";
  requires "File::Spec" => "0";
  requires "IO::Handle" => "0";
  requires "IPC::Open3" => "0";
  requires "Test::More" => "0.94";
  requires "Test::Warn" => "0";
  requires "perl" => "5.006";
  requires "warnings" => "0";
};

on 'test' => sub {
  recommends "CPAN::Meta" => "2.120900";
};

on 'configure' => sub {
  requires "ExtUtils::MakeMaker" => "0";
};

on 'develop' => sub {
  requires "Test::More" => "0.96";
  requires "Test::PAUSE::Permissions" => "0";
  requires "Test::Vars" => "0";
  requires "warnings" => "0";
};
