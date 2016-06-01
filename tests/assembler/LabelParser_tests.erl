-module('LabelParser_tests').
-include_lib("eunit/include/eunit.hrl").

-define(
     fixture(Filename),
     filename:join([filename:dirname(?FILE), "../_fixtures", Filename])
).

populate_symbols_test_() ->
    Populate = fun 'LabelParser':populate_symbols/2,
    FixtureFile = ?fixture("clean-with-labels.asm"),
    SymbolTable = dict:from_list([
        {"__next__", 16},
        {"R0", 0},
        {"SCREEN", 24576}
    ]),
    UpdatedSymbolTable = Populate(SymbolTable, FixtureFile),
    [
        ?_assertEqual({ok, 2}, dict:find("BEGIN", UpdatedSymbolTable)),
        ?_assertEqual({ok, 8}, dict:find("MAIN_LOOP", UpdatedSymbolTable)),
        ?_assertEqual({ok, 14}, dict:find("END", UpdatedSymbolTable)),

        ?_assertEqual({ok, 16}, dict:find("__next__", UpdatedSymbolTable)),
        ?_assertEqual({ok, 0}, dict:find("R0", UpdatedSymbolTable)),
        ?_assertEqual({ok, 24576}, dict:find("SCREEN", UpdatedSymbolTable))
    ].
