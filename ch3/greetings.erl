-module(greetings).
-export([greet/2]).

greet(male, Name) ->
    io:format("Hello, Mr. ~s!~n",[Name]);
greet(female, Name) ->
    io:format("Hello, Ms. ~s!~n", [Name]);
greet(_, Name) ->
    io:format("Hello, ~s!~n",[Name]).