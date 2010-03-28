use warnings;
use strict;
use Test::More qw(no_plan);
use Class::Injector::SignatureParser;
use Test::Deep;

map {
    cmp_deeply( [ Class::Injector::SignatureParser::parse( $_->[0] ) ],
        $_->[1], $_->[2] );
  } (
    [ '"SampleString"', ['SampleString'], 'double-quoted string' ],
    [ "'SampleString'", ['SampleString'], 'single-quoted string' ],
    [ 42,               [42],             'number' ],
    [
        '"SampleString","AnotherString"',
        [ 'SampleString', 'AnotherString' ],
        'multiple strings'
    ],
    [
        '"SampleString",1234,"AnotherString"',
        [ 'SampleString', 1234, 'AnotherString' ],
        'strings and numbers'
    ],
    [
        '"SampleString" => "AnotherString"',
        [ 'SampleString', 'AnotherString' ],
        'multiple strings with fat arrow'
    ],
    [ '"Sample String"', ['Sample String'], 'double-quoted string with space' ],
    [ 'MyClass', [ code( sub { ref $_[0] eq 'CODE' } ) ], 'dependency key' ],
    [
        '"identifier",MyClass',
        [ 'identifier', code( sub { ref $_[0] eq 'CODE' } ) ],
        'named dependency key'
    ],
    [
        '"identifier" => MyClass',
        [ 'identifier', code( sub { ref $_[0] eq 'CODE' } ) ],
        'named dependency key with fat arrow'
    ],
    [
        'identifier => MyClass',
        [ 'identifier', code( sub { ref $_[0] eq 'CODE' } ) ],
        'named dependency key with fat arrow and no quotes'
    ],
    [ '[42]', [ [42] ], 'number in an array' ],
    [ '{24 => 42}', [ { 24 => 42 } ], 'numbers in a hash' ],
    [
        '[42, "Hi", \'There\']',
        [ [ 42, 'Hi', 'There' ] ],
        'multi-element array'
    ],
    [
        '{42, "Hi", \'There\' => 45}',
        [ { 42, 'Hi', 'There', 45 } ],
        'multi-element hash'
    ],
    [
        '[36, [ 24, 36, [ "hi" ]], bob]]',
        [ [ 36, [ 24, 36, ['hi'] ], code( sub { ref $_[0] eq 'CODE' } ) ] ],
        'nested arrays'
    ],
    [
        '{24 => { class => bob }, 45 => { other => joe, another => moe }}',
        [
            {
                24 => { class => code( sub { ref $_[0] eq 'CODE' } ) },
                45 => {
                    other   => code( sub { ref $_[0] eq 'CODE' } ),
                    another => code( sub { ref $_[0] eq 'CODE' } )
                }
            }
        ],
        'nested hashes'
    ],
    [
'{24 => { class => [ bob, jones ] }, 45 => { other => joe, another => moe }}, [ "a" ]',
        [
            {
                24 => {
                    class => [
                        code( sub { ref $_[0] eq 'CODE' } ),
                        code( sub { ref $_[0] eq 'CODE' } )
                    ]
                },
                45 => {
                    other   => code( sub { ref $_[0] eq 'CODE' } ),
                    another => code( sub { ref $_[0] eq 'CODE' } )
                }
            },
            ['a']
        ],
        'mixed arrays and hashes'
    ],
    [
        '{a=>b,c=>d}',
        [
            {
                a => code( sub { ref $_[0] eq 'CODE' } ),
                c => code( sub { ref $_[0] eq 'CODE' } )
            }
        ],
        'most likely case'
    ],
  );
