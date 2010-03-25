package MyClass;

use warnings;
use strict;
use Class::Injector;

sub new {
  return bless {}, $_[0];
}

package main;

use warnings;
use strict;
use Test::More tests => 1;

my $injector = Class::Injector->new();

my $my_class = $injector->get('MyClass');

isa_ok($my_class, 'MyClass');

