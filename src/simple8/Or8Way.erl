-module('Or8Way').
-export([chip/1]).

chip({A0, A1, A2, A3, A4, A5, A6, A7}) ->
    Or01 = 'Or':chip(A0, A1),
    Or23 = 'Or':chip(A2, A3),
    Or45 = 'Or':chip(A4, A5),
    Or67 = 'Or':chip(A6, A7),
    Or0123 = 'Or':chip(Or01, Or23),
    Or4567 = 'Or':chip(Or45, Or67),
    'Or':chip(Or0123, Or4567).
