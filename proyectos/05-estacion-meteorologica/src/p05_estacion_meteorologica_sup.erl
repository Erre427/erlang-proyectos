-module(p05_estacion_meteorologica_sup).
-behaviour(supervisor).
-export([start_link/0]).
-export([init/1]).

start_link() ->
    supervisor:start_link({local, ?MODULE}, ?MODULE, []).

%% rest_for_one: si muere un hijo, se reinician tambien los que arrancaron
%% despues. El store (dueño de la ETS) va primero: si muere, todos se reinician.
init([]) ->
    Worker = fun(Mod) ->
        #{id => Mod,
          start => {Mod, start_link, []},
          restart => permanent,
          shutdown => 5000,
          type => worker}
    end,
    Children = [Worker(p05_estacion_meteorologica_store),
                Worker(p05_estacion_meteorologica_server),
                Worker(p05_estacion_meteorologica_agregador),
                Worker(p05_estacion_meteorologica_sensor)],
    {ok, {#{strategy => rest_for_one, intensity => 10, period => 60}, Children}}.
