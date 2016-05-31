-module('FullAdder_tests').
-include_lib("eunit/include/eunit.hrl").

chip_test_() ->
    FullAdder = fun 'FullAdder':chip/3,
    [
        ?_assertEqual(FullAdder(0, 0, 0), {0, 0}),
        ?_assertEqual(FullAdder(0, 0, 1), {0, 1}),
        ?_assertEqual(FullAdder(0, 1, 0), {0, 1}),
        ?_assertEqual(FullAdder(0, 1, 1), {1, 0}),
        ?_assertEqual(FullAdder(1, 0, 0), {0, 1}),
        ?_assertEqual(FullAdder(1, 0, 1), {1, 0}),
        ?_assertEqual(FullAdder(1, 1, 0), {1, 0}),
        ?_assertEqual(FullAdder(1, 1, 1), {1, 1})
    ].
