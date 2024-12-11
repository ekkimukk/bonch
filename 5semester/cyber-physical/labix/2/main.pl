% Copyright (c) 2023 ekkimukk. All Rights Reserved.
% Float хранит 50 чисел после запятой

% https://grafika.me/node/237

/*    findall(
(X_, Y_),
(
(
member((X, Y), Intersections),
round(X, X_, 6),
round(Y, Y_, 6)
% write(X_),write(" :: "),write(Y_),nl 
% format("(~f; ~f)", [X_, Y_]), nl
)
),
Final
),
print_list(Final),

writeln("-------------------"),
setof((X, Y), (member((X, Y), Final)), F),
print_list(F),*/
% :-use_module(library(clpr)).
/* findall( */
/*   Point, */
/*   ( */
/*     (s(K4, B4, K1, B1, X, Y); true), */
/*     (s(K4, B4, K2, B2, X, Y); true), */
/*     (s(K4, B4, K3, B3, X, Y); true), */
/*     Point = (X, Y) */
/*   ), */
/*   Points */
/* ), */
/* % print_points(Points). */

eq((X1, Y1), (X2, Y2), Q, K, B) :- (
  Y1 \= Y2 -> (
    X1 \= X2 -> (
      Q is -1,
      K_ is (Y2 - Y1) / (X2 - X1),
      roundToFiveDigits(K_, K),
      B_ is Y1 - K * X1,
      roundToFiveDigits(B_, B)
    ) ; (
      Q is 0,
      K is -1,
      B is X1
    )
  ) ; (
    Q is -1,
    K is 0,
    B is Y1
  )
).

createList(ListName, (X1,  Y1),  (X2,  Y2),  (X3,  Y3),
                     (X4,  Y4),  (X5,  Y5),  (X6,  Y6),
                     (X7,  Y7),  (X8,  Y8),  (X9,  Y9),
                     (X10, Y10), (X11, Y11), (X12, Y12) ) :- (
    ListName = [
        (X1, Y1),
        (X2, Y2),
        (X3, Y3),

        (X4, Y4),
        (X5, Y5),
        (X6, Y6),

        (X7, Y7),
        (X8, Y8),
        (X9, Y9),

        (X10, Y10),
        (X11, Y11),
        (X12, Y12)
    ]
).

printList([]).
printList([(X, Y)|Rest]) :- (
    (
        number(X), number(Y),
        write("("),write(X),write("; "),write(Y),write(")"),nl,
        printList(Rest)
    ); (
        printList(Rest)
    )
).

pointInRectangle((X, Y), (X1, Y1), (X2, Y2), (X3, Y3), (X4, Y4)) :- (
    MinX1 is min(X1, X2),
    MinX2 is min(MinX1, X3),
    MinX is min(MinX2, X4)*100000000,
    % format("MinX is ~f", [MinX]), nl,
    MaxX1 is max(X1, X2),
    MaxX2 is max(MaxX1, X3),
    MaxX is max(MaxX2, X4)*100000000,
    % format("MaxX is ~f", [MaxX]), nl,
    MinY1 is min(Y1, Y2),
    MinY2 is min(MinY1, Y3),
    MinY is min(MinY2, Y4)*100000000,
    % format("MinY is ~f", [MinY]), nl,
    MaxY1 is max(Y1, Y2),
    MaxY2 is max(MaxY1, Y3),
    MaxY is max(MaxY2, Y4)*100000000,
    % format("MaxY is ~f", [MaxY]), nl,
    X_ is round(X * 100000000),
    Y_ is round(Y * 100000000),
    % format("X is ~f; Y is ~f", [X_, Y_]), nl,
    between(MinX, MaxX, X_),
    between(MinY, MaxY, Y_)
).

pointInTriangle((X, Y), (X1, Y1), (X2, Y2), (X3, Y3)) :- (
    MinX1 is min(X1, X2),
    MinX  is min(MinX1, X3)*100000000,
    % format("MinX is ~f", [MinX]), nl,
    MaxX1 is max(X1, X2),
    MaxX  is max(MaxX1, X3)*100000000,
    % format("MaxX is ~f", [MaxX]), nl,
    MinY1 is min(Y1, Y2),
    MinY  is min(MinY1, Y3*100000000),
    % format("MinY is ~f", [MinY]), nl,
    MaxY1 is max(Y1, Y2),
    MaxY  is max(MaxY1, Y3)*100000000,
    % format("MaxY is ~f", [MaxY]), nl,
    X_ is round(X * 100000000),
    Y_ is round(Y * 100000000),
    % format("X is ~f; Y is ~f", [X_, Y_]), nl,
    between(MinX, MaxX, X_),
    between(MinY, MaxY, Y_)
).

