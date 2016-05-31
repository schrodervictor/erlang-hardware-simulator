-module('And16').
-export([chip/2]).

chip(
    {AF,AE,AD,AC,AB,AA,A9,A8,A7,A6,A5,A4,A3,A2,A1,A0},
    {BF,BE,BD,BC,BB,BA,B9,B8,B7,B6,B5,B4,B3,B2,B1,B0}
) ->
    CF = 'And':chip(AF, BF),
    CE = 'And':chip(AE, BE),
    CD = 'And':chip(AD, BD),
    CC = 'And':chip(AC, BC),
    CB = 'And':chip(AB, BB),
    CA = 'And':chip(AA, BA),
    C9 = 'And':chip(A9, B9),
    C8 = 'And':chip(A8, B8),
    C7 = 'And':chip(A7, B7),
    C6 = 'And':chip(A6, B6),
    C5 = 'And':chip(A5, B5),
    C4 = 'And':chip(A4, B4),
    C3 = 'And':chip(A3, B3),
    C2 = 'And':chip(A2, B2),
    C1 = 'And':chip(A1, B1),
    C0 = 'And':chip(A0, B0),
    {CF,CE,CD,CC,CB,CA,C9,C8,C7,C6,C5,C4,C3,C2,C1,C0}.
