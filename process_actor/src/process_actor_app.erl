-module(process_actor_app).
-behaviour(application).

-export([start/2]).
-export([stop/1]).

start(_Type, _Args) ->
	ModulePid = spawn_link(process_actor_worker, work, []),
	global:register_name(process_actor_worker_pid, ModulePid),
	process_actor_sup:start_link().

stop(_State) ->
	ok.
