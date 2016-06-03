-module('LabelParser').
-export([populate_symbols/2]).

populate_symbols(SymbolTable, InputFile) ->
    {ok, IODevice} = file:open(InputFile, read),
    {ok, UpdatedSymbolTable} = populate_symbols(SymbolTable, IODevice, 0),
    file:close(IODevice),
    UpdatedSymbolTable.

populate_symbols(SymbolTable, IODevice, LineNum) ->
    case io:get_line(IODevice, "") of
        eof -> {ok, SymbolTable};
        Line ->
            populate_symbols_line(SymbolTable, IODevice, Line, LineNum)
    end.

populate_symbols_line(SymbolTable, IODevice, Line, LineNum) ->
    CleanLine = 'WhiteSpaceParser':clean_line(Line),
    case string:substr(CleanLine, 1, 1) of
        "" ->
            % Blank lines doesn't increment the line counter
            populate_symbols(SymbolTable, IODevice, LineNum);
        "(" ->
            Right = string:chr(Line, $)),
            Label = string:sub_string(Line, 2, Right - 1),
            UpdatedSymbolTable = dict:store(Label, LineNum, SymbolTable),
            populate_symbols(UpdatedSymbolTable, IODevice, LineNum);
        _ ->
            populate_symbols(SymbolTable, IODevice, LineNum + 1)
    end.
