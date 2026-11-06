-module(p05_promedios_h).
-export([init/2]).

%% GET /api/promedios
init(Req0, State) ->
    Promedios = p05_estacion_meteorologica_agregador:promedios(),
    Req1 = cowboy_req:reply(200,
        #{<<"content-type">> => <<"application/json">>,
          <<"access-control-allow-origin">> => <<"*">>},
        iolist_to_binary(json:encode(Promedios)), Req0),
    {ok, Req1, State}.
