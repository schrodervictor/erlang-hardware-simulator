-module('VMComparison_tests').
-include_lib("eunit/include/eunit.hrl").

-import('VMComparison', [translate/3]).

expected(eq) ->
"@SP
AM=M-1
D=M
A=A-1
D=M-D
@basename.0.PUSH.TRUE
D;JEQ
// (basename.0.PUSH.FALSE)
    D=0
    @basename.0.PUSH.END
    0;JMP
(basename.0.PUSH.TRUE)
    D=-1
(basename.0.PUSH.END)
    @SP
    A=M-1
    M=D";

expected(gt) ->
"@SP
AM=M-1
D=M
A=A-1
D=M-D
@basename.0.PUSH.TRUE
D;JGT
// (basename.0.PUSH.FALSE)
    D=0
    @basename.0.PUSH.END
    0;JMP
(basename.0.PUSH.TRUE)
    D=-1
(basename.0.PUSH.END)
    @SP
    A=M-1
    M=D";

expected(lt) ->
"@SP
AM=M-1
D=M
A=A-1
D=M-D
@basename.0.PUSH.TRUE
D;JLT
// (basename.0.PUSH.FALSE)
    D=0
    @basename.0.PUSH.END
    0;JMP
(basename.0.PUSH.TRUE)
    D=-1
(basename.0.PUSH.END)
    @SP
    A=M-1
    M=D".

translate_test_() ->
    Operators = [eq, gt, lt],
    Results = [
        {Operator, translate(Operator, 0, "basename")}
        ||
        Operator <- Operators
    ],
    [check_expectation(Result) || Result <- Results].

check_expectation({Operator, Result}) ->
    ?_assertEqual({ok, expected(Operator)}, Result).
