-module('Nand').
-export([chip/2]).

chip(0, 0) -> 1;
chip(0, 1) -> 1;
chip(1, 0) -> 1;
chip(1, 1) -> 0.
