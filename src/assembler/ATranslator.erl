-module('ATranslator').
-export([translate/2]).

translate("@" ++ Address, SymbolTable) ->
    case string:to_integer(Address) of
        {error, no_integer} ->
            {ok, translate_symbol(Address, SymbolTable)};
        {Num, _} ->
            {ok, {translate_numeric(Num), SymbolTable}}
    end.

translate_numeric(Num) -> io_lib:format("~16..0s", [integer_to_list(Num, 2)]).

translate_symbol(Label, SymbolTable) ->
    case dict:find(Label, SymbolTable) of
        {ok, Value} -> {translate_numeric(Value), SymbolTable};
        _ ->
            UpdatedTable = allocate_symbol(Label, SymbolTable),
            translate_symbol(Label, UpdatedTable)
    end.

allocate_symbol(Label, SymbolTable) ->
    {ok, Value} = dict:find("__next__", SymbolTable),
    UpdatedSymbolTable = dict:store("__next__", Value + 1, SymbolTable),
    dict:store(Label, Value, UpdatedSymbolTable).
