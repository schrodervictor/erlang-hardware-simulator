-module('Bit_tests').
-include_lib("eunit/include/eunit.hrl").

chip_test() ->
    Bit = 'Bit':create(),
    ?assertEqual(Bit(0, 0), 0),
    ?assertEqual(Bit(0, 1), 0),
    ?assertEqual(Bit(0, 0), 0),
    ?assertEqual(Bit(1, 0), 0),
    ?assertEqual(Bit(0, 0), 0),
    ?assertEqual(Bit(1, 1), 0),
    ?assertEqual(Bit(0, 0), 1),
    ?assertEqual(Bit(0, 0), 1),
    ?assertEqual(Bit(0, 0), 1),
    ?assertEqual(Bit(1, 0), 1),
    ?assertEqual(Bit(0, 0), 1),
    ?assertEqual(Bit(0, 1), 1),
    ?assertEqual(Bit(0, 1), 0),
    ?assertEqual(Bit(1, 1), 0),
    ?assertEqual(Bit(0, 0), 1).
