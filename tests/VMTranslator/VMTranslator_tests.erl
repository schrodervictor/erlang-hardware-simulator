-module('VMTranslator_tests').
-include_lib("eunit/include/eunit.hrl").
-include("test-macros.hrl").

compile_test_() ->
    [
        try_translation("push")
    ].

try_translation(Basename) ->
    FixtureFile = ?fixture(Basename ++ ".vm"),
    OutputFile = ?fixture(Basename ++ ".asm"),
    ComparisonFile = ?fixture(Basename ++ ".asm.expected"),

    file:delete(OutputFile),

    ok = 'VMTranslator':translate(FixtureFile),
    {ok, Comparison} = file:read_file(ComparisonFile),
    {ok, Output} = file:read_file(OutputFile),
    [
        ?_assertFileExists(OutputFile),
        ?_assertEqual(Comparison, Output)
    ].
