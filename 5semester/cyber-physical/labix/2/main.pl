% https://grafika.me/node/237

:- use_module(library(clpr)).

% point(X, Y).
% line(Point1, Point2).
% vector(Point1, Point2).
% vectorProduct(V).

input() :-
  write("Enter the left bottom vertex of the rectangle: "), nl,
  read(X),
  read(Y),
  point(X, Y),
  write("Enter the left top vertex of the rectangle: "), nl,
  read(X),
  read(Y),
  point(X, Y).

segmentsIntersect(V1, V2, V3, V4) :-
  V1 * V2 < 0,
  V3 * V4 < 0,
  % тут будет вызов функции, считающей точки пересечения
  % countIntersectionPoints,
  write("The segments intersect"), nl.

countIntersectionPoints(P1_x, P1_y, P2_x, P2_y) :-
  vectorProduct(P1_x * P2_y - P1_y * P2_x).



print([]).
print([H|T]) :-
  (
  H \== [] ->
    writeln(H),
    print(T)
  ;
    print(T)
  ).


s(K1, B1, K2, B2, X, Y) :-
  { K1*X - Y + B1 =:= 0 },
  { K2*X - Y + B2 =:= 0 }.

eq((X1, Y1), (X2, Y2), K, B) :-
  (
  X2 \= X1 ->
    K is (Y2 - Y1) / (X2 - X1),
    B is Y1 - K * X1
  ;
    K is 0,
    B is Y1
  ).

% (x1, y1, x2, y2), (x3, y3, x4, y4, x5, y5)
main(((X1, Y1), (X2, Y2)), ((X3, Y3), (X4, Y4), (X5, Y5))) :-
  eq((X3, Y3), (X4, Y4), K1, B1),
  write("First equation (y = kx + b) is "), nl,
  format("y = ~f*x + ~f", [K1, B1]), nl,
  nl,

  eq((X4, Y4), (X5, Y5), K2, B2),
  write("Second equation (y = kx + b) is "), nl,
  format("y = ~f*x + ~f", [K2, B2]), nl,
  nl,

  eq((X5, Y5), (X3, Y3), K3, B3),
  write("Third equation (y = kx + b) is "), nl,
  format("y = ~f*x + ~f", [K3, B3]), nl,
  nl,

  eq((X1, Y1), (X2, Y2), K4, B4),
  write("Fourth equation (y = kx + b) is "), nl,
  format("y = ~f*x + ~f", [K4, B4]), nl,
  nl,

  findall(
    Point,
    (
      (s(K4, B4, K1, B1, X, Y); true),
      (s(K4, B4, K2, B2, X, Y); true),
      (s(K4, B4, K3, B3, X, Y); true),
      Point = (X, Y)
    ),
    Points
  ),
  maplist(print, Points),

  % s(K4, B4, K1, B1, Intersection_x1, Intersection_y1),
  % format("(~f, ~f) is the intersection point", [Intersection_x1, Intersection_y1]),
  % nl,

  % s(K4, B4, K2, B2, Intersection_x2, Intersection_y2),
  % format("(~f, ~f) is the intersection point", [Intersection_x2, Intersection_y2]),
  % nl,

  % s(K4, B4, K3, B3, Intersection_x3, Intersection_y3),
  % format("(~f, ~f) is the intersection point", [Intersection_x3, Intersection_y3]),
  % nl,

  nl.

% use_module(library(clpq)).
% ?-{X - 2*Y + 3 = 0, 3*X - 4*Y = 0}.
