-module('VMArithmetic').
-export([translate/1]).

translate(add) ->
    Lines = [
        "@SP",
        "AM=M-1",
        "D=M",
        "A=A-1",
        "M=D+M"
    ],
    {ok, string:join(Lines, "\n")};

translate(sub) ->
    Lines = [
        "@SP",
        "AM=M-1",
        "D=M",
        "A=A-1",
        "M=M-D"
    ],
    {ok, string:join(Lines, "\n")};

translate(neg) ->
    Lines = [
        "@SP",
        "A=M-1",
        "M=-M"
    ],
    {ok, string:join(Lines, "\n")}.
