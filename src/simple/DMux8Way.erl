-module('DMux8Way').
-export([chip/2]).

chip(Bit, {Sel2, Sel1, Sel0}) ->
    NotSel2 = 'Not':chip(Sel2),
    {TA, TB, TC, TD} = 'DMux4Way':chip(Bit, {Sel1, Sel0}),
    {TE, TF, TG, TH} = 'DMux4Way':chip(Bit, {Sel1, Sel0}),
    OutA = 'And':chip(TA, NotSel2),
    OutB = 'And':chip(TB, NotSel2),
    OutC = 'And':chip(TC, NotSel2),
    OutD = 'And':chip(TD, NotSel2),
    OutE = 'And':chip(TE, Sel2),
    OutF = 'And':chip(TF, Sel2),
    OutG = 'And':chip(TG, Sel2),
    OutH = 'And':chip(TH, Sel2),
    {OutA, OutB, OutC, OutD, OutE, OutF, OutG, OutH}.
