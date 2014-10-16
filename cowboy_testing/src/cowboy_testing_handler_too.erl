-module(cowboy_testing_handler_too).

-export([init/3]).
-export([content_types_provided/2]).
-export([get_json/2]).

init(_, _Req, _Opts) ->
        {upgrade, protocol, cowboy_rest}.

content_types_provided(Req, State) ->
        {[{{<<"application">>, <<"json">>, '*'}, get_json}], Req, State}.

get_json(Req, State) ->
        %{<<"CHECK JSON">>, Req, State}.
        case cowboy_req:binding(id, Req) of
                undefined ->
                        {<<"UNDEFINED?">>, Req, State};
                {ItemId, Req2} ->
                        {jiffy:encode({[{item, ItemId}]}), Req2, State}
        end.

