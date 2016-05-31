-module('RAM4K').
-export([create/0]).

create() ->
    Mem0 = 'RAM512':create(),
    Mem1 = 'RAM512':create(),
    Mem2 = 'RAM512':create(),
    Mem3 = 'RAM512':create(),
    Mem4 = 'RAM512':create(),
    Mem5 = 'RAM512':create(),
    Mem6 = 'RAM512':create(),
    Mem7 = 'RAM512':create(),
    fun(NewBus, Load, {AB, AA, A9, A8, A7, A6, A5, A4, A3, A2, A1, A0}) ->
        {Load0, Load1, Load2, Load3, Load4, Load5, Load6, Load7} =
            'DMux8Way':chip(Load, {AB, AA, A9}),
        Bus0 = Mem0(NewBus, Load0, {A8, A7, A6, A5, A4, A3, A2, A1, A0}),
        Bus1 = Mem1(NewBus, Load1, {A8, A7, A6, A5, A4, A3, A2, A1, A0}),
        Bus2 = Mem2(NewBus, Load2, {A8, A7, A6, A5, A4, A3, A2, A1, A0}),
        Bus3 = Mem3(NewBus, Load3, {A8, A7, A6, A5, A4, A3, A2, A1, A0}),
        Bus4 = Mem4(NewBus, Load4, {A8, A7, A6, A5, A4, A3, A2, A1, A0}),
        Bus5 = Mem5(NewBus, Load5, {A8, A7, A6, A5, A4, A3, A2, A1, A0}),
        Bus6 = Mem6(NewBus, Load6, {A8, A7, A6, A5, A4, A3, A2, A1, A0}),
        Bus7 = Mem7(NewBus, Load7, {A8, A7, A6, A5, A4, A3, A2, A1, A0}),
        'Mux8Way16':chip(
            Bus0, Bus1, Bus2, Bus3, Bus4, Bus5, Bus6, Bus7, {AB, AA, A9}
        )
    end.
