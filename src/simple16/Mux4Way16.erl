-module('Mux4Way16').
-export([chip/5]).

chip(BusA, BusB, BusC, BusD, {Sel1, Sel0}) ->
    MuxAB = 'Mux16':chip(BusA, BusB, Sel0),
    MuxCD = 'Mux16':chip(BusC, BusD, Sel0),
    'Mux16':chip(MuxAB, MuxCD, Sel1).
