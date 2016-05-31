-module('FullAdder').
-export([chip/3]).

chip(BitA, BitB, BitC) ->
    {CarryAB, SumAB} = 'HalfAdder':chip(BitA, BitB),
    {CarryABC, Sum} = 'HalfAdder':chip(SumAB, BitC),
    Carry = 'Or':chip(CarryAB, CarryABC),
    {Carry, Sum}.
