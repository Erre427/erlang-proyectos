-module(p05_estacion_meteorologica_tests).
-include_lib("eunit/include/eunit.hrl").

arbol_de_supervision_test_() ->
    {setup,
     fun() -> {ok, Pid} = p05_estacion_meteorologica_sup:start_link(), Pid end,
     fun(Pid) ->
         unlink(Pid),
         exit(Pid, shutdown)
     end,
     fun(_) ->
         Valida = #{<<"temperatura">> => 20, <<"humedad">> => 50,
                    <<"presion">> => 1010, <<"viento">> => 5},
         [?_assertEqual(pong, p05_estacion_meteorologica_server:ping()),
          ?_assert(is_map(p05_estacion_meteorologica_server:state())),
          ?_assertEqual(ok, p05_estacion_meteorologica_server:ingestar(Valida)),
          ?_assertEqual({error, lectura_invalida},
                        p05_estacion_meteorologica_server:ingestar(#{<<"temperatura">> => 1}))]
     end}.

media_test_() ->
    [?_assertEqual(null, p05_estacion_meteorologica_agregador:media([])),
     ?_assertEqual(20.0, p05_estacion_meteorologica_agregador:media([10, 30]))].
