#!perl -T

use Test::More tests => 1;

BEGIN {
    use_ok( 'Class::Injector' ) || print "Bail out!
";
}

diag( "Testing Class::Injector $Class::Injector::VERSION, Perl $], $^X" );
