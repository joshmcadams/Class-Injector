package MyClass;

use warnings;
use strict;
use Class::Injector;

sub new {
  return bless {}, $_[0];
}

package MyOtherClass;

sub new : Inject(MyClass) {
  my $self = bless {}, $_[0];
  $self->{my_class} = $_[1];
  return $self;    
}

package main;

use warnings;
use strict;
use Test::More tests => 2;

my $injector = Class::Injector->new();

my $my_other_class = $injector->get('MyOtherClass');

isa_ok($my_other_class, 'MyOtherClass');
isa_ok($my_other_class->{my_class}, 'MyClass');

