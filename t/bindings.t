package A;

use warnings;
use strict;
use Class::Injector;

sub make_A : Inject("b") {
  my $class = shift;
  my $arg = shift;
  return bless { argument => $arg }, $class;
}

sub make_B : Inject("x") {
  my $class = shift;
  my $arg = shift;
  return bless { argument => $arg }, $class;
}

package Bindings;

use warnings;
use strict;
use Class::Injector;

Class::Injector->bind('A'); # defaults to A->new();
Class::Injector->bind('A')->to('make_A'); # defaults to A->make_A("a");
Class::Injector->bind('B')->to(A => 'make_B'); # A->make_b("x");

use warnings;
use strict;
use Test::More qw(no_plan);

is_deeply( Class::Injector->get('A'), bless { argument => 'b' }, 'A' );
is_deeply( Class::Injector->get('B'), bless { argument => 'x' }, 'A' );
