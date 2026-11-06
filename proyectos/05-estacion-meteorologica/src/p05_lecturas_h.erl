-module(p05_lecturas_h).
-export([init/2]).

%% POST /api/lecturas  con JSON: {"temperatura":..,"humedad":..,"presion":..,"viento":..}
init(Req0, State) ->
    {ok, Body, Req1} = cowboy_req:read_body(Req0),
    {Code, Resp} =
        try json:decode(Body) of
            L when is_map(L) ->
                case p05_estacion_meteorologica_server:ingestar(L) of
                    ok         -> {201, #{ok => true}};
                    {error, E} -> {422, #{error => E}}
                end;
            _ ->
                {400, #{error => json_invalido}}
        catch
            _:_ -> {400, #{error => json_invalido}}
        end,
    Req2 = cowboy_req:reply(Code, #{<<"content-type">> => <<"application/json">>},
                            iolist_to_binary(json:encode(Resp)), Req1),
    {ok, Req2, State}.
