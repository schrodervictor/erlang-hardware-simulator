-module('Or8Way_tests').
-include_lib("eunit/include/eunit.hrl").

chip_test_() ->
    Or8Way = fun 'Or8Way':chip/1,
    [
       ?_assertEqual(Or8Way({0,0,0,0,0,0,0,0}), 0),
       ?_assertEqual(Or8Way({1,1,1,1,1,1,1,1}), 1),
       ?_assertEqual(Or8Way({0,0,0,1,0,0,0,0}), 1),
       ?_assertEqual(Or8Way({0,0,0,0,0,0,0,1}), 1),
       ?_assertEqual(Or8Way({0,0,1,0,0,1,1,0}), 1)
    ].
