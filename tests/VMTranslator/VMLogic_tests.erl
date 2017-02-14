-module('VMLogic_tests').
-include_lib("eunit/include/eunit.hrl").

-import('VMLogic', [translate/1]).

expected('not') ->
"@SP
A=M-1
M=!M";

expected('and') ->
"@SP
AM=M-1
D=M
A=A-1
M=D&M";

expected('or') ->
"@SP
AM=M-1
D=M
A=A-1
M=D|M".

translate_test_() ->
    MemorySegments = ['not', 'and', 'or'],
    Results = [{Mem, translate(Mem)} || Mem <- MemorySegments],
    [check_expectation(Result) || Result <- Results].

check_expectation({Mem, Result}) ->
    ?_assertEqual({ok, expected(Mem)}, Result).