roundToFiveDigits((X, Y), (Xr, Yr)) :- (
    Xr is float(round(X * 100000) / 100000),
    Yr is float(round(Y * 100000) / 100000)
).
roundToFiveDigits(Value, RoundedValue) :-
    RoundedValue is float(round(Value * 100000) / 100000).

isRectangle((X1, Y1), (X2, Y2), (X3, Y3), (X4, Y4)) :- (
    (
        V1 is X1 + X3,
        V2 is X2 + X4,
        % writeln(V1),
        % writeln(V2),
        V3 is Y1 + Y3,
        V4 is Y2 + Y4,
        % writeln(V3),
        % writeln(V4),
        V1 == V2, V3 == V4
    ); (
        fail
    )
).

main(((X1, Y1), (X2, Y2), (X3, Y3), (X4, Y4)), ((X5, Y5), (X6, Y6), (X7, Y7))) :- (
    isRectangle((X1, Y1), (X2, Y2), (X3, Y3), (X4, Y4)),

    eq((X5, Y5), (X6, Y6), Q1, K1, B1),
    % write("First equation  (qy + kx + b = 0) is "), nl,
    write(Q1),write("*y + "),write(K1),write("*x + "),write(B1),write(" = 0"), nl,
    % format("y = ~f*x + ~f", [K1, B1]), nl,
    nl,

    eq((X6, Y6), (X7, Y7), Q2, K2, B2),
    % write("Second equation (qy + kx + b = 0) is "), nl,
    write(Q2),write("*y + "),write(K2),write("*x + "),write(B2), nl,
    nl,

    eq((X7, Y7), (X5, Y5), Q3, K3, B3),
    % write("Third equation  (qy + kx + b = 0) is "), nl,
    write(Q3),write("*y + "),write(K3),write("*x + "),write(B3), nl,
    write("-------------------------------"),
    nl,

    eq((X1, Y1), (X2, Y2), Q4, K4, B4),
    % write("Fourth equation (qy = kx + b) is "), nl,
    write(Q4),write("*y + "),write(K4),write("*x + "),write(B4), nl,
    nl,

    eq((X2, Y2), (X3, Y3), Q5, K5, B5),
    % write("Fifth equation  (qy = kx + b) is "), nl,
    write(Q5),write("*y + "),write(K5),write("*x + "),write(B5), nl,
    nl,

    eq((X3, Y3), (X4, Y4), Q6, K6, B6),
    % write("Sixth equation  (qy = kx + b) is "), nl,
    write(Q6),write("*y + "),write(K6),write("*x + "),write(B6), nl,
    nl,

    eq((X4, Y4), (X1, Y1), Q7, K7, B7),
    % write("Seventh equation  (qy = kx + b) is "), nl,
    write(Q7),write("*y + "),write(K7),write("*x + "),write(B7), nl,
    nl,

    % (
    %     isInf(Q1, K1, B1,
    %           Q2, K2, B2,
    %           Q3, K3, B3,
    %           Q4, K4, B4,
    %           Q5, K5, B5,
    %           Q6, K6, B6,
    %           Q7, K7, B7
    %     ),
    %     write("The infinite number of intersections"), nl,
    %     false
    % ),

    findall(
        (X, Y),
        (
            ( % 1 done
                findIntersection(Q1, K1, B1, Q4, K4, B4, X, Y),
                pointInRectangle((X, Y), (X1, Y1), (X2, Y2), (X3, Y3), (X4, Y4)),
                pointInTriangle((X, Y), (X5, Y5), (X6, Y6), (X7, Y7))
            );
            (
                findIntersection(Q2, K2, B2, Q4, K4, B4, X, Y),
                pointInRectangle((X, Y), (X1, Y1), (X2, Y2), (X3, Y3), (X4, Y4)),
                pointInTriangle((X, Y), (X5, Y5), (X6, Y6), (X7, Y7))
            );
            (
                findIntersection(Q3, K3, B3, Q4, K4, B4, X, Y),
                pointInRectangle((X, Y), (X1, Y1), (X2, Y2), (X3, Y3), (X4, Y4)),
                pointInTriangle((X, Y), (X5, Y5), (X6, Y6), (X7, Y7))
            );

            ( % 2
                findIntersection(Q1, K1, B1, Q5, K5, B5, X, Y),
                pointInRectangle((X, Y), (X1, Y1), (X2, Y2), (X3, Y3), (X4, Y4)),
                pointInTriangle((X, Y), (X5, Y5), (X6, Y6), (X7, Y7))
            );
            (
                findIntersection(Q2, K2, B2, Q5, K5, B5, X, Y),
                pointInRectangle((X, Y), (X1, Y1), (X2, Y2), (X3, Y3), (X4, Y4)),
                pointInTriangle((X, Y), (X5, Y5), (X6, Y6), (X7, Y7))
            );
            (
                findIntersection(Q3, K3, B3, Q5, K5, B5, X, Y),
                pointInRectangle((X, Y), (X1, Y1), (X2, Y2), (X3, Y3), (X4, Y4)),
                pointInTriangle((X, Y), (X5, Y5), (X6, Y6), (X7, Y7))
            );

            ( % 3
                findIntersection(Q1, K1, B1, Q6, K6, B6, X, Y),
                pointInRectangle((X, Y), (X1, Y1), (X2, Y2), (X3, Y3), (X4, Y4)),
                pointInTriangle((X, Y), (X5, Y5), (X6, Y6), (X7, Y7))
            );
            (
                findIntersection(Q2, K2, B2, Q6, K6, B6, X, Y),
                pointInRectangle((X, Y), (X1, Y1), (X2, Y2), (X3, Y3), (X4, Y4)),
                pointInTriangle((X, Y), (X5, Y5), (X6, Y6), (X7, Y7))
            );
            (
                findIntersection(Q3, K3, B3, Q6, K6, B6, X, Y),
                pointInRectangle((X, Y), (X1, Y1), (X2, Y2), (X3, Y3), (X4, Y4)),
                pointInTriangle((X, Y), (X5, Y5), (X6, Y6), (X7, Y7))
            );

            ( % 4
                findIntersection(Q1, K1, B1, Q7, K7, B7, X, Y),
                pointInRectangle((X, Y), (X1, Y1), (X2, Y2), (X3, Y3), (X4, Y4)),
                pointInTriangle((X, Y), (X5, Y5), (X6, Y6), (X7, Y7))
            );
            (
                findIntersection(Q2, K2, B2, Q7, K7, B7, X, Y),
                pointInRectangle((X, Y), (X1, Y1), (X2, Y2), (X3, Y3), (X4, Y4)),
                pointInTriangle((X, Y), (X5, Y5), (X6, Y6), (X7, Y7))
            );
            (
                findIntersection(Q3, K3, B3, Q7, K7, B7, X, Y),
                pointInRectangle((X, Y), (X1, Y1), (X2, Y2), (X3, Y3), (X4, Y4)),
                pointInTriangle((X, Y), (X5, Y5), (X6, Y6), (X7, Y7))
            );
            number(X), number(Y),
            true
        ),
        Intersections
    ),

    % print_list(Intersections),
    % writeln("-------------------"),

    findall(
        (X_, Y_),
        (
            (
                member((X, Y), Intersections),
                round(X, X_, 6),
                round(Y, Y_, 6)
                % write(X_),write(" :: "),write(Y_),nl 
                % format("(~f; ~f)", [X_, Y_]), nl
            )
        ),
        Final
    ),
    % print_list(Final),

    writeln("----------------------"),
    setof((X, Y), (member((X, Y), Final)), F),
    print_list(F),
    writeln("----------------------"),

    nl
).

