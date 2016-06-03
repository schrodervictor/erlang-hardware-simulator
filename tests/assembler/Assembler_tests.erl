-module('Assembler_tests').
-include_lib("eunit/include/eunit.hrl").
-include("test-macros.hrl").

compile_test_() ->
    FixtureFile0 = ?fixture("simple.asm"),
    OutputFile0 = ?fixture("simple.hack"),

    FixtureFile1 = ?fixture("simple-with-labels-and-vars.asm"),
    OutputFile1 = ?fixture("simple-with-labels-and-vars.hack"),

    FixtureFile2 = ?fixture("simple-with-comments-and-whitespace.asm"),
    OutputFile2 = ?fixture("simple-with-comments-and-whitespace.hack"),

    ComparisonFile = ?fixture("simple.expected"),
    [
        try_compilation(FixtureFile0, OutputFile0, ComparisonFile),
        try_compilation(FixtureFile1, OutputFile1, ComparisonFile),
        try_compilation(FixtureFile2, OutputFile2, ComparisonFile)
    ].

try_compilation(FixtureFile, OutputFile, ComparisonFile) ->
    file:delete(OutputFile),
    ok = 'Assembler':compile(FixtureFile),
    {ok, Comparison} = file:read_file(ComparisonFile),
    {ok, Output} = file:read_file(OutputFile),
    [
        ?_assertFileExists(OutputFile),
        ?_assertEqual(Comparison, Output)
    ].
