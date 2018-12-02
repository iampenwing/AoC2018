-- AdventOfCode Day 1, Puzzle 2
-- Inventory Management System
-- https://adventofcode.com/2018/day/2

-- Alex Lambert (penwing)
-- aoc@penwing.me.uk

import Data.String
import System.Environment

-- sortString :: String -> String
-- sortString [] = []
-- sortString (x:xs) = insert x (sortString xs)

-- insert :: Char -> String -> String
-- insert c [] = [c]
-- insert c (x:xs)
--   | c <= x     = c:(x:xs)
--   | c > x      = x:(insert c xs)

countLetters :: String -> [(Char, Int)]
countLetters [] = []
countLetters (x:xs) = incLetter x (countLetters xs)

incLetter :: Char -> [(Char, Int)] -> [(Char, Int)]
incLetter c [] = [(c, 1)]
incLetter c ((x,xc):xs)
  | x==c    = ((x,(xc+1)):xs)
  | x/=c    = (x,xc):(incLetter c xs)

areTwo :: [(Char, Int)] -> Bool
areTwo [] = False
areTwo ((c,count):xs)
  | count == 2    = True
  | count /= 2    = areTwo xs

areThree :: [(Char, Int)] -> Bool
areThree [] = False
areThree ((c,count):xs)
  | count == 3    = True
  | count /= 3    = areThree xs

countTwos :: [[(Char, Int)]] -> Int
countTwos [] = 0
countTwos (x:xs) = if areTwo x then 1 + (countTwos xs) else (countTwos xs)

countThrees :: [[(Char, Int)]] -> Int
countThrees [] = 0
countThrees (x:xs) = if areThree x then 1 + (countThrees xs) else (countThrees xs)

checksum :: [[(Char, Int)]] -> Int
checksum x = (countTwos x) * (countThrees x)


main :: IO()
main = do
  [fileInput] <- getArgs
  fileContents <- readFile fileInput
  putStrLn (show (checksum (map countLetters (lines fileContents))))

  


