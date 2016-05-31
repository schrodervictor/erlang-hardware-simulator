-module('CTranslator').
-export([translate/1, tokenize/1]).

translate(_Instruction) -> {error, not_implemented}.

tokenize(Instruction) ->
    Check = fun(Char) -> string:chr(Instruction, Char) end,
    tokenize(Instruction, Check($=), Check($;)).

tokenize(Instruction, _HasEqualSign = 0, _HasSemicolon) ->
    [Calc, Jump] = string:tokens(Instruction, ";"),
    {ok, {"", Calc, Jump}};

tokenize(Instruction, _HasEqualSign, _HasSemicolon = 0) ->
    [Dest, Calc] = string:tokens(Instruction, "="),
    {ok, {Dest, Calc, ""}};

tokenize(Instruction, _, _) ->
    [Dest, Calc, Jump] = string:tokens(Instruction, ";="),
    {ok, {Dest, Calc, Jump}}.
