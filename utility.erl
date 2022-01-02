-module(utility).
-export([factorial/1]).
-export([reverse_list/1]).
-export([convert_list_to_binary/1]).
-export([starts_with/2]).
-export([standardize_measures_to_cm/1, total_cm/1]).

factorial(0) -> 1;
factorial(N) -> N * factorial(N - 1).

reverse_list(List) -> 
    reverse_list(List, []).

reverse_list([], ReversedAcc) -> ReversedAcc;
reverse_list([H|T], ReversedAcc) ->
    reverse_list(T, [H|ReversedAcc]).

convert_list_to_binary(List) ->
    convert_list_to_binary(List, <<>>).

convert_list_to_binary([], Acc) -> Acc;
convert_list_to_binary([H|T], Acc) ->
    convert_list_to_binary(T, <<Acc/binary, H>>).

% if is not recommended
starts_with(Portion, String) ->
    Left = string:left(String, length(Portion)),
    if
        Left =:= Portion -> true;
        true -> false
    end.

standardize_measures_to_cm(Measures) ->
    F = fun
        ({cm, _} = Measure) -> Measure;
        ({m, Value}) -> {cm, round(Value * 100)}
    end,
    lists:map(F, Measures).

total_cm(Measures) ->
    StandardizeMeasures = standardize_measures_to_cm(Measures),
    F = fun({cm, Value}, Acc) ->
        Acc + Value
    end,
    lists:foldl(F, 0, StandardizeMeasures).
