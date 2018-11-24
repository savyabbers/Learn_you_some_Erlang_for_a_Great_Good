-module(kitchen).
-compile(export_all).

fridge1() -> %stateless function
    receive
        {From,{stor,_Food}} ->
            From ! {self(), ok},
            fridge1();
        {From,{take, _Food}} ->
            %% todo
            From ! {self(), not_found},
            fridge1();
        terminate ->
            ok
    end.

fridge2(FoodList) ->
    receive
        {From, {store, Food}} ->
            From ! {self(), ok},
            fridge2([Food|FoodList]);
        {From, {take, Food}} ->
            case lists:member(Food, FoodList) of
                true ->
                    From ! {self(), {ok, Food}},
                    fridge2(lists:delete(Food,FoodList));
                false ->
                    From ! {self(), not_found},
                    fridge2(FoodList)
            end;
        {From, look} ->
            From ! {self(), FoodList},
            fridge2(FoodList);
        terminate ->
            ok
    end.

%% Helper functions. 
store(Pid, Food) -> 
    Pid ! {self(), {store, Food}},
    receive
        {Pid, Msg} -> Msg
    after 3000 -> % if 3 seconds passed with not retreving message. then do this
        timeout
    end.

take(Pid, Food) ->
    Pid ! {self(), {take, Food}},
    receive
        {Pid, Msg} -> Msg
    after 3000 ->
        timeout
    end.

look(Pid) ->
    Pid ! {self(), look},
    receive
        {Pid, Msg} -> Msg
    after 3000 ->
        timeout
    end.

start(FoodList) ->
    spawn(?MODULE, fridge2, [FoodList]).