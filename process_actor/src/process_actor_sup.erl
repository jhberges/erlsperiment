-module(process_actor_sup).
-behaviour(supervisor).

-export([start_link/0]).
-export([init/1]).

start_link() ->
	io:format("supervisor start_link~n"),
        supervisor:start_link({global, ?MODULE}, ?MODULE, []).

init([]) ->
	io:format("supervisor link~n"),
        Procs = [{proc_act, {process_actor_proc, proc_start_link,[]},permanent, brutal_kill,worker, [process_actor_proc]}],
        {ok, {{one_for_one, 1, 5}, Procs}}.

