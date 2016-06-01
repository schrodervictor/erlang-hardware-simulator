-module('WhiteSpaceParser').
-export([is_white_line/1, strip_comments/1]).

is_white_line(Line) ->
    CleanLine = string:tokens(Line, " 	"),
    0 =:= length(CleanLine).

strip_comments(Line) ->
    case string:str(Line, "//") of
        0 -> Line;
        CommentStart -> string:sub_string(Line, 1, CommentStart - 1)
    end.
