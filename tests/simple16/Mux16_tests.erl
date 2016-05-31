-module('Mux16_tests').
-include_lib("eunit/include/eunit.hrl").

chip_test_() ->
    Mux16 = fun 'Mux16':chip/3,
    [
        ?_assertEqual(
            Mux16(
                {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
                {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
                0
            ),
            {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
        ),
        ?_assertEqual(
            Mux16(
                {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
                {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
                1
            ),
            {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
        ),
        ?_assertEqual(
            Mux16(
                {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
                {0,0,0,1,0,0,1,0,0,0,1,1,0,1,0,0},
                0
            ),
            {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
        ),
        ?_assertEqual(
            Mux16(
                {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
                {0,0,0,1,0,0,1,0,0,0,1,1,0,1,0,0},
                1
            ),
            {0,0,0,1,0,0,1,0,0,0,1,1,0,1,0,0}
        ),
        ?_assertEqual(
            Mux16(
                {1,0,0,1,1,0,0,0,0,1,1,1,0,1,1,0},
                {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
                0
            ),
            {1,0,0,1,1,0,0,0,0,1,1,1,0,1,1,0}
        ),
        ?_assertEqual(
            Mux16(
                {1,0,0,1,1,0,0,0,0,1,1,1,0,1,1,0},
                {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
                1
            ),
            {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
        ),
        ?_assertEqual(
            Mux16(
                {1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0},
                {0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1},
                0
            ),
            {1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0}
        ),

        ?_assertEqual(
            Mux16(
                {1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0},
                {0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1},
                1
            ),
            {0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1}
        )
    ].
