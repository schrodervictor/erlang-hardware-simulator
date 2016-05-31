-module('Inc16').
-export([chip/1]).

chip(Bus) ->
    'Add16':chip(Bus, {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1}).
