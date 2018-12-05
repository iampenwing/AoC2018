-- AdventOfCode Day 5, Puzzle 2
-- Alchemical Reduction
-- https://adventofcode.com/2018/day/5

-- Alex Lambert (penwing)
-- aoc@penwing.me.uk

import Data.String
import System.Environment

offset :: Int
offset = (fromEnum 'a' ) - (fromEnum 'A')

polymerChomp :: String -> String
polymerChomp [] = []
polymerChomp (x:[]) = [x]
polymerChomp (x:(y:ys))
  | (fromEnum x) == ((fromEnum y) + offset) = polymerChomp ys
  | (fromEnum x) == ((fromEnum y) - offset) = polymerChomp ys
  | True                                    = x:(polymerChomp (y:ys))

keepChomping :: String -> String
keepChomping [] = []
keepChomping polymer = let chomped = (polymerChomp polymer) in
  if ((length polymer) == (length chomped)) then polymer else keepChomping chomped

removePolymer :: String -> Char -> String
removePolymer [] _ = []
removePolymer (x:xs) c
  | (c == x) || ((fromEnum c) + offset) == (fromEnum x) = removePolymer xs c
  | True                                                = x:(removePolymer xs c)

polymerReductions :: String -> [String]
polymerReductions polymer = map keepChomping (map (removePolymer polymer) ['A'..'Z'])

shortestReduction :: [Int] -> Int -> Int
shortestReduction [] a = a
shortestReduction (x:xs) a
  | x < a = shortestReduction xs x
  | True  = shortestReduction xs a

main :: IO()
main = do
  [fileInput] <- getArgs
  fileContents <- readFile fileInput
  putStrLn (show (shortestReduction (map length (polymerReductions (head (lines fileContents)))) 1000000000))
