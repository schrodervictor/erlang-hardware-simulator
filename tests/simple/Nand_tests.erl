-module('Nand_tests').
-include_lib("eunit/include/eunit.hrl").

chip_test_() ->
    [
        ?_assertEqual('Nand':chip(0, 0), 1),
        ?_assertEqual('Nand':chip(0, 1), 1),
        ?_assertEqual('Nand':chip(1, 0), 1),
        ?_assertEqual('Nand':chip(1, 1), 0)
    ].
