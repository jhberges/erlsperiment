-module(process_actor_worker).
-export([work/0, init/0]).

init() -> work().

% Tailrecursive command fun
work() ->
	io:format("work()~n"),
	receive 
		{Pid,_} -> 
			io:format("GOT!~n"),
			Pid ! ok,
			work()
%	after 2000 ->
%		io:format("2k!~n")
%		exit("Done?")
	end.
