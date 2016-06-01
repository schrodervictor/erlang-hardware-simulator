-module('WhiteSpaceParser').
-export([is_white_line/1]).

is_white_line(Line) ->
    CleanLine = string:tokens(Line, " 	"),
    0 =:= length(CleanLine).
