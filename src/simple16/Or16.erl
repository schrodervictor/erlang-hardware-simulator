-module('Or16').
-export([chip/2]).

chip(
    {A0,A1,A2,A3,A4,A5,A6,A7,A8,A9,AA,AB,AC,AD,AE,AF},
    {B0,B1,B2,B3,B4,B5,B6,B7,B8,B9,BA,BB,BC,BD,BE,BF}
) ->
    C0 = 'Or':chip(A0, B0),
    C1 = 'Or':chip(A1, B1),
    C2 = 'Or':chip(A2, B2),
    C3 = 'Or':chip(A3, B3),
    C4 = 'Or':chip(A4, B4),
    C5 = 'Or':chip(A5, B5),
    C6 = 'Or':chip(A6, B6),
    C7 = 'Or':chip(A7, B7),
    C8 = 'Or':chip(A8, B8),
    C9 = 'Or':chip(A9, B9),
    CA = 'Or':chip(AA, BA),
    CB = 'Or':chip(AB, BB),
    CC = 'Or':chip(AC, BC),
    CD = 'Or':chip(AD, BD),
    CE = 'Or':chip(AE, BE),
    CF = 'Or':chip(AF, BF),
    {C0,C1,C2,C3,C4,C5,C6,C7,C8,C9,CA,CB,CC,CD,CE,CF}.
