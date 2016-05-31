-module('ATranslator').
-export([translate/2]).

translate("@" ++ Address, SymbolTable) ->
    case string:to_integer(Address) of
        {error, no_integer} ->
            {ok, symbolToBinary(Address, SymbolTable)};
        {Num, _} ->
            {ok, {integerToBinary(Num), SymbolTable}}
    end.

integerToBinary(Num) -> io_lib:format("~16..0s", [integer_to_list(Num, 2)]).

symbolToBinary(Label, SymbolTable) ->
    case dict:find(Label, SymbolTable) of
        {ok, Value} -> {integerToBinary(Value), SymbolTable};
        _ -> {error, not_implemented}
    end.
