-define(
     fixture(Filename),
     filename:join([filename:dirname(?FILE), "../_fixtures", Filename])
).

-define(assertFileExists(Filename), ?assert(filelib:is_regular(Filename))).

-define(
     assertBinaryEqual(Expected, Actual),
     ?assertEqual(iolist_to_binary(Expected), iolist_to_binary(Actual))
).

-define(
     _assertBinaryEqual(Expected, Actual),
     ?_assertEqual(iolist_to_binary(Expected), iolist_to_binary(Actual))
).
