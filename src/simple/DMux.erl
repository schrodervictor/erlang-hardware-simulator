-module('DMux').
-export([chip/2]).

chip(Bit, Sel) ->
    NotSel = 'Not':chip(Sel),
    Left = 'And':chip(Bit, NotSel),
    Right = 'And':chip(Bit, Sel),
    {Left, Right}.
