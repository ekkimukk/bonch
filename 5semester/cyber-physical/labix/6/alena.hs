module Main where
import Matrix

-- Функция для проверки размеров матриц
checkMatrixSizes :: Num a => [[a]] -> [[a]] -> [[a]] -> [[a]] -> Bool
checkMatrixSizes m1 m2 m3 m4 =
    all isSquare [m1, m2, m3] &&  -- Проверка, что m1 имеет размер N x N
    isRectangular m4 (length m2) (length m1) && -- Проверка, что m4 имеет размер NxM
    length m1 == length m2 && length m2 == length m3 && length m3 == 2

-- Проверка, что матрица квадратная (размер KxK)
isSquare :: Num a => [[a]] -> Bool
isSquare matrix = all (\row -> length row == n) matrix
    where n = length matrix

-- Проверка, что матрица имеет размер rows x cols
isRectangular :: Num a => [[a]] -> Int -> Int -> Bool
isRectangular matrix rows cols =
    length matrix == rows && all (\row -> length row == cols) matrix

-- Чтение матрицы
readMatrix :: FilePath -> IO [[Double]]
readMatrix filePath = do
    content <- readFile filePath
    let linesOfFile = lines content
    return $ map (map read . words) linesOfFile

-- Вывод матрицы
printMatrix :: [[Double]] -> IO ()
printMatrix matrix = mapM_ (putStrLn . unwords . map show) matrix

-- Функция для проверки, что все элементы матрицы неотрицательны
allNonNegative :: (Num a, Ord a) => [[a]] -> Bool
allNonNegative matrix = all (all (>= 0)) matrix

prNum:: Double -> IO()
prNum num = do
    print num

-- Вычисление элемента (i, j) треугольной матрицы с ограничениями
get :: [[Double]] -> [[Double]] -> (Int, Int) -> Double
get a l (i, j)
  | i == 0 && j == 0 = sqrt (a !! 0 !! 0)  -- Элемент (0, 0)
  | i == 0 && j /= 0 = (a !! i !! j) / (l !! 0 !! 0)  -- Элементы нулевой строки
  | i == j && i > 0 = sqrt ((a !! i !! i) - dotDiagonal) -- Диагональные элементы, i ∈ [1, n], i == j
  | i > j && 0 < j && j <= n - 1 && i <= n = ((a !! i !! j) - dotOffDiagonal) / (l !! j !! j)  -- Недиагональные элементы, i ∈ [2, n-1], j ∈ [i+1, n]
  | otherwise = 0  -- Верхний треугольник или элементы вне диапазона
  where
    n = length a  -- Размер матрицы
    -- Для диагональных элементов
    dotDiagonal = Prelude.sum [ (l !! i !! p) * (l !! i !! p) | p <- [0 .. i - 1] ]
    -- Для недиагональных элементов
    dotOffDiagonal = Prelude.sum [ (l !! i !! p) * (l !! j !! p) | p <- [0 .. j - 1] ]
  
-- Вычисление матрицы Холецкого
cholesky :: [[Double]] -> [[Double]]
cholesky a = cholesky' a 0
  where
    n = length a - 1
    cholesky' a k
      | k > n     = []
      | otherwise = row : cholesky' a (k + 1)
      where
        row = [ get a (cholesky' a 0) (i, k) | i <- [0 .. n] ]

-- Функция для решения квадратного уравнения: Ax^2 + Bx + C = 0
solveQuadratic :: Double -> Double -> Double -> Maybe (Double, Double)
solveQuadratic a b c
    | discriminant < 0 = Nothing  -- Нет действительных корней
    | otherwise = Just (x1, x2)
  where
    discriminant = b * b - 4 * a * c
    sqrtDiscriminant = sqrt discriminant
    x1 = (-b + sqrtDiscriminant) / (2 * a)
    x2 = (-b - sqrtDiscriminant) / (2 * a)

f1 :: Num a => [[a]] -> [[a]] -> [[a]] -> (a, a, a, a, a, a)
f1 matrixMi matrixL matrixF2 = (coef1C1, coef1C2, coef1C3, 
                                coef2C2, coef2C2, coef2C3)
    where
        a = matrixMi !! 0 !! 0
        f = matrixL !! 0 !! 1
        b = matrixMi !! 0 !! 1
        h = matrixL !! 1 !! 1
        c = matrixMi !! 1 !! 0
        e = matrixL !! 0 !! 0
        d = matrixMi !! 1 !! 1
        g = matrixL !! 1 !! 0
        c12 = matrixF2 !! 0 !! 1

        coef1A = a * f + b * h - c * e - d * g
        coef1B = b * f - a * h - d * e + c * g
        coef1C1 = -(coef1B * coef1B + coef1A * coef1A)
        coef1C2 = 2 * c12 * coef1A
        coef1C3 = coef1B * coef1B - c12 * c12

        coef2A = -a * f - b * h + c * e + d * g
        coef2B = -b * f + a * h + d * e - c * g
        coef2C1 = -(coef2B * coef2B + coef2A * coef2A)
        coef2C2 = 2 * c12 * coef2A
        coef2C3 = coef2B * coef2B - c12 * c12



main :: IO ()
main = do
    matrixA <- readMatrix "./tests/mine/A.dat"
    matrixB <- readMatrix "./tests/mine/B.dat"
    matrixR <- readMatrix "./tests/mine/R.dat"
    matrixQ <- readMatrix "./tests/mine/Q.dat"

    print $ checkMatrixSizes matrixR matrixQ matrixA matrixB
    print $ symmetric matrixR
    print $ symmetric matrixQ
    print $ allNonNegative matrixQ
    putStrLn ""

    let matrixRi = inverse matrixR
    putStrLn "Matrix Ri"
    printMatrix  matrixRi
    putStrLn  ""

    let matrixBt = transpose matrixB
    putStrLn "Matrix Bt"
    printMatrix  matrixBt
    putStrLn  ""

    let matrixS = matrixProduct (matrixProduct matrixB matrixRi) matrixBt
    putStrLn "Matrix S"
    printMatrix matrixS
    putStrLn ""

    let matrixMt = cholesky matrixS
    putStrLn "Matrix Mt"
    printMatrix matrixMt
    putStrLn ""

    let matrixM = transpose matrixMt
    putStrLn "Matrix M"
    printMatrix matrixM
    putStrLn ""

    putStrLn "Check Mt*M=S"
    printMatrix $ matrixProduct matrixMt matrixM
    putStrLn ""

    let matrixAt = transpose matrixA
    let matrixSi = inverse matrixS
    let matrixP = Matrix.sum matrixQ (matrixProduct (matrixProduct matrixAt matrixSi) matrixA)
    putStrLn "Matrix P"
    printMatrix matrixP
    putStrLn ""

    let matrixLt = cholesky matrixP
    putStrLn "Matrix Lt"
    printMatrix matrixLt
    putStrLn ""

    let matrixL = transpose matrixLt
    putStrLn "Matrix L"
    printMatrix matrixL
    putStrLn ""

    putStrLn "Check Lt*L=P"
    printMatrix $ matrixProduct matrixLt matrixL
    putStrLn ""

    let matrixF2 = difference (matrixProduct matrixAt matrixSi) (matrixProduct matrixSi matrixA)
    putStrLn "Matrix F2"
    printMatrix matrixF2
    putStrLn ""

    let matrixMi = inverse matrixM
    let (a1, b1, c1, a2, b2, c2) = f1 matrixMi matrixL matrixF2
    let (x1, x2) = solveQuadratic a1 b1 c1
    putStrLn ""

