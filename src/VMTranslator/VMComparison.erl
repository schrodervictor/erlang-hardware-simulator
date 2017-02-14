-module('VMComparison').
-export([translate/3]).

translate(eq, Counter, Basename) -> get_lines("JEQ", Counter, Basename);
translate(gt, Counter, Basename) -> get_lines("JGT", Counter, Basename);
translate(lt, Counter, Basename) -> get_lines("JLT", Counter, Basename).

get_lines(Jump, Counter, Basename) ->
    ID = Basename ++ "." ++ integer_to_list(Counter),
    Lines = [
        "@SP",
        "AM=M-1",
        "D=M",
        "A=A-1",
        "D=M-D",
        "@" ++ ID ++ ".PUSH.TRUE",
        "D;" ++ Jump,
        "// (" ++ ID ++ ".PUSH.FALSE)",
        "    D=0",
        "    @" ++ ID ++ ".PUSH.END",
        "    0;JMP",
        "(" ++ ID ++ ".PUSH.TRUE)",
        "    D=-1",
        "(" ++ ID ++ ".PUSH.END)",
        "    @SP",
        "    A=M-1",
        "    M=D"
    ],
    {ok, string:join(Lines, "\n")}.
