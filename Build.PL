# git ls-files lib | xargs perl-reversion -bump
# perl Build.PL && ./Build manifest && ./Build test && ./Build dist
# cpan-upload `ls Test-Aggregate-*.tar.gz | tail -n1`
# git tag `awk '/^version: / { print " -a " $2 " -m " $2 }' META.yml` && git push && git push --tags

use strict;
use warnings;
use Module::Build;

use 5.006;

my $builder = Module::Build->new(
    module_name       => 'Test::Aggregate',
    license           => 'perl',
    dist_author       => 'Curtis "Ovid" Poe <ovid@cpan.org>',
    dist_version_from => 'lib/Test/Aggregate.pm',
    build_requires    => {
        'Test::Simple' => 0.94,    # we fail on the common 0.62
        'Test::Most'   => 0.21,
        'Test::Trap'   => 0,
    },
    requires => {
        'Test::Harness'    => 3.09,
        'Test::NoWarnings' => 0,
        'FindBin'          => 1.47,
    },
    recommends => {
        'Data::Dump::Streamer' => 1.11,
        'Perl::Tidy'           => 20060614,
        'Test::More'           => '0.94',
    },
    meta_merge =>
    {
        resources =>
        {
            repository => "https://github.com/rwstauner/test-aggregate",
        },
        x_contributors => [
          'Curtis "Ovid" Poe <ovid@cpan.org>',
          'Florian Ragwitz <flora@cpan.org>',
          'Shlomi Fish <shlomif@cpan.org>',
          'Randy Stauner <rwstauner@cpan.org>',
        ],
    },
    add_to_cleanup     => ['Test-Aggregate-*'],
    create_makefile_pl => 'traditional',
);

$builder->create_build_script();
