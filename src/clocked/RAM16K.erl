-module('RAM16K').
-export([create/0]).

create() ->
    Mem0 = 'RAM4K':create(),
    Mem1 = 'RAM4K':create(),
    Mem2 = 'RAM4K':create(),
    Mem3 = 'RAM4K':create(),
    fun(NewBus, Load, {AD, AC, AB, AA, A9, A8, A7, A6, A5, A4, A3, A2, A1, A0}) ->
        {Load0, Load1, Load2, Load3, Load4, Load5, Load6, Load7} =
            'DMux4Way':chip(Load, {AD, AC}),
        Bus0 = Mem0(NewBus, Load0, {AB, AA, A9, A8, A7, A6, A5, A4, A3, A2, A1, A0}),
        Bus1 = Mem1(NewBus, Load1, {AB, AA, A9, A8, A7, A6, A5, A4, A3, A2, A1, A0}),
        Bus2 = Mem2(NewBus, Load2, {AB, AA, A9, A8, A7, A6, A5, A4, A3, A2, A1, A0}),
        Bus3 = Mem3(NewBus, Load3, {AB, AA, A9, A8, A7, A6, A5, A4, A3, A2, A1, A0}),
        'Mux4Way16':chip(
            Bus0, Bus1, Bus2, Bus3, {AD, AC}
        )
    end.
