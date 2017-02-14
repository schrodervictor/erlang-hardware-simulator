-module('VMPush').
-export([translate/3]).

translate(constant, Value, _) ->
    Lines = [
        "@" ++ Value,
        "D=A",
        inc_stack_with_d()
    ],
    {ok, string:join(Lines, "\n")};

translate(static, Value, Basename) ->
    Lines = [
        "@" ++ Basename ++ "." ++ Value,
        "D=M",
        inc_stack_with_d()
    ],
    {ok, string:join(Lines, "\n")};

translate(temp, Value, _) ->
    TempAddress = integer_to_list(5 + list_to_integer(Value)),
    Lines = [
        "@" ++ TempAddress,
        "D=M",
        inc_stack_with_d()
    ],
    {ok, string:join(Lines, "\n")};

translate(pointer, Value, _) ->
    SegmentCode = segment_code(list_to_atom("pointer" ++ Value)),
    Lines = [
        "@" ++ SegmentCode,
        "D=M",
        inc_stack_with_d()
    ],
    {ok, string:join(Lines, "\n")};

translate(Segment, Value, _) ->
    SegmentCode = segment_code(Segment),
    Lines = [
        "@" ++ SegmentCode,
        "D=M",
        "@" ++ Value,
        "A=D+A",
        "D=M",
        inc_stack_with_d()
    ],
    {ok, string:join(Lines, "\n")}.

inc_stack_with_d() ->
    Lines = [
        "@SP",
        "A=M",
        "M=D",
        "@SP",
        "M=M+1"
    ],
    string:join(Lines, "\n").

segment_code(Segment) ->
    'VMTranslator':segment_code(Segment).
