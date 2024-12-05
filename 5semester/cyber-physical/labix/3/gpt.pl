bitonic_sort([X], [X]).
bitonic_sort(List, Sorted) :-
    length(List, N),
    N > 1,
    N2 is N // 2,
    % write("N2 > "), write(N2), nl,
    partition(List, N2, L1, L2),
    % write("L1 > "), write(L1), nl,
    % write("L2 > "), write(L2), nl,
    bitonic_sort(L1, Sorted1),
    bitonic_sort(L2, Sorted2),
    % write("Sorted1 > "), write(Sorted1), nl,
    % write("Sorted2 > "),write(Sorted2), nl,
    unite_lists(Sorted1, Sorted2, Sorted).

partition([], _, [], []).
partition([X|Xs], 0, [], [X|Xs]).
partition([X|Xs], N, [X|L1], L2) :-
    N > 0,
    N1 is N - 1,
    partition(Xs, N1, L1, L2).

unite_lists([], L, L).
unite_lists(L, [], L).
unite_lists([X|Xs], [Y|Ys], [X|Zs]) :-
    % last([Y|Ys], LastYs),
    X =< Y,
    unite_lists(Xs, [Y|Ys], Zs).
unite_lists([X|Xs], [Y|Ys], [Y|Zs]) :-
    % last([Y|Ys], LastYs),
    X > Y,
    unite_lists([X|Xs], Ys, Zs).

is_power_of_two(N) :-
    N = 1;
    N mod 2 =:= 0,
    N1 is N // 2,
    is_power_of_two(N1).

main :-
    read_from_file("File2.txt", List),
    length(List, N),
    is_power_of_two(N),
    write(List), nl,
    bitonic_sort(List, Sorted),
    write(Sorted).

read_from_file(File, Ints) :-
    setup_call_cleanup(
        open(File, read, Stream),
        (
            read_line_to_codes(Stream, Codes),
            string_codes(String, Codes),
            split_string(String, " ", "", Parts),
            maplist(atom_number, Parts, Ints)
        ),
        close(Stream)
).

