-module('CTranslator').
-export([
    translate/1, tokenize/1, translate_dest/1, translate_jump/1,
    translate_calc/1
]).

translate(Instruction) ->
    {ok, {Dest, Calc, Jump}} = tokenize(Instruction),
    "111" ++
        translate_calc(Calc) ++
        translate_dest(Dest) ++
        translate_jump(Jump).

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

translate_jump("") -> "000";
translate_jump("JGT") -> "001";
translate_jump("JEQ") -> "010";
translate_jump("JGE") -> "011";
translate_jump("JLT") -> "100";
translate_jump("JNE") -> "101";
translate_jump("JLE") -> "110";
translate_jump("JMP") -> "111".

translate_calc(Calc) ->
    case string:chr(Calc, $M) of
        0 ->
            "0" ++ translate_calc(operation, Calc);
        _ ->
            "1" ++ translate_calc(
                operation, [case X of $M -> $A; _ -> X end || X <- Calc]
            )
    end.

translate_calc(operation, "0") -> "101010";
translate_calc(operation, "1") -> "111111";
translate_calc(operation, "-1") -> "111010";
translate_calc(operation, "D") -> "001100";
translate_calc(operation, "A") -> "110000";
translate_calc(operation, "!D") -> "001101";
translate_calc(operation, "!A") -> "110001";
translate_calc(operation, "-D") -> "001111";
translate_calc(operation, "-A") -> "110011";
translate_calc(operation, "D+1") -> "011111";
translate_calc(operation, "1+D") -> "011111";
translate_calc(operation, "A+1") -> "110111";
translate_calc(operation, "1+A") -> "110111";
translate_calc(operation, "D-1") -> "001110";
translate_calc(operation, "A-1") -> "110010";
translate_calc(operation, "D+A") -> "000010";
translate_calc(operation, "A+D") -> "000010";
translate_calc(operation, "D-A") -> "010011";
translate_calc(operation, "A-D") -> "000111";
translate_calc(operation, "D&A") -> "000000";
translate_calc(operation, "A&D") -> "000000";
translate_calc(operation, "D|A") -> "010101";
translate_calc(operation, "A|D") -> "010101".
