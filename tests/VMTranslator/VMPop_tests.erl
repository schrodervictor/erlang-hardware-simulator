-module('VMPop_tests').
-include_lib("eunit/include/eunit.hrl").
-include("test-macros.hrl").

-import('VMPop', [translate/3]).

expected(static) ->
"@SP
AM=M-1
D=M
@basename.10
M=D";

expected(local) ->
"@LCL
D=M
@10
D=D+A
@addr
M=D
@SP
AM=M-1
D=M
@addr
A=M
M=D";

expected(argument) ->
"@ARG
D=M
@10
D=D+A
@addr
M=D
@SP
AM=M-1
D=M
@addr
A=M
M=D";

expected(this) ->
"@THIS
D=M
@10
D=D+A
@addr
M=D
@SP
AM=M-1
D=M
@addr
A=M
M=D";

expected(that) ->
"@THAT
D=M
@10
D=D+A
@addr
M=D
@SP
AM=M-1
D=M
@addr
A=M
M=D";

expected(pointer0) ->
"@SP
AM=M-1
D=M
@THIS
M=D";

expected(pointer1) ->
"@SP
AM=M-1
D=M
@THAT
M=D".

translate_test_() ->
    MemorySegments = [local, argument, this, that, static],
    Results = [
        {Mem, translate(Mem, "10", "basename")}
        ||
        Mem <- MemorySegments
    ],
    [?_assertEqual(expected(Mem), Code) || {Mem, {ok, Code}} <- Results].

translate_pointers_test_() ->
    Values = ["0", "1"],
    Results = [
        {list_to_atom("pointer" ++ V), translate(pointer, V, "basename")}
        ||
        V <- Values
    ],
    [?_assertEqual(expected(Mem), Code) || {Mem, {ok, Code}} <- Results].
