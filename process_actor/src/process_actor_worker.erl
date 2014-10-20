-module(process_actor_worker).
-export([work/0]).

work() ->
	receive 
		_ -> io:format("GOT!~n"), ok
	%after 2000 ->
		%io:format("2k!~n")
		%exit("Done?")
	end.
