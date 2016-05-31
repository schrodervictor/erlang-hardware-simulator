-module('CTranslator').
-export([translate/1, tokenize/1, translate_dest/1]).

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

translate_dest(Dest) -> translate_dest(Dest, [$0,$0,$0]).
translate_dest([], Result) -> Result;
translate_dest([$A|Tail], [_,D,M]) -> translate_dest(Tail, [$1,D,M]);
translate_dest([$D|Tail], [A,_,M]) -> translate_dest(Tail, [A,$1,M]);
translate_dest([$M|Tail], [A,D,_]) -> translate_dest(Tail, [A,D,$1]).
