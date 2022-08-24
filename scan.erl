#!/usr/bin/env escript

check(Port) ->
    Opts = [inet, {packet,0}, {active,false}],
    case gen_tcp:connect("192.168.0.200", Port, Opts) of
        {ok, Socket} ->
            gen_tcp:close(Socket),
            io:format("~p~n", [Port])
    end.

loop(128) ->
    ok;

loop(Port) ->
    spawn_link(fun() -> check(Port) end),
    loop(Port+1).

main(_) ->
    loop(0),
    timer:sleep(750).
