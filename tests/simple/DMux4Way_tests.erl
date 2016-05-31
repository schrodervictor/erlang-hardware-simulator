-module('DMux4Way_tests').
-include_lib("eunit/include/eunit.hrl").

chip_test_() ->
    DMux4Way = fun 'DMux4Way':chip/2,
    [
        ?_assertEqual(DMux4Way(0, {0,0}), {0,0,0,0}),
        ?_assertEqual(DMux4Way(0, {0,1}), {0,0,0,0}),
        ?_assertEqual(DMux4Way(0, {1,0}), {0,0,0,0}),
        ?_assertEqual(DMux4Way(0, {1,1}), {0,0,0,0}),
        ?_assertEqual(DMux4Way(1, {0,0}), {1,0,0,0}),
        ?_assertEqual(DMux4Way(1, {0,1}), {0,1,0,0}),
        ?_assertEqual(DMux4Way(1, {1,0}), {0,0,1,0}),
        ?_assertEqual(DMux4Way(1, {1,1}), {0,0,0,1})
    ].
