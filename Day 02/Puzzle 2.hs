-- AdventOfCode Day 2, Puzzle 2
-- Inventory Management System
-- https://adventofcode.com/2018/day/2

-- Alex Lambert (penwing)
-- aoc@penwing.me.uk

import Data.String
import System.Environment

difference :: String -> String -> Int
difference [] [] = 0
difference (x:xs) (y:ys)
  | x == y    = difference xs ys
  | x /= y    = 1 + (difference xs ys)

findClose :: [String] -> (String, String)
findClose [] = ([],[])
findClose (x:xs) = let diffs = (map (difference x) xs) in let n = (isClose 1 diffs) in if (n /= 0) then (x, (getN n xs)) else findClose xs

isClose :: Int -> [Int] -> Int
isClose _ [] = 0
isClose n (x:xs)
  | x == 1 = n
  | x /= 1 = isClose (n+1) xs

getN :: Int -> [String] -> String
getN 1 (x:xs) = x
getN n (x:xs) = getN (n-1) xs

getCommon :: (String, String) -> String
getCommon ([],[]) = []
getCommon ((x:xs), (y:ys))
  | x == y   = x : (getCommon (xs, ys))
  | x /= y   = getCommon (xs, ys)

main :: IO()
main = do
  [fileInput] <- getArgs
  fileContents <- readFile fileInput
  putStrLn (getCommon (findClose (lines fileContents)))

  


