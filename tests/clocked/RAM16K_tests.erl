-module('RAM16K_tests').
-include_lib("eunit/include/eunit.hrl").

chip_test_() -> {timeout, 30, fun memory_check/0}.

memory_check() ->
    RAM16K = 'RAM16K':create(),
    Zero = {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
    One = {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
    Mixed = {1,0,1,0,1,0,1,0,0,0,0,0,1,1,1,1},
    ?assertEqual(RAM16K(One, 0, {0,0,0,0,0,0,0,0,0,0,0,0,0,0}), Zero),
    ?assertEqual(RAM16K(One, 0, {0,0,0,0,0,0,0,0,0,0,1,1,0,0}), Zero),
    ?assertEqual(RAM16K(One, 0, {0,1,0,0,1,0,0,0,0,0,1,1,0,1}), Zero),
    ?assertEqual(RAM16K(One, 0, {1,0,0,0,1,0,0,0,0,0,1,1,1,0}), Zero),
    ?assertEqual(RAM16K(One, 0, {1,1,0,1,0,0,0,0,0,1,1,0,1,0}), Zero),
    ?assertEqual(RAM16K(One, 0, {0,0,0,1,1,1,1,0,1,1,0,1,1,1}), Zero),
    ?assertEqual(RAM16K(One, 0, {0,1,1,0,0,1,1,1,1,1,0,1,1,0}), Zero),
    ?assertEqual(RAM16K(One, 0, {1,0,1,0,1,1,1,1,1,1,0,1,1,1}), Zero),
    ?assertEqual(RAM16K(One, 0, {0,0,1,1,0,1,1,1,1,1,1,1,1,0}), Zero),
    ?assertEqual(RAM16K(One, 0, {1,1,1,1,1,1,1,1,1,1,1,1,1,1}), Zero),

    ?assertEqual(RAM16K(One, 1, {0,0,1,1,0,1,1,1,1,1,1,1,1,0}), Zero),

    ?assertEqual(RAM16K(One, 0, {0,0,0,0,0,0,0,0,0,0,0,0,0,0}), Zero),
    ?assertEqual(RAM16K(One, 0, {0,0,0,0,0,0,0,0,0,0,1,1,0,0}), Zero),
    ?assertEqual(RAM16K(One, 0, {0,1,0,0,1,0,0,0,0,0,1,1,0,1}), Zero),
    ?assertEqual(RAM16K(One, 0, {1,0,0,0,1,0,0,0,0,0,1,1,1,0}), Zero),
    ?assertEqual(RAM16K(One, 0, {1,1,0,1,0,0,0,0,0,1,1,0,1,0}), Zero),
    ?assertEqual(RAM16K(One, 0, {0,0,0,1,1,1,1,0,1,1,0,1,1,1}), Zero),
    ?assertEqual(RAM16K(One, 0, {0,1,1,0,0,1,1,1,1,1,0,1,1,0}), Zero),
    ?assertEqual(RAM16K(One, 0, {1,0,1,0,1,1,1,1,1,1,0,1,1,1}), Zero),
    ?assertEqual(RAM16K(One, 0, {0,0,1,1,0,1,1,1,1,1,1,1,1,0}), One),
    ?assertEqual(RAM16K(One, 0, {1,1,1,1,1,1,1,1,1,1,1,1,1,1}), Zero),

    ?assertEqual(RAM16K(Mixed, 1, {0,0,0,0,0,0,0,0,0,0,0,0,0,0}), Zero),
    ?assertEqual(RAM16K(Mixed, 1, {0,0,0,0,0,0,0,0,0,0,1,1,0,0}), Zero),
    ?assertEqual(RAM16K(Mixed, 1, {0,1,0,0,1,0,0,0,0,0,1,1,0,1}), Zero),
    ?assertEqual(RAM16K(Mixed, 1, {1,0,0,0,1,0,0,0,0,0,1,1,1,0}), Zero),
    ?assertEqual(RAM16K(Mixed, 1, {1,1,0,1,0,0,0,0,0,1,1,0,1,0}), Zero),
    ?assertEqual(RAM16K(Mixed, 1, {0,0,0,1,1,1,1,0,1,1,0,1,1,1}), Zero),
    ?assertEqual(RAM16K(Mixed, 1, {0,1,1,0,0,1,1,1,1,1,0,1,1,0}), Zero),
    ?assertEqual(RAM16K(Mixed, 1, {1,0,1,0,1,1,1,1,1,1,0,1,1,1}), Zero),
    ?assertEqual(RAM16K(Mixed, 1, {0,0,1,1,0,1,1,1,1,1,1,1,1,0}), One),
    ?assertEqual(RAM16K(Mixed, 1, {1,1,1,1,1,1,1,1,1,1,1,1,1,1}), Zero),

    ?assertEqual(RAM16K(One, 0, {0,0,0,0,0,0,0,0,0,0,0,0,0,0}), Mixed),
    ?assertEqual(RAM16K(One, 0, {0,0,0,0,0,0,0,0,0,0,1,1,0,0}), Mixed),
    ?assertEqual(RAM16K(One, 0, {0,1,0,0,1,0,0,0,0,0,1,1,0,1}), Mixed),
    ?assertEqual(RAM16K(One, 0, {1,0,0,0,1,0,0,0,0,0,1,1,1,0}), Mixed),
    ?assertEqual(RAM16K(One, 0, {1,1,0,1,0,0,0,0,0,1,1,0,1,0}), Mixed),
    ?assertEqual(RAM16K(One, 0, {0,0,0,1,1,1,1,0,1,1,0,1,1,1}), Mixed),
    ?assertEqual(RAM16K(One, 0, {0,1,1,0,0,1,1,1,1,1,0,1,1,0}), Mixed),
    ?assertEqual(RAM16K(One, 0, {1,0,1,0,1,1,1,1,1,1,0,1,1,1}), Mixed),
    ?assertEqual(RAM16K(One, 0, {0,0,1,1,0,1,1,1,1,1,1,1,1,0}), Mixed),
    ?assertEqual(RAM16K(One, 0, {1,1,1,1,1,1,1,1,1,1,1,1,1,1}), Mixed).
