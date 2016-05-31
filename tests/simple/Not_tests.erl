-module('Not_tests').
-include_lib("eunit/include/eunit.hrl").

chip_test_() ->
    [
        ?_assertEqual('Not':chip(0), 1),
        ?_assertEqual('Not':chip(1), 0)
    ].
