-module('Assembler').
-export([compile/1]).

compile(InputFilename) ->
    StartSymbolTable = dict:from_list([
        {"__next__", 16},
        {"R0", 0}, {"R1", 1}, {"R2", 2}, {"R3", 3}, {"R4", 4}, {"R5", 5},
        {"R6", 6}, {"R7", 7}, {"R8", 8}, {"R9", 9}, {"R10", 10}, {"R11", 11},
        {"R12", 12}, {"R13", 13}, {"R14", 14}, {"R15", 15},
        {"SP", 0}, {"LCL", 1}, {"ARG", 2}, {"THIS", 3}, {"THAT", 4},
        {"SCREEN", 16384}, {"KBD", 24576}
    ]),
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
