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
        %?_assert(IsWhitespace("// Something with comments")),

        ?_assertNot(IsWhitespace("(SOME_LABEL)")),
        ?_assertNot(IsWhitespace("@variable")),
        ?_assertNot(IsWhitespace("@12345")),
        ?_assertNot(IsWhitespace("D=M+1"))
    ].
