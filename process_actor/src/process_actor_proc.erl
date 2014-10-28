-module(process_actor_proc).
-export([proc/0]).
-export([proc_start_link/0]).

proc_start_link() -> 
	io:format("proc_start_link~n"),
	ModulePid = spawn_link(process_actor_worker, work, []),
	global:register_name(process_actor_worker_pid, ModulePid),
	ModulePid.

proc() ->
	receive 
		{From, {item, ItemId}} ->
			From ! {self(), ok},
			io:write(ItemId),
			ok;
		Unexpected ->
			io:format("unexpected message ~p~n", [Unexpected])
	end.
