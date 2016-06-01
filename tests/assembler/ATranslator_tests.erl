-module('ATranslator_tests').
-include_lib("eunit/include/eunit.hrl").
-include("test-macros.hrl").

translate_test_() ->
    {setup,
        fun translate_setup/0,
        fun(SetupData) -> [
            translate_handles_numeric(SetupData),
            translate_handles_labeled_existent(SetupData),
            translate_handles_labeled_not_existent(SetupData)
        ] end
    }.

translate_setup() ->
    ATranslate = fun 'ATranslator':translate/2,
    SymbolTable = dict:from_list([{"__next__", 16}, {"LOOP", 10}]),
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

translate_handles_labeled_existent({ATranslate, SymbolTable}) ->
    {ok, {Result0, SymbolTable0}} = ATranslate("@LOOP", SymbolTable),
    [
        ?_assertBinaryEqual("0000000000001010", Result0),
        ?_assertEqual(SymbolTable, SymbolTable0)
    ].

translate_handles_labeled_not_existent({ATranslate, SymbolTable}) ->
    {ok, {Result0, SymbolTable0}} = ATranslate("@var", SymbolTable),
    {ok, {Result1, SymbolTable1}} = ATranslate("@foo", SymbolTable0),
    {ok, {Result2, SymbolTable2}} = ATranslate("@bar", SymbolTable1),
    {ok, {Result3, SymbolTable3}} = ATranslate("@var", SymbolTable2),
    [
        ?_assertBinaryEqual("0000000000010000", Result0),
        ?_assertBinaryEqual("0000000000010001", Result1),
        ?_assertBinaryEqual("0000000000010010", Result2),
        ?_assertBinaryEqual("0000000000010000", Result3),

        ?_assertEqual({ok, 16}, dict:find("var", SymbolTable0)),
        ?_assertEqual({ok, 16}, dict:find("var", SymbolTable1)),
        ?_assertEqual({ok, 16}, dict:find("var", SymbolTable2)),
        ?_assertEqual({ok, 16}, dict:find("var", SymbolTable3)),

        ?_assertEqual({ok, 17}, dict:find("foo", SymbolTable1)),
        ?_assertEqual({ok, 17}, dict:find("foo", SymbolTable2)),
        ?_assertEqual({ok, 17}, dict:find("foo", SymbolTable3)),

        ?_assertEqual({ok, 18}, dict:find("bar", SymbolTable2)),
        ?_assertEqual({ok, 18}, dict:find("bar", SymbolTable3)),

        ?_assertEqual(SymbolTable2, SymbolTable3)
    ].
