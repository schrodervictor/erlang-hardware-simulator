-module('Bit').
-export([create/0]).

create() ->
    DFF = 'DFF':create(),
    fun(Bit, Load) ->
        OldBit = DFF(tick),
        NewBit = 'Mux':chip(OldBit, Bit, Load),
        DFF(NewBit),
        OldBit
    end.
