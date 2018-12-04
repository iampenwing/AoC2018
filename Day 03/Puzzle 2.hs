-- AdventOfCode Day 3, Puzzle 2
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

-- rather than mapping the whole cloth, I'm storing x,y co-ordinates with a list of IDs claiming them

makeClaim1 :: [[Int]] -> [((Int, Int), [Int], Int)] -> [((Int, Int), [Int], Int)] 
makeClaim1 [] claims = claims
makeClaim1 ((id:(x:(y:(w:(h:[]))))):rest) claims = insertClaims [(((x + nX), (y + nY)), id) | nX <- [0..(w - 1)] , nY <- [0..(h - 1)]] (makeClaim1 rest claims)

insertClaim1 :: ((Int, Int), Int) -> [((Int, Int), [Int], Int)] -> [((Int, Int), [Int], Int)]
insertClaim1 ((claimX, claimY), claimID) [] = [((claimX, claimY), [claimID], 1)]
insertClaim1 ((claimX, claimY), claimID) (((firstX, firstY), firstIDs, firstCount):claims)
  | (claimX == firstX) && (claimY == firstY) = (((claimX, claimY), (claimID:firstIDs), (firstCount + 1)):claims)
  | True                                     = (((firstX, firstY), firstIDs, firstCount):(insertClaim1 ((claimX, claimY), claimID) claims))

insertClaims :: [((Int, Int), Int)] -> [((Int, Int), [Int], Int)] -> [((Int, Int), [Int], Int)]
insertClaims [] claims = claims
insertClaims (claim:claims) currentClaims = insertClaims claims (insertClaim1 claim currentClaims)

countOverlaps1 :: [((Int, Int), [Int], Int)] -> Int
countOverlaps1 [] = 0
countOverlaps1 (((_, _), _, c):squares) = if c > 1 then 1 + (countOverlaps1 squares) else countOverlaps1 squares

discardOverlaps :: [((Int, Int), [Int], Int)] -> [Int] -> [Int]
discardOverlaps [] ids = ids
discardOverlaps (((_, _), ids, c):rest) remainingIDs
  | c == 1  = discardOverlaps rest remainingIDs
  | True    = discardOverlaps rest (removeIDs ids remainingIDs)

removeIDs :: [Int] -> [Int] -> [Int]
removeIDs [] remainingIDs = remainingIDs
removeIDs (x:xs) remainingIDs = removeID x (removeIDs xs remainingIDs)

removeID :: Int -> [Int] -> [Int]
removeID _ [] = []
removeID id (x:xs)
  | id == x   = xs
  | id > x    = (x:xs)
  | True      = x:(removeID id xs)

main :: IO()
main = do
  [fileInput] <- getArgs
  fileContents <- readFile fileInput
  putStrLn (show (discardOverlaps (makeClaim1 (map extractClaim (lines fileContents)) []) [1..1301]))

  

