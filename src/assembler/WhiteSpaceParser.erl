-module('WhiteSpaceParser').
-export([is_white_line/1, strip_comments/1, strip_all_white_space/1]).

is_white_line(Line) ->
    WithoutComments = strip_comments(Line),
    CleanLine = string:tokens(WithoutComments, " 	"),
    0 =:= length(CleanLine).

strip_comments(Line) ->
    case string:str(Line, "//") of
        0 -> Line;
        CommentStart -> string:sub_string(Line, 1, CommentStart - 1)
    end.

strip_all_white_space(Line) -> string:tokens(Line, " 	").
