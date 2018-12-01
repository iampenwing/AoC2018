-- AdventOfCode Day 1, Puzzle 1
-- Chronal Calibration
-- https://adventofcode.com/2018/day/1
-- Adds/subtracts all numbers in an input

-- Alex Lambert (penwing)
-- aoc@penwing.me.uk

-- import File
import Data.String
import System.Environment

myReadInt :: [Char] -> Int
myReadInt ('+':xs) = read xs :: Int
myReadInt x = read x :: Int

main :: IO()
main = do
  [fileInput, _] <- getArgs
  fileContents <- readFile fileInput
  putStrLn (show (foldr1 (+) (map (\a -> (myReadInt a)::Int) (lines fileContents))))

  


