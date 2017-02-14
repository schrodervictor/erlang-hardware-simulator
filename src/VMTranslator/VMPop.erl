-module('VMPop').
-export([translate/3]).

translate(static, Value, Basename) ->
    Lines = [
        dec_stack_to_d(),
        "@" ++ Basename ++ "." ++ Value,
        "M=D"
    ],
    {ok, string:join(Lines, "\n")};

translate(temp, Value, _) ->
    TempAddress = integer_to_list(5 + list_to_integer(Value)),
    Lines = [
        dec_stack_to_d(),
        "@" ++ TempAddress,
        "M=D"
    ],
    {ok, string:join(Lines, "\n")};

translate(pointer, Value, _) ->
    SegmentCode = segment_code(list_to_atom("pointer" ++ Value)),
    Lines = [
        dec_stack_to_d(),
        "@" ++ SegmentCode,
        "M=D"
    ],
    {ok, string:join(Lines, "\n")};

translate(Segment, Value, _) ->
    SegmentCode = segment_code(Segment),
    Lines = [
        "@" ++ SegmentCode,
        "D=M",
        "@" ++ Value,
        "D=D+A",
        "@addr",
        "M=D",
        dec_stack_to_d(),
        "@addr",
        "A=M",
        "M=D"
    ],
    {ok, string:join(Lines, "\n")}.

dec_stack_to_d() ->
    Lines = [
        "@SP",
        "AM=M-1",
        "D=M"
    ],
    string:join(Lines, "\n").

segment_code(Segment) ->
    'VMTranslator':segment_code(Segment).
