-module(cowboy_testing_handler_too).

-export([init/3]).
-export([content_types_provided/2]).
-export([get_json/2]).

init(_, _Req, _Opts) ->
        {upgrade, protocol, cowboy_rest}.

content_types_provided(Req, State) ->
        {[{{<<"application">>, <<"json">>, '*'}, get_json}], Req, State}.

process_item(ItemId) ->
	case global:whereis_name(process_actor_event) of
		undefined ->
			io:format("No proc!~n");
		ProcessorPid ->
			gen_event:sync_notify(ProcessorPid, ItemId)
	end.


get_json(Req, State) ->
        case cowboy_req:binding(id, Req) of
                undefined ->
                        {<<"UNDEFINED?">>, Req, State};
                {ItemId, Req2} ->
			{jiffy:encode({[{state,process_item(ItemId)}]}), Req2, State}
        end.

