-- AdventOfCode Day 5, Puzzle 1
-- Alchemical Reduction
-- https://adventofcode.com/2018/day/5

-- Alex Lambert (penwing)
-- aoc@penwing.me.uk

import Data.String
import System.Environment

offset :: Int
offset = (fromEnum 'a' ) - (fromEnum 'A')

polymerChomp :: String -> String
polymerChomp (x:[]) = [x]
polymerChomp (x:(y:ys))
  | (fromEnum x) == ((fromEnum y) + offset) = polymerChomp ys
  | (fromEnum x) == ((fromEnum y) - offset) = polymerChomp ys
  | True                                    = x:(polymerChomp (y:ys))

keepChomping :: String -> String
keepChomping [] = []
keepChomping polymer = let chomped = (polymerChomp polymer) in
  if ((length polymer) == (length chomped)) then polymer else keepChomping chomped

main :: IO()
main = do
  [fileInput] <- getArgs
  fileContents <- readFile fileInput
  putStrLn (show (length (keepChomping (head (lines fileContents)))))
