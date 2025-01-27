module Main where

import System.Exit (die)
import Matrix
-- Функция для проверки размеров матриц
checkMatrixSizes :: Num a => [[a]] -> [[a]] -> [[a]] -> [[a]] -> IO()
checkMatrixSizes m1 m2 m3 m4 = do
    isSquare 2 m1
    isSquare 2 m2
    isSquare 2 m3
    isSquare 2 m4

-- Проверка, что матрица квадратная и имеет заданный размер
isSquare :: Num a => Int -> [[a]] -> IO ()
isSquare size matrix
    | length matrix /= size =
      die $ "\27[31m> [ Error ]\27[0m: Matrix has wrong number of rows, expected " ++ show size ++ " but got " ++ show (length matrix)
    | any (\row -> length row /= size) matrix = 
      die $ "\27[31m> [ Error ]\27[0m: Matrix is not square, expected " ++ show size ++ "x" ++ show size ++ " but got matrix with different column sizes"
    | otherwise = return ()

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

        coef2A = -(a * f) - b * h + c * e + d * g
        coef2B = -(b * f) + a * h + d * e - c * g
        coef2C1 = -(coef2B * coef2B + coef2A * coef2A)
        coef2C2 = 2 * c12 * coef2A
        coef2C3 = coef2B * coef2B - c12 * c12

calculateEigenvalues :: [[Double]] -> Maybe (Double, Double)
calculateEigenvalues matrix
    | length matrix /= 2 || any ((/= 2) . length) matrix = Nothing  -- Проверка на размерность матрицы
    | otherwise = solveQuadratic a b c
  where
    a = 1
    b = -(matrix !! 0 !! 0 + matrix !! 1 !! 1)
    c = matrix !! 0 !! 0 * matrix !! 1 !! 1 - matrix !! 0 !! 1 * matrix !! 1 !! 0

functionF l1 l2 t matrixA matrixS matrixK2 matrixE = result
    where 
        exp1 = exp (l1 * t)
        exp2 = exp (l2 * t)
        commonDiff = difference matrixA (matrixProduct matrixS matrixK2)
        left = scalarProduct (difference commonDiff (scalarProduct matrixE l2)) (1 / (l1 - l2))
        right = scalarProduct (difference commonDiff (scalarProduct matrixE l1)) (1 / (l2 - l1))
        result = Matrix.sum (scalarProduct left exp1) (scalarProduct right exp2)

-- Функция для умножения матриц
multiplyMatrices :: Num a => [[a]] -> [[a]] -> [[a]]
multiplyMatrices a b =
    [[ Prelude.sum (zipWith (*) row col) | col <- transpose b] | row <- a]
  where
    -- Функция для транспонирования матрицы
    transpose :: [[a]] -> [[a]]
    transpose ([] : _) = []
    transpose x = (map head x) : transpose (map tail x)


