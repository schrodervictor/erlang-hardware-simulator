-module('Register_tests').
-include_lib("eunit/include/eunit.hrl").

chip_test() ->
    Register = 'Register':create(),
    Zero = {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
    One = {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
    Mixed = {1,0,1,0,1,0,1,0,0,0,0,0,1,1,1,1},
    ?assertEqual(Register(Zero, 0), Zero),
    ?assertEqual(Register(Zero, 0), Zero),
    ?assertEqual(Register(Zero, 0), Zero),
    ?assertEqual(Register(One, 0), Zero),
    ?assertEqual(Register(Zero, 0), Zero),
    ?assertEqual(Register(One, 1), Zero),
    ?assertEqual(Register(Zero, 0), One),
    ?assertEqual(Register(One, 0), One),
    ?assertEqual(Register(Zero, 0), One),
    ?assertEqual(Register(Mixed, 1), One),
    ?assertEqual(Register(Zero, 0), Mixed),
    ?assertEqual(Register(Zero, 0), Mixed),
    ?assertEqual(Register(Zero, 0), Mixed),
    ?assertEqual(Register(Zero, 1), Mixed),
    ?assertEqual(Register(Zero, 0), Zero),
    ?assertEqual(Register(Zero, 0), Zero),
    ?assertEqual(Register(Zero, 0), Zero).
