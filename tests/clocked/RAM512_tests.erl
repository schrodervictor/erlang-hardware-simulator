-module('RAM512_tests').
-include_lib("eunit/include/eunit.hrl").

chip_test() ->
    RAM512 = 'RAM512':create(),
    Zero = {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
    One = {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
    Mixed = {1,0,1,0,1,0,1,0,0,0,0,0,1,1,1,1},

    ?assertEqual(RAM512(One, 0, {0,0,0,0,0,0,0,0,0}), Zero),
    ?assertEqual(RAM512(One, 0, {0,0,0,0,0,1,1,0,0}), Zero),
    ?assertEqual(RAM512(One, 0, {0,0,0,0,0,1,1,0,1}), Zero),
    ?assertEqual(RAM512(One, 0, {0,0,0,0,0,1,1,1,0}), Zero),
    ?assertEqual(RAM512(One, 0, {0,0,0,0,1,1,0,1,0}), Zero),
    ?assertEqual(RAM512(One, 0, {1,1,0,1,1,0,1,1,1}), Zero),
    ?assertEqual(RAM512(One, 0, {1,1,1,1,1,0,1,1,0}), Zero),
    ?assertEqual(RAM512(One, 0, {1,1,1,1,1,0,1,1,1}), Zero),
    ?assertEqual(RAM512(One, 0, {1,1,1,1,1,1,1,1,0}), Zero),
    ?assertEqual(RAM512(One, 0, {1,1,1,1,1,1,1,1,1}), Zero),

    ?assertEqual(RAM512(One, 1, {1,1,0,1,1,0,1,1,1}), Zero),

    ?assertEqual(RAM512(One, 0, {0,0,0,0,0,0,0,0,0}), Zero),
    ?assertEqual(RAM512(One, 0, {0,0,0,0,0,1,1,0,0}), Zero),
    ?assertEqual(RAM512(One, 0, {0,0,0,0,0,1,1,0,1}), Zero),
    ?assertEqual(RAM512(One, 0, {0,0,0,0,0,1,1,1,0}), Zero),
    ?assertEqual(RAM512(One, 0, {0,0,0,0,1,1,0,1,0}), Zero),
    ?assertEqual(RAM512(One, 0, {1,1,0,1,1,0,1,1,1}), One),
    ?assertEqual(RAM512(One, 0, {1,1,1,1,1,0,1,1,0}), Zero),
    ?assertEqual(RAM512(One, 0, {1,1,1,1,1,0,1,1,1}), Zero),
    ?assertEqual(RAM512(One, 0, {1,1,1,1,1,1,1,1,0}), Zero),
    ?assertEqual(RAM512(One, 0, {1,1,1,1,1,1,1,1,1}), Zero),

    ?assertEqual(RAM512(Mixed, 1, {0,0,0,0,0,0,0,0,0}), Zero),
    ?assertEqual(RAM512(Mixed, 1, {0,0,0,0,0,1,1,0,0}), Zero),
    ?assertEqual(RAM512(Mixed, 1, {0,0,0,0,0,1,1,0,1}), Zero),
    ?assertEqual(RAM512(Mixed, 1, {0,0,0,0,0,1,1,1,0}), Zero),
    ?assertEqual(RAM512(Mixed, 1, {0,0,0,0,1,1,0,1,0}), Zero),
    ?assertEqual(RAM512(Mixed, 1, {1,1,0,1,1,0,1,1,1}), One),
    ?assertEqual(RAM512(Mixed, 1, {1,1,1,1,1,0,1,1,0}), Zero),
    ?assertEqual(RAM512(Mixed, 1, {1,1,1,1,1,0,1,1,1}), Zero),
    ?assertEqual(RAM512(Mixed, 1, {1,1,1,1,1,1,1,1,0}), Zero),
    ?assertEqual(RAM512(Mixed, 1, {1,1,1,1,1,1,1,1,1}), Zero),

    ?assertEqual(RAM512(One, 0, {0,0,0,0,0,0,0,0,0}), Mixed),
    ?assertEqual(RAM512(One, 0, {0,0,0,0,0,1,1,0,0}), Mixed),
    ?assertEqual(RAM512(One, 0, {0,0,0,0,0,1,1,0,1}), Mixed),
    ?assertEqual(RAM512(One, 0, {0,0,0,0,0,1,1,1,0}), Mixed),
    ?assertEqual(RAM512(One, 0, {0,0,0,0,1,1,0,1,0}), Mixed),
    ?assertEqual(RAM512(One, 0, {1,1,0,1,1,0,1,1,1}), Mixed),
    ?assertEqual(RAM512(One, 0, {1,1,1,1,1,0,1,1,0}), Mixed),
    ?assertEqual(RAM512(One, 0, {1,1,1,1,1,0,1,1,1}), Mixed),
    ?assertEqual(RAM512(One, 0, {1,1,1,1,1,1,1,1,0}), Mixed),
    ?assertEqual(RAM512(One, 0, {1,1,1,1,1,1,1,1,1}), Mixed).
