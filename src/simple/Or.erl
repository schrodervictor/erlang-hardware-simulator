-module('Or').
-export([chip/2]).

chip(BitA, BitB) ->
    NotA = 'Not':chip(BitA),
    NotB = 'Not':chip(BitB),
    'Nand':chip(NotA, NotB).
