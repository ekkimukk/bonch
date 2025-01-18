-- import System.IO
-- import Control.Monad (replicateM)
-- import Data.List (transpose)
import Matrix

-- Функция для проверки размеров матриц
checkMatrixSizes :: Num a => [[a]] -> [[a]] -> [[a]] -> [[a]] -> Bool
checkMatrixSizes m1 m2 m3 m4 =
    isSquare m1 &&  -- Проверка, что m1 имеет размер MxM
    isSquare m2 &&  -- Проверка, что m2 имеет размер NxN
    isSquare m3 &&  -- Проверка, что m3 имеет размер NxN
    isRectangular m4 (length m2) (length m1)  -- Проверка, что m4 имеет размер NxM

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

-- Вычисление элемента (i, j) треугольной матрицы
get :: [[Double]] -> [[Double]] -> (Int, Int) -> Double
get a l (i, j)
  | i == j    = sqrt $ (a !! j !! j) - dot
  | i > j     = ((a !! i !! j) - dot) / (l !! j !! j)
  | otherwise = 0
  where
    dot = Prelude.sum [ (l !! i !! k) * (l !! j !! k) | k <- [0 .. j - 1] ]
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

-- Функция для вычисления матрицы O(x, y)
oMatrix :: Double -> [[Double]]
oMatrix x =
    let y = sqrt (1 - x**2)
    in [[x, -y], [y, x]]

-- Функция для вычисления F1(x, y)
f1 :: Double -> [[Double]] -> [[Double]] -> [[Double]] -> [[Double]]
f1 x m l a =
    let o = oMatrix x
        mInv = inverse m
        mTInv = inverse (transpose m)
        term1 = matrixProduct (matrixProduct mInv o) l
        term2 = matrixProduct (matrixProduct (transpose l) (transpose o)) mTInv
    in Matrix.difference term1 term2


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
    putStrLn $ ""

    let matrixRi = inverse matrixR
    putStrLn $ "Matrix Ri"
    printMatrix $ matrixRi
    putStrLn $ ""

    let matrixBt = transpose matrixB
    putStrLn $ "Matrix Bt"
    printMatrix $ matrixBt
    putStrLn $ ""

    let matrixS = matrixProduct (matrixProduct matrixB matrixRi) matrixBt
    putStrLn $ "Matrix S"
    printMatrix $ matrixS
    putStrLn $ ""

    let matrixM = cholesky matrixS
    putStrLn $ "Matrix M"
    printMatrix $ matrixM
    putStrLn $ ""

    let matrixMt = transpose matrixM
    putStrLn $ "Проверка Mt*M=S"
    printMatrix $ matrixProduct matrixMt matrixM
    putStrLn $ ""

    let matrixAt = transpose matrixA
    let matrixSi = inverse matrixS
    let matrixP = Matrix.sum matrixQ (matrixProduct (matrixProduct matrixAt matrixSi) matrixA)
    putStrLn $ "Matrix P"
    printMatrix $ matrixP
    putStrLn $ ""

    let matrixL = cholesky matrixP
    putStrLn $ "Matrix L"
    printMatrix $ matrixL
    putStrLn $ ""

    let matrixLt = transpose matrixL
    putStrLn $ "Проверка Lt*L=P"
    printMatrix $ matrixProduct matrixLt matrixL
    putStrLn $ ""

    let matrixF2 = Matrix.difference (matrixProduct matrixAt matrixSi) (matrixProduct matrixSi matrixA)
    putStrLn $ "Matrix F2"
    printMatrix $ matrixF2
    putStrLn $ ""

    let x = 0
    let matrixF1 = f1 x matrixM matrixL matrixA
    printMatrix $ matrixF1
    putStrLn $ ""

    let matrixOt = transpose matrixF1
    printMatrix $ matrixProduct matrixF1 matrixOt

    putStrLn $ ""




