-module('DMux8Way_tests').
-include_lib("eunit/include/eunit.hrl").

chip_test_() ->
    DMux8Way = fun 'DMux8Way':chip/2,
    [
        ?_assertEqual(DMux8Way(0, {0,0,0}), {0,0,0,0,0,0,0,0}),
        ?_assertEqual(DMux8Way(0, {0,0,1}), {0,0,0,0,0,0,0,0}),
        ?_assertEqual(DMux8Way(0, {0,1,0}), {0,0,0,0,0,0,0,0}),
        ?_assertEqual(DMux8Way(0, {0,1,1}), {0,0,0,0,0,0,0,0}),
        ?_assertEqual(DMux8Way(0, {1,0,0}), {0,0,0,0,0,0,0,0}),
        ?_assertEqual(DMux8Way(0, {1,0,1}), {0,0,0,0,0,0,0,0}),
        ?_assertEqual(DMux8Way(0, {1,1,0}), {0,0,0,0,0,0,0,0}),
        ?_assertEqual(DMux8Way(0, {1,1,1}), {0,0,0,0,0,0,0,0}),
        ?_assertEqual(DMux8Way(1, {0,0,0}), {1,0,0,0,0,0,0,0}),
        ?_assertEqual(DMux8Way(1, {0,0,1}), {0,1,0,0,0,0,0,0}),
        ?_assertEqual(DMux8Way(1, {0,1,0}), {0,0,1,0,0,0,0,0}),
        ?_assertEqual(DMux8Way(1, {0,1,1}), {0,0,0,1,0,0,0,0}),
        ?_assertEqual(DMux8Way(1, {1,0,0}), {0,0,0,0,1,0,0,0}),
        ?_assertEqual(DMux8Way(1, {1,0,1}), {0,0,0,0,0,1,0,0}),
        ?_assertEqual(DMux8Way(1, {1,1,0}), {0,0,0,0,0,0,1,0}),
        ?_assertEqual(DMux8Way(1, {1,1,1}), {0,0,0,0,0,0,0,1})
    ].
