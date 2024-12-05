% Copyright (c) 2023 ekkimukk. All Rights Reserved.

main() :- (
    % sort([2, 4, 3, 1], 1, Result),
    % write(Result)
    sort([4,2,1,3,5,7,6,8], Sorted),
    write(Sorted)
).
sort([],[]).   % empty list is already sorted
sort([X],[X]). % single element list is already sorted
sort() :-
    

qsort([], []).
qsort([H|T], Sorted) :-
    partition(H, T, Less, Greater),
    write(Less), nl,
    write(Greater), nl,
    qsort(Less, LessSorted),
    qsort(Greater, GreaterSorted),
    append(LessSorted, [H|GreaterSorted], Sorted).

partition(_, [], [], []).
partition(P, [H|T], [H|Less], Greater) :-
    P >= H,
    partition(P, T, Less, Greater).
partition(P, [H|T], Less, [H|Greater]) :-
    P =< H,
    partition(P, T, Less, Greater).