% findIntersection(Q1, K1, B1, Q2, K2, B2, X, Y) :- (
%     % (K1 \= K2, Q1 \= Q2, B1 \= B2) -> 
%         (
%             { K1*X + Q1*Y + B1 =:= 0 },
%             { K2*X + Q2*Y + B2 =:= 0 }
%         ), (
%             write("The infinite number of intersections"), nl
%             halt 
%         )
% ).

findIntersection(Q1, K1, B1, Q2, K2, B2, X, Y) :- (
    (K1 == K2, Q1 == Q2, B1 == B2) -> (
        write("The infinite number of intersections"), nl, halt
    ); (
        X is (Q2*B1 - Q1*B2) / (K2*Q1 - K1*Q2),
        Y is (K2*B1 - K1*B2) / (K1*Q2 - K2*Q1)
    )
).

round(X,Y,D) :- Z is X * 10^D, round(Z, ZA), Y is ZA / 10^D.

print_list([]).
print_list([(X, Y)|Rest]) :- (
    % format('> (~51f, ~90f)~n', [X, Y]),
    format('> (~6f, ~6f)~n', [X, Y]),
    print_list(Rest)
).

  /* findall( */
  /*   Point, */
  /*   ( */
  /*     (s(K4, B4, K1, B1, X, Y); true), */
  /*     (s(K4, B4, K2, B2, X, Y); true), */
  /*     (s(K4, B4, K3, B3, X, Y); true), */
  /*     Point = (X, Y) */
  /*   ), */
  /*   Points */
  /* ), */
  /* % print_points(Points). */

