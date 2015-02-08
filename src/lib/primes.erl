-module(primes).
-export([get/1]).

get(N) ->
    CacheId = "mprime-" ++ integer_to_list(N),
    CacheResult = boss_db:find(CacheId),
    if
        CacheResult -> CacheResult;
        true -> 
            CalcResult = trial(N),
            MPrime = mprime:new(CacheId, N, CalcResult),
            MPrime:save(),
            MPrime
    end.

trial(N) when N == 1 -> false; 
trial(N) -> trial(N, 2, trunc(math:sqrt(N))).

trial(N, I, Limit) when I > Limit -> true;
trial(N, I, Limit) when N rem I == 0 -> false;
trial(N, I, Limit) -> trial(N, I + 1, Limit).

