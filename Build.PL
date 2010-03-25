use strict;
use warnings;
use Module::Build;

my $builder = Module::Build->new(
    module_name         => 'Class::Injector',
    license             => 'gpl',
    dist_author         => q{Josh McAdams <joshua.mcadams@gmail.com>},
    dist_version_from   => 'lib/Class/Injector.pm',
    build_requires => {
        'Test::More' => 0,
    },
    add_to_cleanup      => [ 'Class-Injector-*' ],
    create_makefile_pl => 'traditional',
);

$builder->create_build_script();
