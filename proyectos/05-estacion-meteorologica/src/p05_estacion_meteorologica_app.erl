-module(p05_estacion_meteorologica_app).
-behaviour(application).
-export([start/2, stop/1]).

%% Arranca el servidor HTTP (cowboy) y luego el arbol de supervision.
start(_StartType, _StartArgs) ->
    Dispatch = cowboy_router:compile([{'_', [
        {"/api/lecturas",  p05_lecturas_h, []},
        {"/api/promedios", p05_promedios_h, []},
        {"/metrics",       p05_metrics_h, []},
        {"/", cowboy_static, {priv_file, p05_estacion_meteorologica, "index.html"}}
    ]}]),
    {ok, _} = cowboy:start_clear(http, [{port, 8080}],
                                 #{env => #{dispatch => Dispatch}}),
    p05_estacion_meteorologica_sup:start_link().

stop(_State) ->
    cowboy:stop_listener(http),
    ok.
