package Class::Injector;

use warnings;
use strict;

use Attribute::Handlers;
use Module::Load;

sub UNIVERSAL::Inject :ATTR(RAWDATA) {
  my ($package, $symbol, $referent, $attr, $data, $phase, $filename, $linenum) = @_;
  #print "$data\n";
}

sub new {
  return bless {}, $_[0];
}

sub get {
  my ($self, $target) = @_;

  die 'target must be specified' unless defined $target;

  load $target if (not defined $main::{$target . '::'});

  return $target->new();
}

=head1 NAME

Class::Injector - The great new Class::Injector!

=head1 VERSION

Version 0.01

=cut

our $VERSION = '0.01';


=head1 SYNOPSIS

Quick summary of what the module does.

Perhaps a little code snippet.

    use Class::Injector;

    my $foo = Class::Injector->new();
    ...

=head1 EXPORT

A list of functions that can be exported.  You can delete this section
if you don't export anything, such as for a purely object-oriented module.

=head1 SUBROUTINES/METHODS

=head2 function1

=cut

sub function1 {
}

=head2 function2

=cut

sub function2 {
}

=head1 AUTHOR

Josh McAdams, C<< <joshua.mcadams at gmail.com> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-class-injector at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Class-Injector>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.




=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Class::Injector


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Class-Injector>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Class-Injector>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Class-Injector>

=item * Search CPAN

L<http://search.cpan.org/dist/Class-Injector/>

=back


=head1 ACKNOWLEDGEMENTS


=head1 LICENSE AND COPYRIGHT

Copyright 2010 Josh McAdams.

This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; version 2 dated June, 1991 or at your option
any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

A copy of the GNU General Public License is available in the source tree;
if not, write to the Free Software Foundation, Inc.,
59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.


=cut

1; # End of Class::Injector
