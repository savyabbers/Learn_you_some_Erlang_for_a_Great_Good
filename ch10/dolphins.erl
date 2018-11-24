-module(dolphins).
-export([dolphin1/0, dolphin2/0, dolphin3/0]).

dolphin1() ->
    receive
        do_a_flip ->
            io:format("How about no?~n");
        fish ->
            io:format("So long and thinks for the fish!~n");
        _ ->
            io:format("heh, we're smarter than you humans.~n")
    end.

dolphin2() ->
    receive
        {From, do_a_flip} ->
            From ! "How about no?";
        {From, fish} ->
            From ! "So long and thinks for the fish!";
        _ ->
            io:format("heh, we're smarter than you humans.~n")
    end.

dolphin3() ->
    receive
        {From, do_a_flip} ->
            From ! "How about no?",
            dolphin3();
        {From, fish} ->
            From ! "So long and thinks for all the fish!";

        _ ->
            io:format("Heh, we're smarter than you humans.~n"),
            dolphin3()
    end.