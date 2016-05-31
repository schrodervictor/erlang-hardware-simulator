-module('HalfAdder_tests').
-include_lib("eunit/include/eunit.hrl").

chip_test_() ->
    HalfAdder = fun 'HalfAdder':chip/2,
    [
        ?_assertEqual(HalfAdder(0, 0), {0, 0}),
        ?_assertEqual(HalfAdder(0, 1), {0, 1}),
        ?_assertEqual(HalfAdder(1, 0), {0, 1}),
        ?_assertEqual(HalfAdder(1, 1), {1, 0})
    ].
