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
            io:fwrite(Output, "// ~s", [Line]),
            {ok, Translated} = translate_line(Line, Basename),
            io:fwrite(Output, "~s~n", [Translated]),
            translate(Input, Output, Basename)
    end.

translate_line(Line, Basename) ->
    Tokens = string:tokens(Line, " 	\n"),
    {ok, Assembly} = translate_tokens(Tokens, Basename),
    {ok, Assembly}.

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
