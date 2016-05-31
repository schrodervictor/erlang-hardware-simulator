-module('ATranslator_tests').
-include_lib("eunit/include/eunit.hrl").

-define(
     _assertBinaryEqual(Expected, Actual),
     ?_assertEqual(iolist_to_binary(Expected), iolist_to_binary(Actual))
).

translate_test_() ->
    {setup, fun translate_setup/0, fun translate_handles_numeric/1}.

translate_setup() ->
    ATranslate = fun 'ATranslator':translate/2,
    SymbolTable = dict:from_list([]),
    {ATranslate, SymbolTable}.

translate_handles_numeric({ATranslate, SymbolTable}) ->
    {ok, {Result0, SymbolTable0}} = ATranslate("@137", SymbolTable),
    {ok, {Result1, SymbolTable1}} = ATranslate("@0", SymbolTable),
    {ok, {Result2, SymbolTable2}} = ATranslate("@32767", SymbolTable),
    [
        ?_assertBinaryEqual("0000000010001001", Result0),
        ?_assertEqual(SymbolTable, SymbolTable0),
        ?_assertBinaryEqual("0000000000000000", Result1),
        ?_assertEqual(SymbolTable, SymbolTable1),
        ?_assertBinaryEqual("0111111111111111", Result2),
        ?_assertEqual(SymbolTable, SymbolTable2)
    ].
