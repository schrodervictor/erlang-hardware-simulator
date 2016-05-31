-module('Mux8Way16').
-export([chip/9]).

chip(BusA, BusB, BusC, BusD, BusE, BusF, BusG, BusH, {Sel2, Sel1, Sel0}) ->
    MuxABCD = 'Mux4Way16':chip(BusA, BusB, BusC, BusD, {Sel1, Sel0}),
    MuxEFGH = 'Mux4Way16':chip(BusE, BusF, BusG, BusH, {Sel1, Sel0}),
    'Mux16':chip(MuxABCD, MuxEFGH, Sel2).
