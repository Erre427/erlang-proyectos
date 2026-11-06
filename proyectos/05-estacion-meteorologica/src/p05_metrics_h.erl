-module(p05_metrics_h).
-export([init/2]).

%% GET /metrics en formato Prometheus
init(Req0, State) ->
    Promedios = p05_estacion_meteorologica_agregador:promedios(),
    UnMin = maps:get(<<"1min">>, Promedios, #{}),
    Gauges = [io_lib:format("# TYPE ~s gauge~n~s ~w~n", [Nombre, Nombre, Valor])
              || {Campo, Nombre} <- [{<<"temperatura">>, "estacion_temperatura"},
                                     {<<"humedad">>,     "estacion_humedad"},
                                     {<<"presion">>,     "estacion_presion"},
                                     {<<"viento">>,      "estacion_viento"}],
                 Valor <- [maps:get(Campo, UnMin, null)],
                 is_number(Valor)],
    Counter = io_lib:format("# TYPE estacion_lecturas_total counter~n"
                            "estacion_lecturas_total ~w~n",
                            [p05_estacion_meteorologica_server:total()]),
    Req1 = cowboy_req:reply(200, #{<<"content-type">> => <<"text/plain">>},
                            [Gauges, Counter], Req0),
    {ok, Req1, State}.
