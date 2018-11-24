-module(sorter).
-export([quicksort/1]).

quicksort([]) ->
    [];
quicksort([Pivot | List]) ->
    {Smaller, Lager} = partition(Pivot, List, [], []),
    quicksort(Smaller) ++ [Pivot] ++ quicksort(Lager).

partition(_, [], Smaller, Lager) ->
    {Smaller, Lager};
partition(Pivot, [H|T], Smaller, Lager) ->
    if H =< Pivot -> partition(Pivot, T, [H | Smaller], Lager);
       H >  Pivot -> partition(Pivot, T, Smaller, [H|Lager])
    end.