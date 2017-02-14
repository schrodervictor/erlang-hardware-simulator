-module('VMLogic').
-export([translate/1]).

translate('not') ->
    Lines = [
        "@SP",
        "A=M-1",
        "M=!M"
    ],
    {ok, string:join(Lines, "\n")};

translate('and') ->
    Lines = [
        "@SP",
        "AM=M-1",
        "D=M",
        "A=A-1",
        "M=D&M"
    ],
    {ok, string:join(Lines, "\n")};

translate('or') ->
    Lines = [
        "@SP",
        "AM=M-1",
        "D=M",
        "A=A-1",
        "M=D|M"
    ],
    {ok, string:join(Lines, "\n")}.
