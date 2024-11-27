module Main where

import Data.List

main :: IO ()
main = do
    input <- readFile "test1"
    let tmp = map parse . lines $ input
    -- print tmp

    let
        -- rect:
        point1 = (2, 3)
        point2 = (5, 6)
        point3 = (7, 4)
        point4 = (4, 1)
        -- trian:
        point5 = (2, 3)
        point6 = (2, 6)
        point7 = (7, 4)
        --
        lines  = [coeffs point1 point2, coeffs point2 point3, coeffs point3 point4, coeffs point4 point1,
                 coeffs point5 point6, coeffs point6 point7, coeffs point7 point5]
        -- intersections = [inters (lines!!0) (lines!!4), inters (lines!!0) (lines!!5), inters (lines!!0) (lines!!6),
        --                  inters (lines!!1) (lines!!4), inters (lines!!1) (lines!!5), inters (lines!!1) (lines!!6),
        --                  inters (lines!!2) (lines!!4), inters (lines!!2) (lines!!5), inters (lines!!2) (lines!!6),
        --                  inters (lines!!3) (lines!!4), inters (lines!!3) (lines!!5), inters (lines!!3) (lines!!6)]
        intersections = [inters (lines!!i) (lines!!j) | i <- [0..3], j <- [4..6]]
        intersInRect  = filter (insideRect point1 point2 point3 point4) intersections
        intersInTrian = filter (insideTrian point5 point6 point7) intersInRect
    print intersInTrian
    print . nub $ intersInTrian

insideRect (x1, y1) (x2, y2) (x3, y3) (x4, y4) (x, y) =
    minX <= x && x <= maxX &&
    minY <= y && y <= maxY
        where minX = minimum [x1, x2, x3, x4]
              maxX = maximum [x1, x2, x3, x4]
              minY = minimum [y1, y2, y3, y4]
              maxY = maximum [y1, y2, y3, y4]

insideTrian (x5, y5) (x6, y6) (x7, y7) (x, y) =
    minX <= x && x <= maxX &&
    minY <= y && y <= maxY
        where minX = minimum [x5, x6, x7]
              maxX = maximum [x5, x6, x7]
              minY = minimum [y5, y6, y7]
              maxY = maximum [y5, y6, y7]

parse line = (f, s)
    where p = words $ line
          f = head  $ p
          s = last  $ p

-- coeffs :: (Num a) => (a, a) -> (a, a) -> (a, a, a)
coeffs (x1, y1) (x2, y2)
    | y1==y2           = (                  0, -1,                    minimum [y1, y2])
    | y1/=y2 && x1/=x2 = ((y2 - y1)/(x2 - x1), -1,       y1 - ((y2 - y1)/(x2 - x1))*x1)
    | y1/=y2 && x1==x2 = (                 -1,  0,                    minimum [x1, x2])

-- inters :: forall a. Num a => (a, a, a) -> (a, a, a) -> (a, a)
inters (a1, b1, c1) (a2, b2, c2) = (x, y)
    where x = (b2*c1 - b1*c2)/(a2*b1 - a1*b2)
          y = (a2*c1 - a1*c2)/(a1*b2 - a2*b1)
