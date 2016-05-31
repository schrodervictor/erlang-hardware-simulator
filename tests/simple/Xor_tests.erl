-module('Xor_tests').
-include_lib("eunit/include/eunit.hrl").

chip_test_() ->
    [
        ?_assertEqual('Xor':chip(0, 0), 0),
        ?_assertEqual('Xor':chip(0, 1), 1),
        ?_assertEqual('Xor':chip(1, 0), 1),
        ?_assertEqual('Xor':chip(1, 1), 0)
    ].
