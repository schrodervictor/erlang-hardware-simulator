-module('VMTranslator').
-export([translate/1, segment_code/1]).

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
            write_translated_line(Output, Line, Basename),
            translate(Input, Output, Basename)
    end.

write_translated_line(Output, Line, Basename) ->
    case translate_line(Line, Basename) of
        null -> ok;
        comment ->
            io:fwrite(Output, "~s", [Line]);
        {ok, Assembly} ->
            io:fwrite(Output, "// ~s", [Line]),
            io:fwrite(Output, "~s~n", [Assembly])
    end.


translate_line(Line, Basename) ->
    Tokens = string:tokens(Line, " 	\n"),
    translate_tokens(Tokens, Basename).

translate_tokens("", _) -> null;

translate_tokens(["//"|_], _) -> comment;

translate_tokens(["push", Segment, Value|_], Basename) ->
    'VMPush':translate(list_to_atom(Segment), Value, Basename);

translate_tokens(["pop", Segment, Value|_], Basename) ->
    'VMPop':translate(list_to_atom(Segment), Value, Basename);

translate_tokens(["add"|_], _) -> 'VMArithmetic':translate(add);
translate_tokens(["sub"|_], _) -> 'VMArithmetic':translate(sub);
translate_tokens(["neg"|_], _) -> 'VMArithmetic':translate(neg).

segment_code(local) -> "LCL";
segment_code(argument) -> "ARG";
segment_code(this) -> "THIS";
segment_code(that) -> "THAT";
segment_code(pointer0) -> "THIS";
segment_code(pointer1) -> "THAT".
