-module('DMux_tests').
-include_lib("eunit/include/eunit.hrl").

chip_test_() ->
    [
        ?_assertEqual('DMux':chip(0, 0), {0, 0}),
        ?_assertEqual('DMux':chip(0, 1), {0, 0}),
        ?_assertEqual('DMux':chip(1, 0), {1, 0}),
        ?_assertEqual('DMux':chip(1, 1), {0, 1})
    ].
