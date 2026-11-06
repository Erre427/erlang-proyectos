-module(p05_estacion_meteorologica_agregador).
-behaviour(gen_server).
-export([start_link/0, promedios/0, media/1]).
-export([init/1, handle_call/3, handle_cast/2, handle_info/2]).

-define(CAMPOS, [<<"temperatura">>, <<"humedad">>, <<"presion">>, <<"viento">>]).
-define(INTERVALO, 5000).

start_link() ->
    gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).

promedios() ->
    gen_server:call(?MODULE, promedios).

init([]) ->
    self() ! tick,
    {ok, #{}}.

%% Cada 5 segundos recalcula los promedios de 1 minuto y 1 hora.
handle_info(tick, _State) ->
    erlang:send_after(?INTERVALO, self(), tick),
    {noreply, #{<<"1min">> => promedio(60), <<"1h">> => promedio(3600)}};
handle_info(_Info, State) ->
    {noreply, State}.

handle_call(promedios, _From, State) -> {reply, State, State}.
handle_cast(_Msg, State) -> {noreply, State}.

promedio(Secs) ->
    Lecturas = p05_estacion_meteorologica_store:window(Secs),
    maps:from_list([{C, media([maps:get(C, L) || L <- Lecturas])} || C <- ?CAMPOS]).

media([]) -> null;
media(Xs) -> lists:sum(Xs) / length(Xs).
