-module('VMPush_tests').
-include_lib("eunit/include/eunit.hrl").
-include("test-macros.hrl").

-import('VMPush', [translate/3]).

expected(constant) ->
"@10
D=A
@SP
A=M
M=D
@SP
M=M+1";

expected(static) ->
"@basename.10
D=M
@SP
A=M
M=D
@SP
M=M+1";

expected(local) ->
"@LCL
D=M
@10
A=D+A
D=M
@SP
A=M
M=D
@SP
M=M+1";

expected(argument) ->
"@ARG
D=M
@10
A=D+A
D=M
@SP
A=M
M=D
@SP
M=M+1";

expected(this) ->
"@THIS
D=M
@10
A=D+A
D=M
@SP
A=M
M=D
@SP
M=M+1";

expected(that) ->
"@THAT
D=M
@10
A=D+A
D=M
@SP
A=M
M=D
@SP
M=M+1";


expected(pointer0) ->
"@THIS
D=M
@SP
A=M
M=D
@SP
M=M+1";

expected(pointer1) ->
"@THAT
D=M
@SP
A=M
M=D
@SP
M=M+1".

translate_test_() ->
    MemorySegments = [constant, local, argument, this, that, static],
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
