-module('Not').
-export([chip/1]).

chip(Bit) -> 'Nand':chip(Bit, Bit).
