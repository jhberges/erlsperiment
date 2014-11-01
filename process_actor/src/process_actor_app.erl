-module(process_actor_app).
-behaviour(application).

-export([start/2]).
-export([stop/1]).

start(_Type, _Args) ->
	process_actor_sup:start_link().

stop(_State) ->
	ok.
