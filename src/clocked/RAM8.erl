-module('RAM8').
-export([create/0]).

create() ->
    Reg0 = 'Register':create(),
    Reg1 = 'Register':create(),
    Reg2 = 'Register':create(),
    Reg3 = 'Register':create(),
    Reg4 = 'Register':create(),
    Reg5 = 'Register':create(),
    Reg6 = 'Register':create(),
    Reg7 = 'Register':create(),
    fun(NewBus, Load, Address) ->
        {Load0, Load1, Load2, Load3, Load4, Load5, Load6, Load7} =
            'DMux8Way':chip(Load, Address),
        Bus0 = Reg0(NewBus, Load0),
        Bus1 = Reg1(NewBus, Load1),
        Bus2 = Reg2(NewBus, Load2),
        Bus3 = Reg3(NewBus, Load3),
        Bus4 = Reg4(NewBus, Load4),
        Bus5 = Reg5(NewBus, Load5),
        Bus6 = Reg6(NewBus, Load6),
        Bus7 = Reg7(NewBus, Load7),
        'Mux8Way16':chip(
            Bus0, Bus1, Bus2, Bus3, Bus4, Bus5, Bus6, Bus7, Address
        )
    end.
