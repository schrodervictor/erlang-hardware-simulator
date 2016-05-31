-module('And').
-export([chip/2]).

chip(BitA, BitB) ->
    NandOut = 'Nand':chip(BitA, BitB),
    'Not':chip(NandOut).
