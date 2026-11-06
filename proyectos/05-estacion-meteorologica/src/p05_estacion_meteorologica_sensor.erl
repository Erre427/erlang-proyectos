-module(p05_estacion_meteorologica_sensor).
-behaviour(gen_server).
-export([start_link/0]).
-export([init/1, handle_call/3, handle_cast/2, handle_info/2]).

%% Sensor simulado: genera una lectura cada 2 segundos para la demo.
start_link() ->
    gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).

init([]) ->
    self() ! leer,
    {ok, #{}}.

handle_info(leer, State) ->
    erlang:send_after(2000, self(), leer),
    p05_estacion_meteorologica_server:ingestar(#{
        <<"temperatura">> => 15 + rand:uniform() * 15,
        <<"humedad">>     => 40 + rand:uniform() * 40,
        <<"presion">>     => 1000 + rand:uniform() * 25,
        <<"viento">>      => rand:uniform() * 30}),
    {noreply, State};
handle_info(_Info, State) ->
    {noreply, State}.

handle_call(_Req, _From, State) -> {reply, ok, State}.
handle_cast(_Msg, State) -> {noreply, State}.
