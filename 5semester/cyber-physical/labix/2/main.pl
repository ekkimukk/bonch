% Copyright (c) 2024 ekkimukk. All Rights Reserved.

% https://grafika.me/node/237

:- use_module(library(clpr)).

% point(X, Y).
% line(Point1, Point2).
% vector(Point1, Point2).
% vectorProduct(V).
%
% input() :-
%   write("Enter the left bottom vertex of the rectangle: "), nl,
%   read(X),
%   read(Y),
%   point(X, Y),
%   write("Enter the left top vertex of the rectangle: "), nl,
%   read(X),
%   read(Y),
%   point(X, Y).
%
% segmentsIntersect(V1, V2, V3, V4) :-
%   V1 * V2 < 0,
%   V3 * V4 < 0,
%   % тут будет вызов функции, считающей точки пересечения
%   % countIntersectionPoints,
%   write("The segments intersect"), nl.
%
% countIntersectionPoints(P1_x, P1_y, P2_x, P2_y) :-
%   vectorProduct(P1_x * P2_y - P1_y * P2_x).
%


print([]).
print([H|T]) :-
  (
  H \== [] ->
    writeln(H),
    print(T)
  ;
    print(T)
  ).


s(Q1, K1, B1, Q2, K2, B2, X, Y) :-
  { K1*X - Q1*Y + B1 =:= 0 },
  { K2*X - Q2*Y + B2 =:= 0 }.

% q*y = k*x + b
% eq((X1, Y1), (X2, Y2), Q, K, B) :-
%     (
%         X1 \= X2 -> (
%             Y1 \= Y2 -> (
%                 Q is 1,
%                 K is (Y2 - Y1) / (X2 - X1),
%                 B is Y1 - K * X1
%             )
%             ;(
%                 write("$"),nl,
%                 Q is 0,
%                 K is 1, 
%                 B is X1
%             )
%         )
%         ;(
%             Q is 1,
%             K is 0,
%             Y1 \= Y2 -> (
%                 Y1 > Y2 -> (
%                     B is Y2
%                 )
%                 ;(
%                     B is Y1
%                 )
%             )
%             ;(
%                 B is -Y1
%             )
%         )
%     ).

eq((X1, Y1), (X2, Y2), Q, K, B) :-
    (
        Y1 \= Y2 -> (
            X1 \= X2 -> (
                Q is 1,
                K is (Y2 - Y1) / (X2 - X1),
                B is Y1 - K * X1
            )
            ;(
                Q is 1,
                K is 0,
                B is X1
            )
        )
        ;(
            Q is 0,
            K is 1,
            X1 \= X2 -> (
                Y1 > Y2 -> (
                    B is -Y2
                )
                ;(
                    B is Y1
                )
            )
            ;(
                B is -Y1
            )
        )
    ).


main(((X1, Y1), (X2, Y2), (X3, Y3)), ((X5, Y5), (X6, Y6), (X7, Y7))) :-
  eq((X5, Y5), (X6, Y6), Q1, K1, B1),
  write("First equation  (qy = kx + b) is "), nl,
  write(Q1),write("*y = "),write(K1),write("*x + "),write(B1), nl,
  % format("y = ~f*x + ~f", [K1, B1]), nl,
  nl,

  eq((X6, Y6), (X7, Y7), Q2, K2, B2),
  write("Second equation (qy = kx + b) is "), nl,
  write(Q2),write("*y = "),write(K2),write("*x + "),write(B2), nl,
  % format("y = ~f*x + ~f", [K2, B2]), nl,
  nl,

  eq((X7, Y7), (X5, Y5), Q3, K3, B3),
  write("Third equation  (qy = kx + b) is "), nl,
  write(Q2),write("*y = "),write(K3),write("*x + "),write(B3), nl,
  % format("y = ~f*x + ~f", [K3, B3]), nl,
  write("-------------------------------"),
  nl,

  eq((X1, Y1), (X2, Y2), Q4, K4, B4),
  write("Fourth equation (qy = kx + b) is "), nl,
  write(Q4),write("*y = "),write(K4),write("*x + "),write(B4), nl,
  % format("y = ~f*x + ~f", [K4, B4]), nl,
  nl,

  eq((X2, Y2), (X3, Y3), Q5, K5, B5),
  write("Fifth equation  (qy = kx + b) is "), nl,
  write(Q5),write("*y = "),write(K5),write("*x + "),write(B5), nl,
  % format("y = ~f*x + ~f", [K5, B5]), nl,
  nl,

  (
    s(Q1, K1, B1, Q4, K4, B4, Intersection_x1, Intersection_y1),
    % format("(~f, ~f) is the intersection point", [Intersection_x1, Intersection_y1]),
    write("1#1> ("),write(Intersection_x1),write(", "),write(Intersection_y1),write(") is the intersection point"),nl,
    nl;
    true
  ),
  (
    s(Q2, K2, Q4, B2, K4, B4, Intersection_x2, Intersection_y2),
    % format("(~f, ~f) is the intersection point", [Intersection_x2, Intersection_y2]),
    write("1#2> ("),write(Intersection_x2),write(", "),write(Intersection_y2),write(") is the intersection point"),nl,
    nl;
    true
  ),
  (
    s(Q3, K3, B3, Q4, K4, B4, Intersection_x3, Intersection_y3),
    % format("(~f, ~f) is the intersection point", [Intersection_x3, Intersection_y3]),
    write("1#3> ("),write(Intersection_x3),write(", "),write(Intersection_y3),write(") is the intersection point"),nl,
    nl;
    true
  ),

  (
    s(Q1, K1, B1, Q5, K5, B5, Intersection_x1, Intersection_y1),
    % format("(~f, ~f) is the intersection point", [Intersection_x1, Intersection_y1]),
    write("2#1> ("),write(Intersection_x1),write(", "),write(Intersection_y1),write(") is the intersection point"),nl,
    nl;
    true
  ),
  (
    s(Q2, K2, B2, Q5, K5, B5, Intersection_x2, Intersection_y2),
    % format("(~f, ~f) is the intersection point", [Intersection_x2, Intersection_y2]),
    write("2#2> ("),write(Intersection_x2),write(", "),write(Intersection_y2),write(") is the intersection point"),nl,
    nl;
    true
  ),
  (
    s(Q3, K3, B3, Q5, K5, B5, Intersection_x3, Intersection_y3),
    % format("(~f, ~f) is the intersection point", [Intersection_x3, Intersection_y3]),
    write("2#3> ("),write(Intersection_x3),write(", "),write(Intersection_y3),write(") is the intersection point"),nl,
    nl;
    true
  ),


  nl.

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

% print_points([]).
% print_points([Point | Rest]) :-
  % writeln(Point),
  % print_points(Rest).
