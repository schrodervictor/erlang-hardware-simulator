-module('RAM16K').
-export([create/0]).

%% Old implementation. Works in theory, but the amount of processes needed
%% by this memory unit is too high and it becomes really slow. To continue
%% with the project, we implement the memory access in a more efficient way
%% from the high level perspective. The old implementation is kept here for
%% learning reasons.
%
%create() ->
%    Mem0 = 'RAM4K':create(),
%    Mem1 = 'RAM4K':create(),
%    Mem2 = 'RAM4K':create(),
%    Mem3 = 'RAM4K':create(),
%    fun(NewBus, Load, {AD, AC, AB, AA, A9, A8, A7, A6, A5, A4, A3, A2, A1, A0}) ->
%        {Load0, Load1, Load2, Load3, Load4, Load5, Load6, Load7} =
%            'DMux4Way':chip(Load, {AD, AC}),
%        Bus0 = Mem0(NewBus, Load0, {AB, AA, A9, A8, A7, A6, A5, A4, A3, A2, A1, A0}),
%        Bus1 = Mem1(NewBus, Load1, {AB, AA, A9, A8, A7, A6, A5, A4, A3, A2, A1, A0}),
%        Bus2 = Mem2(NewBus, Load2, {AB, AA, A9, A8, A7, A6, A5, A4, A3, A2, A1, A0}),
%        Bus3 = Mem3(NewBus, Load3, {AB, AA, A9, A8, A7, A6, A5, A4, A3, A2, A1, A0}),
%        'Mux4Way16':chip(
%            Bus0, Bus1, Bus2, Bus3, {AD, AC}
%        )
%    end.

create() ->
    DataPid = spawn(fun() -> data_storage(gb_trees:empty()) end),
    Zero = {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
    fun(_, 0, Address) ->
        NumAddress = convert_base_10(Address),
        DataPid ! {self(), read, NumAddress},
        receive
            {DataPid, {value, Value}} -> Value;
            {DataPid, none} -> Zero
        end;
    (Bus, 1, Address) ->
        NumAddress = convert_base_10(Address),
        DataPid ! {self(), read, NumAddress},
        OldValue = receive
            {DataPid, {value, Value}} -> Value;
            {DataPid, none} -> Zero
        end,
        DataPid ! {self(), write, NumAddress, Bus},
        receive
            {DataPid, write_ok} -> OldValue
        end
    end.

data_storage(DataTree) ->
    receive
        {Sender, read, Address} ->
            Sender ! {self(), gb_trees:lookup(Address, DataTree)},
            data_storage(DataTree);
        {Sender, write, Address, Value} ->
            NewDataTree = gb_trees:enter(Address, Value, DataTree),
            Sender ! {self(), write_ok},
            data_storage(NewDataTree)
    end.

convert_base_10({AD, AC, AB, AA, A9, A8, A7, A6, A5, A4, A3, A2, A1, A0}) ->
    AD*8192 + AC*4096 + AB*2048 + AA*1024 + A9*512 + A8*256 +
    A7*128 + A6*64 + A5*32 + A4*16 + A3*8 + A2*4 + A1*2 + A0.
