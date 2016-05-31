-module('RAM4K_tests').
-include_lib("eunit/include/eunit.hrl").

chip_test_() -> {timeout, 20, fun memory_check/0}.

memory_check() ->
    RAM4K = 'RAM4K':create(),
    Zero = {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
    One = {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
    Mixed = {1,0,1,0,1,0,1,0,0,0,0,0,1,1,1,1},
    ?assertEqual(RAM4K(One, 0, {0,0,0,0,0,0,0,0,0,0,0,0}), Zero),
    ?assertEqual(RAM4K(One, 0, {0,0,0,0,0,0,0,0,1,1,0,0}), Zero),
    ?assertEqual(RAM4K(One, 0, {0,0,1,0,0,0,0,0,1,1,0,1}), Zero),
    ?assertEqual(RAM4K(One, 0, {0,0,1,0,0,0,0,0,1,1,1,0}), Zero),
    ?assertEqual(RAM4K(One, 0, {0,1,0,0,0,0,0,1,1,0,1,0}), Zero),
    ?assertEqual(RAM4K(One, 0, {0,1,1,1,1,0,1,1,0,1,1,1}), Zero),
    ?assertEqual(RAM4K(One, 0, {1,0,0,1,1,1,1,1,0,1,1,0}), Zero),
    ?assertEqual(RAM4K(One, 0, {1,0,1,1,1,1,1,1,0,1,1,1}), Zero),
    ?assertEqual(RAM4K(One, 0, {1,1,0,1,1,1,1,1,1,1,1,0}), Zero),
    ?assertEqual(RAM4K(One, 0, {1,1,1,1,1,1,1,1,1,1,1,1}), Zero),

    ?assertEqual(RAM4K(One, 1, {1,0,1,1,1,1,1,1,0,1,1,1}), Zero),

    ?assertEqual(RAM4K(One, 0, {0,0,0,0,0,0,0,0,0,0,0,0}), Zero),
    ?assertEqual(RAM4K(One, 0, {0,0,0,0,0,0,0,0,1,1,0,0}), Zero),
    ?assertEqual(RAM4K(One, 0, {0,0,1,0,0,0,0,0,1,1,0,1}), Zero),
    ?assertEqual(RAM4K(One, 0, {0,0,1,0,0,0,0,0,1,1,1,0}), Zero),
    ?assertEqual(RAM4K(One, 0, {0,1,0,0,0,0,0,1,1,0,1,0}), Zero),
    ?assertEqual(RAM4K(One, 0, {0,1,1,1,1,0,1,1,0,1,1,1}), Zero),
    ?assertEqual(RAM4K(One, 0, {1,0,0,1,1,1,1,1,0,1,1,0}), Zero),
    ?assertEqual(RAM4K(One, 0, {1,0,1,1,1,1,1,1,0,1,1,1}), One),
    ?assertEqual(RAM4K(One, 0, {1,1,0,1,1,1,1,1,1,1,1,0}), Zero),
    ?assertEqual(RAM4K(One, 0, {1,1,1,1,1,1,1,1,1,1,1,1}), Zero),

    ?assertEqual(RAM4K(Mixed, 1, {0,0,0,0,0,0,0,0,0,0,0,0}), Zero),
    ?assertEqual(RAM4K(Mixed, 1, {0,0,0,0,0,0,0,0,1,1,0,0}), Zero),
    ?assertEqual(RAM4K(Mixed, 1, {0,0,1,0,0,0,0,0,1,1,0,1}), Zero),
    ?assertEqual(RAM4K(Mixed, 1, {0,0,1,0,0,0,0,0,1,1,1,0}), Zero),
    ?assertEqual(RAM4K(Mixed, 1, {0,1,0,0,0,0,0,1,1,0,1,0}), Zero),
    ?assertEqual(RAM4K(Mixed, 1, {0,1,1,1,1,0,1,1,0,1,1,1}), Zero),
    ?assertEqual(RAM4K(Mixed, 1, {1,0,0,1,1,1,1,1,0,1,1,0}), Zero),
    ?assertEqual(RAM4K(Mixed, 1, {1,0,1,1,1,1,1,1,0,1,1,1}), One),
    ?assertEqual(RAM4K(Mixed, 1, {1,1,0,1,1,1,1,1,1,1,1,0}), Zero),
    ?assertEqual(RAM4K(Mixed, 1, {1,1,1,1,1,1,1,1,1,1,1,1}), Zero),

    ?assertEqual(RAM4K(One, 0, {0,0,0,0,0,0,0,0,0,0,0,0}), Mixed),
    ?assertEqual(RAM4K(One, 0, {0,0,0,0,0,0,0,0,1,1,0,0}), Mixed),
    ?assertEqual(RAM4K(One, 0, {0,0,1,0,0,0,0,0,1,1,0,1}), Mixed),
    ?assertEqual(RAM4K(One, 0, {0,0,1,0,0,0,0,0,1,1,1,0}), Mixed),
    ?assertEqual(RAM4K(One, 0, {0,1,0,0,0,0,0,1,1,0,1,0}), Mixed),
    ?assertEqual(RAM4K(One, 0, {0,1,1,1,1,0,1,1,0,1,1,1}), Mixed),
    ?assertEqual(RAM4K(One, 0, {1,0,0,1,1,1,1,1,0,1,1,0}), Mixed),
    ?assertEqual(RAM4K(One, 0, {1,0,1,1,1,1,1,1,0,1,1,1}), Mixed),
    ?assertEqual(RAM4K(One, 0, {1,1,0,1,1,1,1,1,1,1,1,0}), Mixed),
    ?assertEqual(RAM4K(One, 0, {1,1,1,1,1,1,1,1,1,1,1,1}), Mixed).
