-module('Mux_tests').
-include_lib("eunit/include/eunit.hrl").

chip_test_() ->
    Mux = fun 'Mux':chip/3,
    [
        ?_assertEqual(Mux(0, 0, 0), 0),
        ?_assertEqual(Mux(0, 0, 1), 0),
        ?_assertEqual(Mux(0, 1, 0), 0),
        ?_assertEqual(Mux(0, 1, 1), 1),
        ?_assertEqual(Mux(1, 0, 0), 1),
        ?_assertEqual(Mux(1, 0, 1), 0),
        ?_assertEqual(Mux(1, 1, 0), 1),
        ?_assertEqual(Mux(1, 1, 1), 1)
    ].
