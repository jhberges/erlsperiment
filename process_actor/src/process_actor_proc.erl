-module(process_actor_proc).
-export([proc/0]).

proc() ->
	receive 
		{From, {item, ItemId}} ->
			From ! {self(), ok},
			io:write(ItemId),
			ok;
		Unexpected ->
			io:format("unexpected message ~p~n", [Unexpected])
	end.
