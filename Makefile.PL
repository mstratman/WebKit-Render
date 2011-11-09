use 5.006;
use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME                => 'WebKit::Render',
    AUTHOR              => q{Mark A. Stratman <stratman@gmail.com>},
    VERSION_FROM        => 'lib/WebKit/Render.pm',
    ABSTRACT_FROM       => 'lib/WebKit/Render.pm',
    ($ExtUtils::MakeMaker::VERSION >= 6.3002
      ? ('LICENSE'=> 'perl')
      : ()),
    PL_FILES            => {},
    PREREQ_PM => {
        'Test::More' => 0,
    },
    dist                => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean               => { FILES => 'WebKit-Render-*' },
);
