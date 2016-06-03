-module('CTranslator_tests').
-include_lib("eunit/include/eunit.hrl").
-include("test-macros.hrl").

translate_test_() ->
    Translate = fun 'CTranslator':translate/2,
    SymbolTable = dict:from_list([]),
    {ok, {Comp0, UpdatedSymbolTable0}} = Translate("D=M+1", SymbolTable),
    {ok, {Comp1, UpdatedSymbolTable1}} = Translate("D=A+1", SymbolTable),
    {ok, {Comp2, UpdatedSymbolTable2}} = Translate("A-1;JGT", SymbolTable),
    {ok, {Comp3, UpdatedSymbolTable3}} = Translate("DM=A-1;JNE", SymbolTable),
    {ok, {Comp4, UpdatedSymbolTable4}} = Translate("0;JMP", SymbolTable),
    [
        ?_assertBinaryEqual("1111110111010000", Comp0),
        ?_assertEqual(SymbolTable, UpdatedSymbolTable0),
        ?_assertBinaryEqual("1110110111010000", Comp1),
        ?_assertEqual(SymbolTable, UpdatedSymbolTable1),
        ?_assertBinaryEqual("1110110010000001", Comp2),
        ?_assertEqual(SymbolTable, UpdatedSymbolTable2),
        ?_assertBinaryEqual("1110110010011101", Comp3),
        ?_assertEqual(SymbolTable, UpdatedSymbolTable3),
        ?_assertBinaryEqual("1110101010000111", Comp4),
        ?_assertEqual(SymbolTable, UpdatedSymbolTable4)
    ].

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

translate_jump_test_() ->
    Translate = fun 'CTranslator':translate_jump/1,
    [
        ?_assertBinaryEqual("000", Translate("")),
        ?_assertBinaryEqual("001", Translate("JGT")),
        ?_assertBinaryEqual("010", Translate("JEQ")),
        ?_assertBinaryEqual("011", Translate("JGE")),
        ?_assertBinaryEqual("100", Translate("JLT")),
        ?_assertBinaryEqual("101", Translate("JNE")),
        ?_assertBinaryEqual("110", Translate("JLE")),
        ?_assertBinaryEqual("111", Translate("JMP"))
    ].

translate_calc_test_() ->
    Translate = fun 'CTranslator':translate_calc/1,
    [
        %% Constants
        ?_assertBinaryEqual("0101010", Translate("0")),
        ?_assertBinaryEqual("0111111", Translate("1")),
        ?_assertBinaryEqual("0111010", Translate("-1")),

        %% DRegister
        ?_assertBinaryEqual("0001100", Translate("D")),
        ?_assertBinaryEqual("0001101", Translate("!D")),
        ?_assertBinaryEqual("0001111", Translate("-D")),
        ?_assertBinaryEqual("0011111", Translate("D+1")),
        ?_assertBinaryEqual("0011111", Translate("1+D")),
        ?_assertBinaryEqual("0001110", Translate("D-1")),

        %% ARegister
        ?_assertBinaryEqual("0110000", Translate("A")),
        ?_assertBinaryEqual("0110001", Translate("!A")),
        ?_assertBinaryEqual("0110011", Translate("-A")),
        ?_assertBinaryEqual("0110111", Translate("A+1")),
        ?_assertBinaryEqual("0110111", Translate("1+A")),
        ?_assertBinaryEqual("0110010", Translate("A-1")),

        %% DRegister / ARegister
        ?_assertBinaryEqual("0000010", Translate("D+A")),
        ?_assertBinaryEqual("0000010", Translate("A+D")),
        ?_assertBinaryEqual("0010011", Translate("D-A")),
        ?_assertBinaryEqual("0000111", Translate("A-D")),
        ?_assertBinaryEqual("0000000", Translate("D&A")),
        ?_assertBinaryEqual("0000000", Translate("A&D")),
        ?_assertBinaryEqual("0010101", Translate("D|A")),
        ?_assertBinaryEqual("0010101", Translate("A|D")),

        %% Memory
        ?_assertBinaryEqual("1110000", Translate("M")),
        ?_assertBinaryEqual("1110001", Translate("!M")),
        ?_assertBinaryEqual("1110011", Translate("-M")),
        ?_assertBinaryEqual("1110111", Translate("M+1")),
        ?_assertBinaryEqual("1110111", Translate("1+M")),
        ?_assertBinaryEqual("1110010", Translate("M-1")),

        %% DRegister / Memory
        ?_assertBinaryEqual("1000010", Translate("D+M")),
        ?_assertBinaryEqual("1000010", Translate("M+D")),
        ?_assertBinaryEqual("1010011", Translate("D-M")),
        ?_assertBinaryEqual("1000111", Translate("M-D")),
        ?_assertBinaryEqual("1000000", Translate("D&M")),
        ?_assertBinaryEqual("1000000", Translate("M&D")),
        ?_assertBinaryEqual("1010101", Translate("D|M")),
        ?_assertBinaryEqual("1010101", Translate("M|D"))
    ].
