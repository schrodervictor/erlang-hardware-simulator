-module('DFF_tests').
-include_lib("eunit/include/eunit.hrl").

chip_test() ->
    DFF = 'DFF':create(),
    ?assertEqual(DFF(tick), 0),
    ?assertEqual(DFF(tick), 0),
    ?assertEqual(DFF(tick), 0),
    ?assertEqual(DFF(0), ok),
    ?assertEqual(DFF(tick), 0),
    ?assertEqual(DFF(tick), 0),
    ?assertEqual(DFF(tick), 0),
    ?assertEqual(DFF(1), ok),
    ?assertEqual(DFF(tick), 1),
    ?assertEqual(DFF(tick), 1),
    ?assertEqual(DFF(tick), 1),
    ?assertEqual(DFF(0), ok),
    ?assertEqual(DFF(0), ok),
    ?assertEqual(DFF(1), ok),
    ?assertEqual(DFF(tick), 1).
