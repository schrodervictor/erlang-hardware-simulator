-module('DFF').
-export([create/0]).

create() ->
    DataPid = spawn(fun() -> data_store(0) end),
    fun(tick) ->
        DataPid ! {self(), tick},
        receive
            {DataPid, tick, OldBit} -> OldBit
        end;
    (Bit) ->
        DataPid ! {self(), tock, Bit},
        receive
            {DataPid, tock, ok} -> ok
        end
    end.

data_store(Bit) ->
    receive
        {Sender, tick} ->
            Sender ! {self(), tick, Bit},
            data_store(Bit);
        {Sender, tock, NewBit} ->
            Sender ! {self(), tock, ok},
            data_store(NewBit)
    end.
