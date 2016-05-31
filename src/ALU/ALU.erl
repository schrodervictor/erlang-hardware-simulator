-module('ALU').
-export([chip/8]).

chip(BusX, BusY, ZX, NX, ZY, NY, F, NOut) ->
    False = {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},

    XStep0 = 'Mux16':chip(BusX, False, ZX),
    NotXStep0 = 'Not16':chip(XStep0),
    XStep1 = 'Mux16':chip(XStep0, NotXStep0, NX),

    YStep0 = 'Mux16':chip(BusY, False, ZY),
    NotYStep0 = 'Not16':chip(YStep0),
    YStep1 = 'Mux16':chip(YStep0, NotYStep0, NY),

    AddXY = 'Add16':chip(XStep1, YStep1),
    AndXY = 'And16':chip(XStep1, YStep1),

    FXY = 'Mux16':chip(AndXY, AddXY, F),
    NotFXY = 'Not16':chip(FXY),

    Out = 'Mux16':chip(FXY, NotFXY, NOut),

    {
        OutF, OutE, OutD, OutC, OutB, OutA, Out9, Out8,
        Out7, Out6, Out5, Out4, Out3, Out2, Out1, Out0
    } = Out,

    NotZeroHalf0 = 'Or8Way':chip(
        {Out7, Out6, Out5, Out4, Out3, Out2, Out1, Out0}
    ),
    NotZeroHalf1 = 'Or8Way':chip(
        {OutF, OutE, OutD, OutC, OutB, OutA, Out9, Out8}
    ),
    NotZero = 'Or':chip(NotZeroHalf0, NotZeroHalf1),
    IsZero = 'Not':chip(NotZero),
    IsNeg = OutF,
    {Out, IsZero, IsNeg}.
