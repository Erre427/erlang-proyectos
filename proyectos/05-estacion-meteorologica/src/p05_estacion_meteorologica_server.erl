-module(p05_estacion_meteorologica_server).
-behaviour(gen_server).
-export([start_link/0, ping/0, state/0, ingestar/1, total/0]).
-export([init/1, handle_call/3, handle_cast/2, handle_info/2]).

-define(CAMPOS, [<<"temperatura">>, <<"humedad">>, <<"presion">>, <<"viento">>]).

start_link() ->
    gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).

ping() -> gen_server:call(?MODULE, ping).
state() -> gen_server:call(?MODULE, state).
ingestar(Lectura) -> gen_server:call(?MODULE, {ingestar, Lectura}).
total() -> gen_server:call(?MODULE, total).

init([]) ->
    logger:info("~s iniciado", [?MODULE], #{proyecto => p05_estacion_meteorologica}),
    {ok, #{iniciado_en => erlang:system_time(second), total => 0}}.

handle_call(ping, _From, State) ->
    {reply, pong, State};
handle_call(state, _From, State) ->
    {reply, State, State};
handle_call(total, _From, #{total := N} = State) ->
    {reply, N, State};
handle_call({ingestar, Lectura}, _From, #{total := N} = State) ->
    case valida(Lectura) of
        true ->
            p05_estacion_meteorologica_store:insert(Lectura),
            {reply, ok, State#{total := N + 1}};
        false ->
            {reply, {error, lectura_invalida}, State}
    end.

handle_cast(_Msg, State) ->
    {noreply, State}.

handle_info(_Info, State) ->
    {noreply, State}.

%% Una lectura es valida si trae los 4 campos y todos son numeros.
valida(L) when is_map(L) ->
    lists:all(fun(C) -> is_number(maps:get(C, L, undefined)) end, ?CAMPOS);
valida(_) ->
    false.
