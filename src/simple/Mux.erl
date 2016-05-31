-module('Mux').
-export([chip/3]).

chip(BitA, BitB, Sel) ->
    NotSel = 'Not':chip(Sel),
    SelA = 'And':chip(BitA, NotSel),
    SelB = 'And':chip(BitB, Sel),
    'Or':chip(SelA, SelB).