main :: IO ()
main = do
    matrixA <- readMatrix "./tests/mine/A.dat"
    matrixB <- readMatrix "./tests/mine/B.dat"
    matrixR <- readMatrix "./tests/mine/R.dat"
    matrixQ <- readMatrix "./tests/mine/Q.dat"

    checkMatrixSizes matrixR matrixQ matrixA matrixB
    putStrLn $ "\27[32m> R - symmetric:    \27[0m" ++ show (symmetric matrixR)
    putStrLn $ "\27[32m> Q - symmetric:    \27[0m" ++ show (symmetric matrixQ)
    putStrLn $ "\27[32m> Q - non-negative: \27[0m" ++ show (allNonNegative matrixQ)
    putStrLn ""

    let matrixRi = inverse matrixR
    putStrLn "\27[32m> Matrix Ri \27[0m"
    printMatrix  matrixRi
    putStrLn  ""

    let matrixBt = transpose matrixB
    putStrLn "\27[32m> Matrix Bt \27[0m"
    printMatrix  matrixBt
    putStrLn  ""

    let matrixS = matrixProduct (matrixProduct matrixB matrixRi) matrixBt
    putStrLn "\27[32m> Matrix S \27[0m"
    printMatrix matrixS
    putStrLn ""

    let matrixMt = cholesky matrixS
    putStrLn "\27[32m> Matrix Mt \27[0m"
    printMatrix matrixMt
    putStrLn ""

    let matrixM = transpose matrixMt
    putStrLn "\27[32m> Matrix M \27[0m"
    printMatrix matrixM
    putStrLn ""

    putStrLn "\27[32m> Check Mt*M=S \27[0m"
    printMatrix $ matrixProduct matrixMt matrixM
    putStrLn ""

    let matrixAt = transpose matrixA
    let matrixSi = inverse matrixS
    let matrixP = Matrix.sum matrixQ (matrixProduct (matrixProduct matrixAt matrixSi) matrixA)
    putStrLn "\27[32m> Matrix P \27[0m"
    printMatrix matrixP
    putStrLn ""

    let matrixLt = cholesky matrixP
    putStrLn "\27[32m> Matrix Lt \27[0m"
    printMatrix matrixLt
    putStrLn ""

    let matrixL = transpose matrixLt
    putStrLn "\27[32m> Matrix L \27[0m"
    printMatrix matrixL
    putStrLn ""

    putStrLn "\27[32m> Check Lt*L=P \27[0m"
    printMatrix $ matrixProduct matrixLt matrixL
    putStrLn ""

    let matrixF2 = difference(matrixProduct matrixAt matrixSi) (matrixProduct matrixSi matrixA)
    putStrLn "\27[32m> Matrix F2 \27[0m"
    printMatrix matrixF2
    putStrLn ""

    let matrixMi = inverse matrixM
    let (a1, b1, c1, a2, b2, c2) = f1 matrixMi matrixL matrixF2
    let (x1, x2) = case solveQuadratic a1 b1 c1 of
            Just (x1, x2) -> (x1, x2)
            Nothing -> error "No real roots"
    putStrLn $ "\27[32m> Roots (x): \27[0m" ++ show (x1, x2)
    putStrLn ""

    let y1 = sqrt $ 1 - x1 * x1
    let y2 = sqrt $ 1 - x2 * x2
    putStrLn $ "\27[32m> Roots (y = sqrt(1-x^2)): \27[0m" ++ show (y1, y2)
    putStrLn ""

    let matrixO1 = [[x1, -y1], [y1, x1]]
    let matrixK1 = Matrix.sum (matrixProduct matrixSi matrixA) ( matrixProduct (matrixProduct matrixMi matrixO1) matrixL)
    putStrLn $ "\27[32m> Matrix K1\27[0m"
    printMatrix matrixK1
    putStrLn ""

    let matrixO1t = transpose matrixO1
    putStrLn "\27[32m> Check O*Ot=E \27[0m"
    printMatrix $ matrixProduct matrixO1 matrixO1t
    putStrLn ""

    let matrixO2 = [[-x2, -y2], [y2, -x2]]
    let matrixK2 = Matrix.difference (matrixProduct matrixSi matrixA) ( matrixProduct (matrixProduct matrixMi matrixO2) matrixL)
    putStrLn $ "\27[32m> Matrix K2\27[0m"
    printMatrix matrixK2
    putStrLn ""

    let matrixO2t = transpose matrixO2
    putStrLn "\27[32m> Check O*Ot=E \27[0m"
    printMatrix $ matrixProduct matrixO2 matrixO2t
    putStrLn ""
    printMatrix $ matrixO2 
    putStrLn ""

    let cmatrixK1 = Matrix.difference matrixA (matrixProduct matrixS matrixK1)
    putStrLn "\27[32m> Characteristic matrix K1 \27[0m"
    printMatrix $ cmatrixK1
    putStrLn "\27[32m> Her L1, L2: \27[0m"
    let Just (l11, l12) = calculateEigenvalues cmatrixK1
    let matrixCh1 = [[l11], [l12]]
    printMatrix matrixCh1
    putStrLn ""

    let cmatrixK2 = Matrix.difference matrixA (matrixProduct matrixS matrixK2)
    putStrLn "\27[32m> Characteristic matrix K2 \27[0m"
    printMatrix $ cmatrixK2
    putStrLn "\27[32m> Her L1, L2: \27[0m"
    let Just (l21, l22) = calculateEigenvalues cmatrixK2
    let matrixCh2 = [[l21], [l22]]
    printMatrix matrixCh2
    putStrLn ""

    let matrixE = [[1, 0], [0, 1]]
    let t = 10
    let matrixCh = if allNonNegative matrixCh1 then matrixCh2 else matrixCh1

    putStrLn "\27[32m> Matrix F(t) \27[0m"
    let (l1, l2) = (matrixCh!!0!!0, matrixCh!!1!!0)
    let matrixF = functionF l1 l2 t matrixA matrixS matrixK2 matrixE
    printMatrix matrixF
    putStrLn ""

    let matrixX0 = [[1.2], [0.3]]
    let matrixX = multiplyMatrices matrixF matrixX0
    putStrLn "\27[32m> Matrix X(t) \27[0m"
    printMatrix matrixX
    putStrLn ""

    let matrixPfinal = multiplyMatrices matrixK2 matrixX
    putStrLn "\27[32m> Matrix p(t) \27[0m"
    printMatrix matrixPfinal
    putStrLn ""

    let matrixU = scalarProduct (multiplyMatrices (matrixProduct matrixRi matrixBt) matrixPfinal) (-1)
    putStrLn "\27[32m> Matrix u(t) \27[0m"
    printMatrix matrixU
    putStrLn ""

    putStrLn ""

