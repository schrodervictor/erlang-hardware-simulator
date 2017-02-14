-module('VMTranslator').
-export([translate/1, segment_code/1]).

translate(InputFilename) ->
    OutputFilename = lists:flatten([
        filename:rootname(InputFilename, ".vm"), ".asm"
    ]),

    {ok, Input} = file:open(InputFilename, read),
    {ok, Output} = file:open(OutputFilename, write),

    Basename = filename:basename(InputFilename, ".vm"),

    ok = translate(Input, Output, Basename, 0),

    file:close(Input),
    file:close(Output).

translate(Input, Output, Basename, LineNum) ->
    case io:get_line(Input, "") of
        eof -> ok;
        Line ->
            write_translated_line(Output, Line, Basename, LineNum),
            translate(Input, Output, Basename, LineNum+1)
    end.

write_translated_line(Output, Line, Basename, LineNum) ->
    case translate_line(Line, Basename, LineNum) of
        null -> ok;
        comment ->
            io:fwrite(Output, "~s", [Line]);
        {ok, Assembly} ->
            io:fwrite(Output, "// ~s", [Line]),
            io:fwrite(Output, "~s~n", [Assembly])
    end.


translate_line(Line, Basename, LineNum) ->
    Tokens = string:tokens(Line, " 	\n"),
    translate_tokens(Tokens, Basename, LineNum).

translate_tokens("", _, _) -> null;

translate_tokens(["//"|_], _, _) -> comment;

translate_tokens(["push", Segment, Value|_], Basename, _) ->
    'VMPush':translate(list_to_atom(Segment), Value, Basename);

translate_tokens(["pop", Segment, Value|_], Basename, _) ->
    'VMPop':translate(list_to_atom(Segment), Value, Basename);

translate_tokens(["add"|_], _, _) -> 'VMArithmetic':translate(add);
translate_tokens(["sub"|_], _, _) -> 'VMArithmetic':translate(sub);
translate_tokens(["neg"|_], _, _) -> 'VMArithmetic':translate(neg);

translate_tokens(["not"|_], _, _) -> 'VMLogic':translate('not');
translate_tokens(["and"|_], _, _) -> 'VMLogic':translate('and');
translate_tokens(["or"|_], _, _) -> 'VMLogic':translate('or');

translate_tokens(["eq"|_], Basename, LineNum) ->
    'VMComparison':translate(eq, LineNum, Basename);

translate_tokens(["gt"|_], Basename, LineNum) ->
    'VMComparison':translate(gt, LineNum, Basename);

translate_tokens(["lt"|_], Basename, LineNum) ->
    'VMComparison':translate(lt, LineNum, Basename).

segment_code(local) -> "LCL";
segment_code(argument) -> "ARG";
segment_code(this) -> "THIS";
segment_code(that) -> "THAT";
segment_code(pointer0) -> "THIS";
segment_code(pointer1) -> "THAT".
