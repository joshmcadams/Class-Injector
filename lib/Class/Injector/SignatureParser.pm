package Class::Injector::SignatureParser;

use warnings;
use strict;

use PPI;
use PPI::Dumper;

sub parse {
    my ($signature) = @_;
    my $document = PPI::Document->new( \$signature );
    return _build_method_argument( $document->children );
}

sub _build_method_argument {
    my @elements = @_;
    my @processed_elements;

    for my $element (@elements) {
        next if ref $element eq 'PPI::Token::WhiteSpace';

        if (   ref $element eq 'PPI::Statement'
            or ref $element eq 'PPI::Statement::Compound'
            or ref $element eq 'PPI::Statement::Expression' )
        {
            return _build_method_argument( $element->children );
        }
        elsif (ref $element eq 'PPI::Token::Quote::Double'
            or ref $element eq 'PPI::Token::Quote::Single' )
        {
            push @processed_elements, $element->string;
        }
        elsif ( ref $element eq 'PPI::Token::Number' ) {
            push @processed_elements, $element->literal;
        }
        elsif ( ref $element eq 'PPI::Token::Word' ) {
            if ( ref $element->snext_sibling eq 'PPI::Token::Operator'
                and $element->snext_sibling eq '=>' )
            {
                push @processed_elements, $element->literal;
            }
            else {
                push @processed_elements, sub { $element->literal };
            }
        }
        elsif ( ref $element eq 'PPI::Structure::Constructor'
            and substr( $element, 0, 1 ) eq '[' )
        {
            push @processed_elements,
              [ _build_method_argument( $element->children ) ];
        }
        elsif (
            (
                   ref $element eq 'PPI::Structure::Constructor'
                or ref $element eq 'PPI::Structure::Block'
            )
            and substr( $element, 0, 1 ) eq '{'
          )
        {
            push @processed_elements,
              { _build_method_argument( $element->children ) };
        }
    }

    return @processed_elements;
}

1;
