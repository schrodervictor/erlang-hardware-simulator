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
        Line -> populate_symbols_line(SymbolTable, IODevice, Line, LineNum)
    end.

populate_symbols_line(SymbolTable, IODevice, Line, LineNum) ->
    Left = string:chr(Line, $(),
    Right = string:chr(Line, $)),
    case Left of
        0 -> populate_symbols(SymbolTable, IODevice, LineNum + 1);
        _ ->
            Label = string:sub_string(Line, Left + 1, Right - 1),
            UpdatedSymbolTable = dict:store(Label, LineNum, SymbolTable),
            populate_symbols(UpdatedSymbolTable, IODevice, LineNum)
    end.
