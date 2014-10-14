-module(cowboy_testing_handler).

-export([init/3]).
-export([content_types_provided/2]).
-export([get_html/2]).
-export([get_json/2]).

init(_, _Req, _Opts) ->
	{upgrade, protocol, cowboy_rest}.

content_types_provided(Req, State) ->
	{[{{<<"text">>, <<"html">>, '*'}, get_html},
          {{<<"application">>, <<"json">>}, get_json}], Req, State}.

get_json(Req, State) ->
        case cowboy_req:binding(id, Req) of
                undefined ->
                        {<<"UNDEFINED?">>, Req, State};
                {ItemId, Req2} ->
                        {jiffy:encode({[{item, ItemId}]}), Req2, State}
        end.

get_html(Req, State) ->
	{<<"CHECK">>, Req, State}.	
