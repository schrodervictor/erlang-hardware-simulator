-module('ATranslator').
-export([translate/2]).

translate("@" ++ Address, SymbolTable) ->
    case string:to_integer(Address) of
        {error, no_integer} -> {error, not_implemented};
        {Num, _} -> {ok, {integerToBinary(Num), SymbolTable}}
    end.

integerToBinary(Num) -> io_lib:format("~16..0s", [integer_to_list(Num, 2)]).
