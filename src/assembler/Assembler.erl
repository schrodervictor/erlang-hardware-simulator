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
            {ok, UpdatedSymbolTable} =
                compile_line(Line, SymbolTable, Output),
            compile(Input, Output, UpdatedSymbolTable)
    end.

compile_line(Line, SymbolTable, Output) ->
    ATranslator = fun 'ATranslator':translate/2,
    CTranslator = fun 'CTranslator':translate/1,
    CleanLine = 'WhiteSpaceParser':clean_line(Line),
    case string:substr(CleanLine, 1, 1) of
        "" ->
            {ok, SymbolTable};
        "@" ->
            {ok, {Compiled, UpdatedSymbolTable}} =
                ATranslator(CleanLine, SymbolTable),
            io:fwrite(Output, "~s~n", [Compiled]),
            {ok, UpdatedSymbolTable};
        "(" ->
            {ok, SymbolTable};
        _ ->
            Compiled = CTranslator(CleanLine),
            io:fwrite(Output, "~s~n", [Compiled]),
            {ok, SymbolTable}
    end.
