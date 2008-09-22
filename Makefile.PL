use 5.006002;
use ExtUtils::MakeMaker;

use File::Spec;

my $os;
if($^O eq "MSWin32") {
    $os = "XP_PC";
    $path_separator = ";";
} else {
    $os = "XP_UNIX";
}

my $lib_search_paths = "";
my $inc_search_paths = "";

if ($ENV{NSS_BASE}) {
    $lib_search_paths = "-L" . File::Spec->catdir($ENV{NSS_BASE}, "lib");
    $inc_search_paths = "-I" . File::Spec->catdir($ENV{NSS_BASE}, "include");
}

WriteMakefile(
    NAME            => 'NSS',
    VERSION_FROM    => 'lib/NSS.pm',
    PREREQ_PM       => {},
    ABSTRACT_FROM   => 'lib/NSS.pm',
    AUTHOR          => 'Claes Jakobsson <claesjac@cpan.org>',
    LIBS            => ["${lib_search_paths} -lnss3"],
    DEFINE          => "-D${os}", 
    INC             => "${inc_search_paths} -I.",
);
