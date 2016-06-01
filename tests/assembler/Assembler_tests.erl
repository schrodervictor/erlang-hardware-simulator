-module('Assembler_tests').
-include_lib("eunit/include/eunit.hrl").

-define(
     fixture(Filename),
     filename:join([filename:dirname(?FILE), "../_fixtures", Filename])
).

-define(assertFileExists(Filename), ?assert(filelib:is_regular(Filename))).

-define(
     assertBinaryEqual(Expected, Actual),
     ?assertEqual(iolist_to_binary(Expected), iolist_to_binary(Actual))
).

compile_test() ->
    FixtureFilename = ?fixture("clean-with-labels.asm"),
    OutputFilename = ?fixture("clean-with-labels.hack"),
    ComparisonFilename = ?fixture("clean-with-labels.expected"),

    ok = 'Assembler':compile(FixtureFilename),

    ?assertFileExists(OutputFilename),

    {ok, Comparison} = file:open(ComparisonFilename, read),
    {ok, Output} = file:open(OutputFilename, read),

    compare_files(Comparison, Output).

compare_files(Comparison, Output) ->
    ExpectedLine = io:get_line(Comparison, ""),
    ResultLine = io:get_line(Output, ""),
    case ExpectedLine of
        eof ->
            ?assertEqual(ExpectedLine, ResultLine);
        _ ->
            ?assertBinaryEqual(ExpectedLine, ResultLine),
            compare_files(Comparison, Output)
    end.
