-module('WhiteSpaceParser_tests').
-include_lib("eunit/include/eunit.hrl").

-define(
     _assertBinaryEqual(Expected, Actual),
     ?_assertEqual(iolist_to_binary(Expected), iolist_to_binary(Actual))
).

is_white_line_test_() ->
    IsWhitespace = fun 'WhiteSpaceParser':is_white_line/1,
    [
        ?_assert(IsWhitespace("")),
        ?_assert(IsWhitespace("      ")),
        ?_assert(IsWhitespace("	")),
        ?_assert(IsWhitespace("// Something with comments")),

        ?_assertNot(IsWhitespace("(SOME_LABEL)")),
        ?_assertNot(IsWhitespace("@variable")),
        ?_assertNot(IsWhitespace("@12345")),
        ?_assertNot(IsWhitespace("D=M+1"))
    ].

strip_comments_test_() ->
    StripComments = fun 'WhiteSpaceParser':strip_comments/1,
    [
        ?_assertEqual("", StripComments("// Some comments")),
        ?_assertEqual("    ", StripComments("    // Some comments")),
        ?_assertEqual("	", StripComments("	// Some comments")),
        ?_assertEqual("  @234  ", StripComments("  @234  // Some comments"))
    ].

strip_all_white_space_test_() ->
    StripWS = fun 'WhiteSpaceParser':strip_all_white_space/1,
    [
        ?_assertEqual("", StripWS("    ")),
        ?_assertEqual("", StripWS("					")),
        ?_assertEqual("", StripWS("")),
        ?_assertEqual("@234", StripWS("	@234  ")),
        ?_assertEqual("MD=A+1;JMP", StripWS("	M D = A + 1 ; JMP   "))
    ].

clean_line_test_() ->
    Clean = fun 'WhiteSpaceParser':clean_line/1,
    [
        ?_assertEqual("", Clean("   // With comments")),
        ?_assertEqual("", Clean("					     // comments")),
        ?_assertEqual("", Clean("")),
        ?_assertEqual("@234", Clean("	@234  //  more comments")),
        ?_assertEqual("MD=A+1", Clean("	M D = A + 1 // comment; JMP"))
    ].
