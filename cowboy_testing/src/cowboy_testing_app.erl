-module(cowboy_testing_app).
-behaviour(application).

-export([start/2]).
-export([stop/1]).

start(_Type, _Args) ->
	Dispatch = cowboy_router:compile([
		{'_', [{"/", cowboy_testing_handler, []}]}
	]),
	cowboy:start_http(cowboy_testing_http_listener, 100, [{port, 8080}],
		[{env, [{dispatch, Dispatch}]}]
	),
	cowboy_testing_sup:start_link().

stop(_State) ->
	ok.
