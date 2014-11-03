-module(process_actor_proc).
-behavior(gen_server).
-export([proc/0]).
-export([init/1, code_change/3, handle_call/3, handle_cast/2, terminate/2, handle_info/2]). %gen_server exports
-export([start_link/0]).
% Should be gen_server, gen_event, gen_fsm, since started by supervisor?
start_link() -> 
	io:format("proc_start_link~n"),
	%ModulePid = spawn_link(fun init/1),%spawn_link(process_actor_worker,init, []),
	%io:format("worker spawned ~p~n", [ModulePid]),
	%global:register_name(process_actor_worker_pid, ModulePid),
	%ModulePid.
	{State,ServerPid} = gen_server:start_link(?MODULE, [], []),
	io:format("ServerPid is ~p~n", [ServerPid]),
	global:register_name(process_actor_server_pid, ServerPid),
	{State, ServerPid}.

init(_Args) -> 
	io:format("proc-init~n"),
	{ok, nothing}.

handle_call(Data, _From, State) ->
	io:format("handle_call ~p~n", [Data]),
	{reply, {data, Data},State}.

handle_cast(_Message, State) ->
	{noreply, State}.

handle_info(_Message, State) ->
	{noreply, State}.

code_change(_PreviousVersion, State, _Extra) ->
	{ok, State}.

terminate(_Reason, _State) ->
	io:format("terminate~n").	

proc() ->
	receive 
		{From, {item, ItemId}} ->
			From ! {self(), ok},
			io:write(ItemId),
			proc();
		Unexpected ->
			io:format("unexpected message ~p~n", [Unexpected]),
			proc()
	end.
