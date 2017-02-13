-module('VMTranslator').
-export([translate/1]).

translate(InputFilename) ->
    OutputFilename = lists:flatten([
        filename:rootname(InputFilename, ".vm"), ".asm"
    ]),

    {ok, Input} = file:open(InputFilename, read),
    {ok, Output} = file:open(OutputFilename, write),

    Basename = filename:basename(InputFilename, ".vm"),

    ok = translate(Input, Output, Basename),

    file:close(Input),
    file:close(Output).

translate(Input, Output, Basename) ->
    case io:get_line(Input, "") of
        eof -> ok;
        Line ->
            io:fwrite(Output, "// ~s", [Line]),
            {ok, Translated} = translate_line(Line, Basename),
            io:fwrite(Output, "~s~n", [Translated]),
            translate(Input, Output, Basename)
    end.


translate_line(Line, Basename) ->
    Tokens = string:tokens(Line, " 	\n"),
    {ok, Assembly} = translate_tokens(Tokens, Basename),
    {ok, Assembly}.

translate_tokens(["push", "constant", Value|_], _) ->
    Lines = [
        "@" ++ Value,
        "D=A",
        inc_stack()
    ],
    {ok, string:join(Lines, "\n")};

translate_tokens(["push", "static", Value|_], Basename) ->
    Lines = [
        "@" ++ Basename ++ "." ++ Value,
        "D=M",
        inc_stack()
    ],
    {ok, string:join(Lines, "\n")};

translate_tokens(["push", "temp", Value|_], _) ->
    TempAddress = integer_to_list(5 + list_to_integer(Value)),
    Lines = [
        "@" ++ TempAddress,
        "D=M",
        inc_stack()
    ],
    {ok, string:join(Lines, "\n")};

translate_tokens(["push", "pointer", Value|_], _) ->
    SegmentCode = segment_code("pointer" ++ Value),
    Lines = [
        "@" ++ SegmentCode,
        "D=M",
        inc_stack()
    ],
    {ok, string:join(Lines, "\n")};

translate_tokens(["push", Segment, Value|_], _) ->
    SegmentCode = segment_code(Segment),
    Lines = [
        "@" ++ SegmentCode,
        "D=M",
        "@" ++ Value,
        "A=D+A",
        "D=M",
        inc_stack()
    ],
    {ok, string:join(Lines, "\n")}.

inc_stack() ->
    Lines = [
        "@SP",
        "A=M",
        "M=D",
        "@SP",
        "M=M+1"
    ],
    string:join(Lines, "\n").

segment_code("local") -> "LCL";
segment_code("argument") -> "ARG";
segment_code("this") -> "THIS";
segment_code("that") -> "THAT";
segment_code("pointer0") -> "THIS";
segment_code("pointer1") -> "THAT".
