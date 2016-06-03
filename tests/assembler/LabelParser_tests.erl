-module('LabelParser_tests').
-include_lib("eunit/include/eunit.hrl").
-include("test-macros.hrl").

populate_symbols_test_() ->
    FixtureFile0 = ?fixture("simple-with-labels-and-vars.asm"),
    FixtureFile1 = ?fixture("simple-with-comments-and-whitespace.asm"),
    SymbolTable = dict:from_list([
        {"__next__", 16},
        {"R0", 0},
        {"SCREEN", 24576}
    ]),
    [
        check_symbol_populator(SymbolTable, FixtureFile0),
        check_symbol_populator(SymbolTable, FixtureFile1)
    ].

check_symbol_populator(SymbolTable, FixtureFile) ->
    Populate = fun 'LabelParser':populate_symbols/2,
    UpdatedSymbolTable = Populate(SymbolTable, FixtureFile),
    [
        ?_assertEqual({ok, 2}, dict:find("BEGIN", UpdatedSymbolTable)),
        ?_assertEqual({ok, 8}, dict:find("MAIN_LOOP", UpdatedSymbolTable)),
        ?_assertEqual({ok, 14}, dict:find("END", UpdatedSymbolTable)),

        ?_assertEqual({ok, 16}, dict:find("__next__", UpdatedSymbolTable)),
        ?_assertEqual({ok, 0}, dict:find("R0", UpdatedSymbolTable)),
        ?_assertEqual({ok, 24576}, dict:find("SCREEN", UpdatedSymbolTable))
    ].
