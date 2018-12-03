-- AdventOfCode Day 3, Puzzle 1
-- No Matter How You Slice It
-- https://adventofcode.com/2018/day/3

-- Alex Lambert (penwing)
-- aoc@penwing.me.uk

import Data.String
import System.Environment

-- A Claim is a list of five Ints, [id, x, y, width, height]. x and y are inches from left edge and inches from top respectively.

extractClaim :: String -> [Int]
extractClaim [] = []
extractClaim (x:xs)
  | (x >= '0') && (x <= '9') = let (num, rest) = getNum (x:xs) [] in num:(extractClaim rest)
  | True       = extractClaim xs

getNum :: String -> String -> (Int, String)
getNum [] num = ((read num)::Int, [])
getNum (x:xs) y
  | (x >= '0') && (x <= '9')  = getNum xs (y ++ [x])
  | True                      = ((read y)::Int, xs)

-- stakeClaim :: [[[Int]]] -> [Int] -> [[[Int]]]
-- stakeClaim cloth (id:(x:(y:(w:(h:[])))))
--   = iStakeClaim cloth id x y w h

-- iStakeClaim :: [[[Int]]] -> Int -> Int -> Int -> Int -> Int -> [[[Int]]]
--  first of all needs to recurse down to the correct height
--  then needs to recurse down each height adding the ID in each correct width
-- iStakeClaim cloth id x 0 w h = 

stakeClaim :: [(Int, Int, [Int]) -> [Int] -> [(Int, Int, [Int])]
stakeClaim cloth (id:(x:(y:w:(h:[])))) =

-- rather than mapping the whole cloth, I'm storing x,y co-ordinates with a l;ist of IDs claiming them

main :: IO()
main = do
  [fileInput] <- getArgs
  fileContents <- readFile fileInput
  putStrLn (show (map extractClaim (lines fileContents)))

  


