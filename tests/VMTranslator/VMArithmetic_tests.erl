-module('VMArithmetic_tests').
-include_lib("eunit/include/eunit.hrl").

-import('VMArithmetic', [translate/1]).

expected(add) ->
"@SP
AM=M-1
D=M
A=A-1
M=D+M";

expected(sub) ->
"@SP
AM=M-1
D=M
A=A-1
M=M-D";

expected(neg) ->
"@SP
A=M-1
M=-M".

translate_test_() ->
    MemorySegments = [add, sub, neg],
    Results = [{Mem, translate(Mem)} || Mem <- MemorySegments],
    [check_expectation(Result) || Result <- Results].

check_expectation({Mem, Result}) ->
    ?_assertEqual({ok, expected(Mem)}, Result).
