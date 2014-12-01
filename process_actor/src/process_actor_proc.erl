-module(process_actor_proc).
-behavior(gen_event).
-export([init/1, code_change/3, handle_event/2, handle_call/2, terminate/2, handle_info/2]). %gen_event exports
-export([start_link/0]).

start_link() -> 
	io:format("proc_start_link~n"),
	{State, ServerPid} = gen_event:start_link({global, process_actor_event}),
        gen_event:add_handler(ServerPid, ?MODULE, []),
	io:format("ServerPid is ~p~n", [ServerPid]),
	{State, ServerPid}.

init(_Args) -> 
	io:format("proc-init~n"),
	{ok, nothing}.

handle_event(Data, State) ->
	io:format("handle_call ~p~n", [Data]),
	timer:sleep(3000),
	io:format("slept~n"),
	{ok, State}.

handle_call(_Message, State) ->
	{ok, noreply, State}.

handle_info(_Message, State) ->
	{ok, State}.

code_change(_PreviousVersion, State, _Extra) ->
	{ok, State}.

terminate(_Reason, _State) ->
	io:format("terminate~n").	

