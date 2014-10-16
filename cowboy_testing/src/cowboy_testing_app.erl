-module(cowboy_testing_app).
-behaviour(application).

-export([start/2]).
-export([stop/1]).

start(_Type, _Args) ->
	Dispatch = cowboy_router:compile([
		{'_', [{"/api/1/items"   , cowboy_testing_handler, []},
		       {"/api/1/item/:id", cowboy_testing_handler_too, []}]}
	]),
	cowboy:start_http(cowboy_testing_http_listener, 100, [{port, 8080}],
		[{env, [{dispatch, Dispatch}]}]
	),
	cowboy_testing_sup:start_link().

stop(_State) ->
	ok.
