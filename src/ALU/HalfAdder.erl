-module('HalfAdder').
-export([chip/2]).

chip(BitA, BitB) ->
    Sum = 'Xor':chip(BitA, BitB),
    Carry = 'And':chip(BitA, BitB),
    {Carry, Sum}.
