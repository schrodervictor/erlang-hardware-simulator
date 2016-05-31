-module('CTranslator_tests').
-include_lib("eunit/include/eunit.hrl").

-define(
     _assertBinaryEqual(Expected, Actual),
     ?_assertEqual(iolist_to_binary(Expected), iolist_to_binary(Actual))
).

tokenize_test_() ->
    Tokenize = fun 'CTranslator':tokenize/1,
    [
        ?_assertEqual({ok, {"D", "M+1", "JMP"}}, Tokenize("D=M+1;JMP")),
        ?_assertEqual({ok, {"", "M+1", "JMP"}}, Tokenize("M+1;JMP")),
        ?_assertEqual({ok, {"D", "M+1", ""}}, Tokenize("D=M+1"))
    ].
