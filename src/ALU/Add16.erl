-module('Add16').
-export([chip/2]).

chip(
    {AF,AE,AD,AC,AB,AA,A9,A8,A7,A6,A5,A4,A3,A2,A1,A0},
    {BF,BE,BD,BC,BB,BA,B9,B8,B7,B6,B5,B4,B3,B2,B1,B0}
) ->
    {Carry0, Sum0} = 'HalfAdder':chip(A0, B0),
    {Carry1, Sum1} = 'FullAdder':chip(A1, B1, Carry0),
    {Carry2, Sum2} = 'FullAdder':chip(A2, B2, Carry1),
    {Carry3, Sum3} = 'FullAdder':chip(A3, B3, Carry2),
    {Carry4, Sum4} = 'FullAdder':chip(A4, B4, Carry3),
    {Carry5, Sum5} = 'FullAdder':chip(A5, B5, Carry4),
    {Carry6, Sum6} = 'FullAdder':chip(A6, B6, Carry5),
    {Carry7, Sum7} = 'FullAdder':chip(A7, B7, Carry6),
    {Carry8, Sum8} = 'FullAdder':chip(A8, B8, Carry7),
    {Carry9, Sum9} = 'FullAdder':chip(A9, B9, Carry8),
    {CarryA, SumA} = 'FullAdder':chip(AA, BA, Carry9),
    {CarryB, SumB} = 'FullAdder':chip(AB, BB, CarryA),
    {CarryC, SumC} = 'FullAdder':chip(AC, BC, CarryB),
    {CarryD, SumD} = 'FullAdder':chip(AD, BD, CarryC),
    {CarryE, SumE} = 'FullAdder':chip(AE, BE, CarryD),
    {_Overflow, SumF} = 'FullAdder':chip(AF, BF, CarryE),
    {
        SumF, SumE, SumD, SumC, SumB, SumA, Sum9, Sum8,
        Sum7, Sum6, Sum5, Sum4, Sum3, Sum2, Sum1, Sum0
    }.
