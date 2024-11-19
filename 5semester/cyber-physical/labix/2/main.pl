% Copyright (c) 2024 ekkimukk. All Rights Reserved.

% https://grafika.me/node/237


% point(X, Y).
% line(Point1, Point2).
% vector(Point1, Point2).
% vectorProduct(V).
:-use_module(library(clpr)).
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


% pointInTriangle() :- (
%     true
% ).

% combine(A, B, C) :- (
%     append(A1, Common, A),
%     append(Common, B1, B),
%     append([A1, Common, B1], C)
% ).

findIntersection(Q1, K1, B1, Q2, K2, B2, X, Y) :- (
    { K1*X + Q1*Y + B1 =:= 0 },
    { K2*X + Q2*Y + B2 =:= 0 }
).

eq((X1, Y1), (X2, Y2), Q, K, B) :- (
  Y1 \= Y2 -> (
    X1 \= X2 -> (
      Q is -1, 
      K is (Y2 - Y1) / (X2 - X1),
      B is Y1 - K * X1
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

% qy + k*x + b = 0
% eq((X1, Y1), (X2, Y2), Q, K, B) :- (
%     Y1 \= Y2 -> (
%         X1 \= X2 -> (
%             Q is 1,
%             K is (Y2 - Y1) / (X2 - X1),
%             B is Y1 - K * X1
%         )
%         ;(
%             Q is 0,
%             K is 1,
%             B is X1
%         )
%     )
%     ;(
%         Q is 1,
%         K is 0,
%         X1 \= X2 -> (
%             Y1 > Y2 -> (
%                 B is Y2
%             )
%             ;(
%                 B is Y1
%             )
%         )
%         ;(
%             B is Y2
%         )
%     )
% ).



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
        write(""),
        printList(Rest)
    )
).

% Точка находится внутри прямоугольника
pointInRectangle((X, Y), (X1, Y1), (X2, Y2), (X3, Y3), (X4, Y4)) :- (
    MinX1 is min(X1, X2),
    MinX2 is min(MinX1, X3),
    MinX is min(MinX2, X4),
    % format("MinX is ~f", [MinX]), nl,
    MaxX1 is max(X1, X2),
    MaxX2 is max(MaxX1, X3),
    MaxX is max(MaxX2, X4),
    % format("MaxX is ~f", [MaxX]), nl,
    MinY1 is min(Y1, Y2),
    MinY2 is min(MinY1, Y3),
    MinY is min(MinY2, Y4),
    % format("MinY is ~f", [MinY]), nl,
    MaxY1 is max(Y1, Y2),
    MaxY2 is max(MaxY1, Y3),
    MaxY is max(MaxY2, Y4),
    % format("MaxY is ~f", [MaxY]), nl,
    X_ is round(X),
    Y_ is round(Y),
    % format("X is ~f; Y is ~f", [X_, Y_]), nl,
    between(MinX, MaxX, X_),
    between(MinY, MaxY, Y_)
).

pointInTriangle((X, Y), (X1, Y1), (X2, Y2), (X3, Y3)) :- (
    MinX1 is min(X1, X2),
    MinX  is min(MinX1, X3),
    % format("MinX is ~f", [MinX]), nl,
    MaxX1 is max(X1, X2),
    MaxX  is max(MaxX1, X3),
    % format("MaxX is ~f", [MaxX]), nl,
    MinY1 is min(Y1, Y2),
    MinY  is min(MinY1, Y3),
    % format("MinY is ~f", [MinY]), nl,
    MaxY1 is max(Y1, Y2),
    MaxY  is max(MaxY1, Y3),
    % format("MaxY is ~f", [MaxY]), nl,
    X_ is round(X),
    Y_ is round(Y),
    % format("X is ~f; Y is ~f", [X_, Y_]), nl,
    between(MinX, MaxX, X_),
    between(MinY, MaxY, Y_)
).

round_to_two_digits(Value, RoundedValue) :-
    RoundedValue is round(Value * 100000) / 100000.

main(((X1, Y1), (X2, Y2), (X3, Y3), (X4, Y4)), ((X5, Y5), (X6, Y6), (X7, Y7))) :- (
    eq((X5, Y5), (X6, Y6), Q1, K1, B1),
    % write("First equation  (qy + kx + b = 0) is "), nl,
    % write(Q1),write("*y + "),write(K1),write("*x + "),write(B1),write(" = 0"), nl,
    % format("y = ~f*x + ~f", [K1, B1]), nl,
    % nl,

    eq((X6, Y6), (X7, Y7), Q2, K2, B2),
    % write("Second equation (qy + kx + b = 0) is "), nl,
    % write(Q2),write("*y = "),write(K2),write("*x + "),write(B2), nl,
    % nl,

    eq((X7, Y7), (X5, Y5), Q3, K3, B3),
    % write("Third equation  (qy + kx + b = 0) is "), nl,
    % write(Q3),write("*y = "),write(K3),write("*x + "),write(B3), nl,
    % write("-------------------------------"),
    % nl,

    eq((X1, Y1), (X2, Y2), Q4, K4, B4),
    % write("Fourth equation (qy = kx + b) is "), nl,
    % write(Q4),write("*y = "),write(K4),write("*x + "),write(B4), nl,
    % nl,

    eq((X2, Y2), (X3, Y3), Q5, K5, B5),
    % write("Fifth equation  (qy = kx + b) is "), nl,
    % write(Q5),write("*y = "),write(K5),write("*x + "),write(B5), nl,
    % nl,

    eq((X3, Y3), (X4, Y4), Q6, K6, B6),
    % write("Sixth equation  (qy = kx + b) is "), nl,
    % write(Q6),write("*y = "),write(K6),write("*x + "),write(B6), nl,
    % nl,

    eq((X4, Y4), (X1, Y1), Q7, K7, B7),
    % write("Seventh equation  (qy = kx + b) is "), nl,
    % write(Q7),write("*y = "),write(K7),write("*x + "),write(B7), nl,
    % nl,

    % SIDE 1
    (
        findIntersection(Q1, K1, B1, Q4, K4, B4, Intersection_x1_, Intersection_y1_),
        round_to_two_digits(Intersection_x1_, Intersection_x1),
        round_to_two_digits(Intersection_y1_, Intersection_y1),
        pointInRectangle((Intersection_x1, Intersection_y1), (X1, Y1), (X2, Y2), (X3, Y3), (X4, Y4)),
        pointInTriangle((Intersection_x1, Intersection_y1), (X5, Y5), (X6, Y6), (X7, Y7)),
        createList(I1,  (Intersection_x1, Intersection_y1), (null, null), (null, null),
                        (null, null),                       (null, null), (null, null),
                        (null, null),                       (null, null), (null, null),
                        (null, null),                       (null, null), (null, null)
        )
    ; 
        createList(I1,  (null, null), (null, null), (null, null),
                        (null, null), (null, null), (null, null),
                        (null, null), (null, null), (null, null),
                        (null, null), (null, null), (null, null)
        )
    ),
    (
        findIntersection(Q2, K2, B2, Q4, K4, B4, Intersection_x2_, Intersection_y2_),
        round_to_two_digits(Intersection_x2_, Intersection_x2),
        round_to_two_digits(Intersection_y2_, Intersection_y2),
        pointInRectangle((Intersection_x2, Intersection_y2), (X1, Y1), (X2, Y2), (X3, Y3), (X4, Y4)),
        pointInTriangle((Intersection_x2, Intersection_y2), (X5, Y5), (X6, Y6), (X7, Y7)),
        createList(I2,  (null, null), (Intersection_x2, Intersection_y2), (null, null),
                        (null, null), (null, null),                       (null, null),
                        (null, null), (null, null),                       (null, null),
                        (null, null), (null, null),                       (null, null)
    )
    ; 
        createList(I2,  (null, null), (null, null), (null, null),
                        (null, null), (null, null), (null, null),
                        (null, null), (null, null), (null, null),
                        (null, null), (null, null), (null, null)
        )
    ),
    (
        findIntersection(Q3, K3, B3, Q4, K4, B4, Intersection_x3_, Intersection_y3_),
        round_to_two_digits(Intersection_x3_, Intersection_x3),
        round_to_two_digits(Intersection_y3_, Intersection_y3),
        pointInRectangle((Intersection_x3, Intersection_y3), (X1, Y1), (X2, Y2), (X3, Y3), (X4, Y4)),
        pointInTriangle((Intersection_x3, Intersection_y3), (X5, Y5), (X6, Y6), (X7, Y7)),
        createList(I3,  (null, null), (null, null), (Intersection_x3, Intersection_y3),
                        (null, null), (null, null), (null, null),
                        (null, null), (null, null), (null, null),
                        (null, null), (null, null), (null, null)
        )
    ; 
        createList(I3,  (null, null), (null, null), (null, null),
                        (null, null), (null, null), (null, null),
                        (null, null), (null, null), (null, null),
                        (null, null), (null, null), (null, null)
        )
    ),
    write("1->> "), printList(I1), nl,
    write("2->> "), printList(I2), nl,
    write("3->> "), printList(I3), nl,
    nl,

    % SIDE 2
    (
        findIntersection(Q1, K1, B1, Q5, K5, B5, Intersection_x4, Intersection_y4),
        pointInRectangle((Intersection_x4, Intersection_y4), (X1, Y1), (X2, Y2), (X3, Y3), (X4, Y4)),
        pointInTriangle((Intersection_x4, Intersection_y4), (X5, Y5), (X6, Y6), (X7, Y7)),
        createList(I4,  (null, null), (null, null), (null, null),
                        (Intersection_x4, Intersection_y4), (null, null), (null, null),
                        (null, null), (null, null), (null, null),
                        (null, null), (null, null), (null, null)
    )
    ; 
        createList(I4,  (null, null), (null, null), (null, null),
                        (null, null), (null, null), (null, null),
                        (null, null), (null, null), (null, null),
                        (null, null), (null, null), (null, null)
        )
    ),
    (
        findIntersection(Q2, K2, B2, Q5, K5, B5, Intersection_x5, Intersection_y5),
        pointInRectangle((Intersection_x5, Intersection_y5), (X1, Y1), (X2, Y2), (X3, Y3), (X4, Y4)),
        pointInTriangle((Intersection_x5, Intersection_y5), (X5, Y5), (X6, Y6), (X7, Y7)),
        createList(I5,  (null, null), (null, null), (null, null),
                        (null, null), (Intersection_x5, Intersection_y5), (null, null),
                        (null, null), (null, null), (null, null),
                        (null, null), (null, null), (null, null)
        )
    ; 
        createList(I5,  (null, null), (null, null), (null, null),
                        (null, null), (null, null), (null, null),
                        (null, null), (null, null), (null, null),
                        (null, null), (null, null), (null, null)
        )
    ),
    (
        findIntersection(Q3, K3, B3, Q5, K5, B5, Intersection_x6, Intersection_y6),
        pointInRectangle((Intersection_x6, Intersection_y6), (X1, Y1), (X2, Y2), (X3, Y3), (X4, Y4)),
        pointInTriangle((Intersection_x6, Intersection_y6), (X5, Y5), (X6, Y6), (X7, Y7)),
        createList(I6,  (null, null), (null, null), (null, null),
                        (null, null), (null, null), (Intersection_x6, Intersection_y6), 
                        (null, null), (null, null), (null, null),
                        (null, null), (null, null), (null, null)
    )
    ; 
        createList(I6,  (null, null), (null, null), (null, null),
                        (null, null), (null, null), (null, null),
                        (null, null), (null, null), (null, null),
                        (null, null), (null, null), (null, null)
        )
    ),
    write("4->> "), printList(I4), nl,
    write("5->> "), printList(I5), nl,
    write("6->> "), printList(I6), nl,
    nl,

    % SIDE 3
    (
        findIntersection(Q1, K1, B1, Q6, K6, B6, Intersection_x7, Intersection_y7),
        pointInRectangle((Intersection_x7, Intersection_y7), (X1, Y1), (X2, Y2), (X3, Y3), (X4, Y4)),
        pointInTriangle((Intersection_x7, Intersection_y7), (X5, Y5), (X6, Y6), (X7, Y7)),
        createList(I7,  (null, null), (null, null), (null, null),
                        (null, null), (null, null), (null, null),
                        (Intersection_x7, Intersection_y7), (null, null), (null, null),
                        (null, null), (null, null), (null, null)
    )
    ; 
        createList(I7,  (null, null), (null, null), (null, null),
                        (null, null), (null, null), (null, null),
                        (null, null), (null, null), (null, null),
                        (null, null), (null, null), (null, null)
        )

    ),
    (
        findIntersection(Q2, K2, B2, Q6, K6, B6, Intersection_x8, Intersection_y8),
        pointInRectangle((Intersection_x8, Intersection_y8), (X1, Y1), (X2, Y2), (X3, Y3), (X4, Y4)),
        pointInTriangle((Intersection_x8, Intersection_y8), (X5, Y5), (X6, Y6), (X7, Y7)),
        createList(I8,  (null, null), (null, null), (null, null),
                        (null, null), (null, null), (null, null),
                        (null, null), (Intersection_x8, Intersection_y8), (null, null),
                        (null, null), (null, null), (null, null)
        )
    ;
        createList(I8,  (null, null), (null, null), (null, null),
                        (null, null), (null, null), (null, null),
                        (null, null), (null, null), (null, null),
                        (null, null), (null, null), (null, null)
        )
    ),
    (
        findIntersection(Q3, K3, B3, Q6, K6, B6, Intersection_x9, Intersection_y9),
        pointInRectangle((Intersection_x9, Intersection_y9), (X1, Y1), (X2, Y2), (X3, Y3), (X4, Y4)),
        pointInTriangle((Intersection_x9, Intersection_y9), (X5, Y5), (X6, Y6), (X7, Y7)),
        createList(I9,  (null, null), (null, null), (null, null),
                        (null, null), (null, null), (null, null),
                        (null, null), (null, null), (Intersection_x9, Intersection_y9),
                        (null, null), (null, null), (null, null)
        )
    ;
        createList(I9,  (null, null), (null, null), (null, null),
                        (null, null), (null, null), (null, null),
                        (null, null), (null, null), (null, null),
                        (null, null), (null, null), (null, null)
        )
    ),
    write("7->> "), printList(I4), nl,
    write("8->> "), printList(I5), nl,
    write("9->> "), printList(I6), nl,
    nl,

    % SIDE 4
    (
        findIntersection(Q1, K1, B1, Q7, K7, B7, Intersection_x10, Intersection_y10),
        pointInRectangle((Intersection_x10, Intersection_y10), (X1, Y1), (X2, Y2), (X3, Y3), (X4, Y4)),
        pointInTriangle((Intersection_x10, Intersection_y10), (X5, Y5), (X6, Y6), (X7, Y7)),
        createList(I10, (null, null), (null, null), (null, null),
                        (null, null), (null, null), (null, null),
                        (null, null), (null, null), (null, null),
                        (Intersection_x10, Intersection_y10), (null, null), (null, null)
        )
    ;
        createList(I10, (null, null), (null, null), (null, null),
                        (null, null), (null, null), (null, null),
                        (null, null), (null, null), (null, null),
                        (null, null), (null, null), (null, null)
        )
    ),
    (
        findIntersection(Q2, K2, B2, Q7, K7, B7, Intersection_x11, Intersection_y11),
        pointInRectangle((Intersection_x11, Intersection_y11), (X1, Y1), (X2, Y2), (X3, Y3), (X4, Y4)),
        pointInTriangle((Intersection_x11, Intersection_y11), (X5, Y5), (X6, Y6), (X7, Y7)),
        createList(I11, (null, null), (null, null), (null, null),
                        (null, null), (null, null), (null, null),
                        (null, null), (null, null), (null, null),
                        (null, null), (Intersection_x11, Intersection_y11), (null, null)
        )
    ; 
        createList(I11, (null, null), (null, null), (null, null),
                        (null, null), (null, null), (null, null),
                        (null, null), (null, null), (null, null),
                        (null, null), (null, null), (null, null)
        )
    ),
    (
        findIntersection(Q3, K3, B3, Q7, K7, B7, Intersection_x12, Intersection_y12),
        pointInRectangle((Intersection_x12, Intersection_y12), (X1, Y1), (X2, Y2), (X3, Y3), (X4, Y4)),
        pointInTriangle((Intersection_x12, Intersection_y12), (X5, Y5), (X6, Y6), (X7, Y7)),
        createList(I12, (null, null), (null, null), (null, null),
                        (null, null), (null, null), (null, null),
                        (null, null), (null, null), (null, null),
                        (null, null), (null, null), (Intersection_x12, Intersection_y12)
        )
    ; 
        createList(I12, (null, null), (null, null), (null, null),
                        (null, null), (null, null), (null, null),
                        (null, null), (null, null), (null, null),
                        (null, null), (null, null), (null, null)
        )
    ),
    write("10->> "), printList(I10), nl,
    write("11->> "), printList(I11), nl,
    write("12->> "), printList(I12), nl,

    nl,
    printList(I1),  
    printList(I2), 
    printList(I3), 
    printList(I4), 
    printList(I5), 
    printList(I6), 
    printList(I7), 
    printList(I8), 
    printList(I9), 
    printList(I10),
    printList(I11),
    printList(I12),

    % combine(I1, I2, R1),
    % combine(I3, R2, R3),
    % combine(I4, R3, R4),
    % combine(I5, R4, R5),
    % combine(I6, R5, R6),
    % combine(I7, R6, R7),
    % combine(I8, R7, R8),
    % combine(I9, R9, R10),
    % combine(I10, R10, R11),
    % combine(I11, R11, R12),
    % combine(I12, R12, R),


  % (
  % s(Q1, K1, B1, Q4, K4, B4, Intersection_x1, Intersection_y1),
  %   % format("(~f, ~f) is the intersection point", [Intersection_x1, Intersection_y1]),
  %   % write("1#1> ("),write(Intersection_x1),write(", "),write(Intersection_y1),write(") is the intersection point"),nl,
  %   nl;
  %   true
  % ),
  % (
  %   s(Q2, K2, Q4, B2, K4, B4, Intersection_x2, Intersection_y2),
  %   % format("(~f, ~f) is the intersection point", [Intersection_x2, Intersection_y2]),
  %   % write("1#2> ("),write(Intersection_x2),write(", "),write(Intersection_y2),write(") is the intersection point"),nl,
  %   nl;
  %   true
  % ),
  % (
  %   s(Q3, K3, B3, Q4, K4, B4, Intersection_x3, Intersection_y3),
  %   % format("(~f, ~f) is the intersection point", [Intersection_x3, Intersection_y3]),
  %   % write("1#3> ("),write(Intersection_x3),write(", "),write(Intersection_y3),write(") is the intersection point"),nl,
  %   nl;
  %   true
  % ),
  %
  % (
  %   s(Q1, K1, B1, Q5, K5, B5, Intersection_x1, Intersection_y1),
  %   % format("(~f, ~f) is the intersection point", [Intersection_x1, Intersection_y1]),
  %   % write("2#1> ("),write(Intersection_x1),write(", "),write(Intersection_y1),write(") is the intersection point"),nl,
  %   nl;
  %   true
  % ),
  % (
  %   s(Q2, K2, B2, Q5, K5, B5, Intersection_x2, Intersection_y2),
  %   % format("(~f, ~f) is the intersection point", [Intersection_x2, Intersection_y2]),
  %   % write("2#2> ("),write(Intersection_x2),write(", "),write(Intersection_y2),write(") is the intersection point"),nl,
  %   nl;
  %   true
  % ),
  % (
  %   s(Q3, K3, B3, Q5, K5, B5, Intersection_x3, Intersection_y3),
  %   % format("(~f, ~f) is the intersection point", [Intersection_x3, Intersection_y3]),
  %   % write("2#3> ("),write(Intersection_x3),write(", "),write(Intersection_y3),write(") is the intersection point"),nl,
  %   nl;
  %   true
  % ),
  %

    nl
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

