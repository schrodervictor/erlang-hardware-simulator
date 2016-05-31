-module('Xor').
-export([chip/2]).

chip(BitA, BitB) ->
    OrAB = 'Or':chip(BitA, BitB),
    NandAB = 'Nand':chip(BitA, BitB),
    'And':chip(OrAB, NandAB).
