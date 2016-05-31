-module('And_tests').
-include_lib("eunit/include/eunit.hrl").

chip_test_() ->
    [
        ?_assertEqual('And':chip(0, 0), 0),
        ?_assertEqual('And':chip(0, 1), 0),
        ?_assertEqual('And':chip(1, 0), 0),
        ?_assertEqual('And':chip(1, 1), 1)
    ].

