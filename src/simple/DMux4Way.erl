-module('DMux4Way').
-export([chip/2]).

chip(Bit, {Sel1, Sel0}) ->
    NotSel1 = 'Not':chip(Sel1),
    {TA, TB} = 'DMux':chip(Bit, Sel0),
    {TC, TD} = 'DMux':chip(Bit, Sel0),
    OutA = 'And':chip(TA, NotSel1),
    OutB = 'And':chip(TB, NotSel1),
    OutC = 'And':chip(TC, Sel1),
    OutD = 'And':chip(TD, Sel1),
    {OutA, OutB, OutC, OutD}.
