-module('Not16').
-export([chip/1]).

chip({A0,A1,A2,A3,A4,A5,A6,A7,A8,A9,AA,AB,AC,AD,AE,AF}) ->
    C0 = 'Not':chip(A0),
    C1 = 'Not':chip(A1),
    C2 = 'Not':chip(A2),
    C3 = 'Not':chip(A3),
    C4 = 'Not':chip(A4),
    C5 = 'Not':chip(A5),
    C6 = 'Not':chip(A6),
    C7 = 'Not':chip(A7),
    C8 = 'Not':chip(A8),
    C9 = 'Not':chip(A9),
    CA = 'Not':chip(AA),
    CB = 'Not':chip(AB),
    CC = 'Not':chip(AC),
    CD = 'Not':chip(AD),
    CE = 'Not':chip(AE),
    CF = 'Not':chip(AF),
    {C0,C1,C2,C3,C4,C5,C6,C7,C8,C9,CA,CB,CC,CD,CE,CF}.
