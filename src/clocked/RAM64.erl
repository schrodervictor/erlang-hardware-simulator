-module('RAM64').
-export([create/0]).

create() ->
    Mem0 = 'RAM8':create(),
    Mem1 = 'RAM8':create(),
    Mem2 = 'RAM8':create(),
    Mem3 = 'RAM8':create(),
    Mem4 = 'RAM8':create(),
    Mem5 = 'RAM8':create(),
    Mem6 = 'RAM8':create(),
    Mem7 = 'RAM8':create(),
    fun(NewBus, Load, {A5, A4, A3, A2, A1, A0}) ->
        {Load0, Load1, Load2, Load3, Load4, Load5, Load6, Load7} =
            'DMux8Way':chip(Load, {A5, A4, A3}),
        Bus0 = Mem0(NewBus, Load0, {A2, A1, A0}),
        Bus1 = Mem1(NewBus, Load1, {A2, A1, A0}),
        Bus2 = Mem2(NewBus, Load2, {A2, A1, A0}),
        Bus3 = Mem3(NewBus, Load3, {A2, A1, A0}),
        Bus4 = Mem4(NewBus, Load4, {A2, A1, A0}),
        Bus5 = Mem5(NewBus, Load5, {A2, A1, A0}),
        Bus6 = Mem6(NewBus, Load6, {A2, A1, A0}),
        Bus7 = Mem7(NewBus, Load7, {A2, A1, A0}),
        'Mux8Way16':chip(
            Bus0, Bus1, Bus2, Bus3, Bus4, Bus5, Bus6, Bus7, {A5, A4, A3}
        )
    end.
