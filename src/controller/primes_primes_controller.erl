-module(primes_primes_controller, [Req]).
-compile(export_all).

index('GET', []) ->
    {json, [ {results, [ to_proplist(P) || P <- boss_db:find(mprime, []) ] }] };

index('GET', [Input]) ->
    N = element(1, string:to_integer(Input)),
    Result = primes:get(N),
    {json,  to_proplist(Result) }.

to_proplist(MPrime) ->
    [ {n, MPrime:n()}, {prime, MPrime:prime() } ].

