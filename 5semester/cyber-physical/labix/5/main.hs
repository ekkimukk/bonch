module Main where

main :: IO ()
main = do
    -- input <- readFile "test1"
    -- print . map (read :: String -> Int ) . words $ input
    print $ coeffs (2, 1) (6, 5)
    print $ coeffs (2, 2) (6, 3)
    print $ inters (4,-4,-4) (1,-4,6)

    print $ coeffs (1, 1) (5, 5)
    print $ coeffs (3, 1) (3, 5)
    print $ inters (4,-4,0) (4,0,-12)

-- f :: (Num a) => a -> a -> a
minim a b
    | a > b = b
    | a < b = a
    | a == b = a

-- coeffs :: (Num a) => (a, a) -> (a, a) -> (a, a, a)
coeffs (x1, y1) (x2, y2)
    | y1 == y2 = (a, b, c) where a = 0
                                 b = -1
                                 c = minim y1 y2
    -- | y1 /= y2 && x1 /= x2 = (a, b, c)
        -- where a = 0
              -- b = -1
              -- c = minim y1 y2



    -- where a = min y2  y1 -- вот тут неправильно считаются коэффициенты
          -- b = min x1  x2
          -- c = - x1 * y2 + x1 * y1 + x2 * y1 - x1 * y1


inters (a1, b1, c1) (a2, b2, c2) = (x, y)
    where x = ((b2 - b1)*y + (c2 - c1)) / (a1 - a2)
          y = (-a1*c2 + c1*a2) / (a1*b2 - a1*b1)

-- a*(((d - c)*y + f - e) / (a - b)) + c*y + e = 0
-- a*x + c*y + e = b*x + d*y + f
-- (d*a*y - c*a*y + f*a - e*a)/(a - b) + c*y + e = 0
