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

translate_dest_test_() ->
    Translate = fun 'CTranslator':translate_dest/1,
    [
        ?_assertBinaryEqual("000", Translate("")),

        ?_assertBinaryEqual("001", Translate("M")),
        ?_assertBinaryEqual("010", Translate("D")),
        ?_assertBinaryEqual("100", Translate("A")),

        ?_assertBinaryEqual("011", Translate("MD")),
        ?_assertBinaryEqual("011", Translate("DM")),

        ?_assertBinaryEqual("101", Translate("AM")),
        ?_assertBinaryEqual("101", Translate("MA")),

        ?_assertBinaryEqual("110", Translate("AD")),
        ?_assertBinaryEqual("110", Translate("DA")),

        ?_assertBinaryEqual("111", Translate("AMD")),
        ?_assertBinaryEqual("111", Translate("ADM")),
        ?_assertBinaryEqual("111", Translate("MAD")),
        ?_assertBinaryEqual("111", Translate("MDA")),
        ?_assertBinaryEqual("111", Translate("DAM")),
        ?_assertBinaryEqual("111", Translate("DMA"))
    ].
