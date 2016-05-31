-module('Mux16').
-export([chip/3]).

chip(
    {A0,A1,A2,A3,A4,A5,A6,A7,A8,A9,AA,AB,AC,AD,AE,AF},
    {B0,B1,B2,B3,B4,B5,B6,B7,B8,B9,BA,BB,BC,BD,BE,BF},
    Sel
) ->
    C0 = 'Mux':chip(A0, B0, Sel),
    C1 = 'Mux':chip(A1, B1, Sel),
    C2 = 'Mux':chip(A2, B2, Sel),
    C3 = 'Mux':chip(A3, B3, Sel),
    C4 = 'Mux':chip(A4, B4, Sel),
    C5 = 'Mux':chip(A5, B5, Sel),
    C6 = 'Mux':chip(A6, B6, Sel),
    C7 = 'Mux':chip(A7, B7, Sel),
    C8 = 'Mux':chip(A8, B8, Sel),
    C9 = 'Mux':chip(A9, B9, Sel),
    CA = 'Mux':chip(AA, BA, Sel),
    CB = 'Mux':chip(AB, BB, Sel),
    CC = 'Mux':chip(AC, BC, Sel),
    CD = 'Mux':chip(AD, BD, Sel),
    CE = 'Mux':chip(AE, BE, Sel),
    CF = 'Mux':chip(AF, BF, Sel),
    {C0,C1,C2,C3,C4,C5,C6,C7,C8,C9,CA,CB,CC,CD,CE,CF}.
