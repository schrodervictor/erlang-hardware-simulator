-module('Assembler').
-export([compile/1]).

compile(InputFilename) ->
    StartSymbolTable = dict:from_list([{"__next__", 16}]),
    SymbolTable =
        'LabelParser':populate_symbols(StartSymbolTable, InputFilename),
    OutputFilename = lists:flatten([
        filename:rootname(InputFilename, ".asm"), ".hack"
    ]),

    {ok, Input} = file:open(InputFilename, read),
    {ok, Output} = file:open(OutputFilename, write),

    ok = compile(Input, Output, SymbolTable),

    file:close(Input),
    file:close(Output),

    io:format("Compilation ended successfully").

compile(Input, Output, SymbolTable) ->
    case io:get_line(Input, "") of
        eof -> ok;
        Line ->
            CleanLine = 'WhiteSpaceParser':clean_line(Line),
            {ok, UpdatedSymbolTable} =
                compile_line(CleanLine, SymbolTable, Output),
            compile(Input, Output, UpdatedSymbolTable)
    end.

compile_line("", SymbolTable, _Output) -> {ok, SymbolTable};
compile_line("(" ++ _, SymbolTable, _Output) -> {ok, SymbolTable};

compile_line("@" ++ _ = Line, SymbolTable, Output) ->
    compile_with(fun 'ATranslator':translate/2, Line, SymbolTable, Output);

compile_line(Line, SymbolTable, Output) ->
    compile_with(fun 'CTranslator':translate/2, Line, SymbolTable, Output).

compile_with(Translator, Line, SymbolTable, Output) ->
    {ok, {Compiled, UpdatedSymbolTable}} = Translator(Line, SymbolTable),
    io:fwrite(Output, "~s~n", [Compiled]),
    {ok, UpdatedSymbolTable}.
