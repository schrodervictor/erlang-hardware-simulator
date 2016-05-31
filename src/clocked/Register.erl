-module('Register').
-export([create/0]).

create() ->
    Bit0 = 'Bit':create(),
    Bit1 = 'Bit':create(),
    Bit2 = 'Bit':create(),
    Bit3 = 'Bit':create(),
    Bit4 = 'Bit':create(),
    Bit5 = 'Bit':create(),
    Bit6 = 'Bit':create(),
    Bit7 = 'Bit':create(),
    Bit8 = 'Bit':create(),
    Bit9 = 'Bit':create(),
    BitA = 'Bit':create(),
    BitB = 'Bit':create(),
    BitC = 'Bit':create(),
    BitD = 'Bit':create(),
    BitE = 'Bit':create(),
    BitF = 'Bit':create(),
    fun({AF,AE,AD,AC,AB,AA,A9,A8,A7,A6,A5,A4,A3,A2,A1,A0}, Load) ->
        Out0 = Bit0(A0, Load),
        Out1 = Bit1(A1, Load),
        Out2 = Bit2(A2, Load),
        Out3 = Bit3(A3, Load),
        Out4 = Bit4(A4, Load),
        Out5 = Bit5(A5, Load),
        Out6 = Bit6(A6, Load),
        Out7 = Bit7(A7, Load),
        Out8 = Bit8(A8, Load),
        Out9 = Bit9(A9, Load),
        OutA = BitA(AA, Load),
        OutB = BitB(AB, Load),
        OutC = BitC(AC, Load),
        OutD = BitD(AD, Load),
        OutE = BitE(AE, Load),
        OutF = BitF(AF, Load),
        {
            OutF, OutE, OutD, OutC, OutB, OutA, Out9, Out8,
            Out7, Out6, Out5, Out4, Out3, Out2, Out1, Out0
        }
    end.
