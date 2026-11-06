-module(p05_estacion_meteorologica_store).
-behaviour(gen_server).
-export([start_link/0, insert/1, window/1]).
-export([init/1, handle_call/3, handle_cast/2]).

%% Este proceso es el DUEÑO de la tabla ETS. Si muere, la tabla desaparece
%% y el supervisor lo reinicia (y la recrea).
start_link() ->
    gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).

init([]) ->
    ets:new(lecturas, [named_table, public, ordered_set]),
    {ok, #{}}.

insert(Lectura) ->
    Ts = erlang:system_time(second),
    ets:insert(lecturas, {{Ts, erlang:unique_integer([monotonic])}, Lectura}).

%% Lecturas de los ultimos Secs segundos.
window(Secs) ->
    Min = erlang:system_time(second) - Secs,
    ets:select(lecturas, [{{{'$1', '_'}, '$2'}, [{'>=', '$1', Min}], ['$2']}]).

handle_call(_Req, _From, State) -> {reply, ok, State}.
handle_cast(_Msg, State) -> {noreply, State}.
