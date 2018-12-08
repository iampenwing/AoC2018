-- AdventOfCode Day 7, Puzzle 1
-- The Sum of its Parts
-- https://adventofcode.com/2018/day/7

-- Alex Lambert (penwing)
-- aoc@penwing.me.uk

import Data.String
import qualified Data.Set as Set
import System.Environment

extractBlockers :: String -> (Char, Char)
extractBlockers line = (line!!36, line!!5)

makeBlockList :: [(Char, Char)] -> [(Char, Set.Set Char)] -> [(Char, Set.Set Char)]
makeBlockList [] a = a
makeBlockList ((step, blocker):blockers) a = makeBlockList blockers (insertBlock step blocker a)
  where
    insertBlock :: Char -> Char -> [(Char, Set.Set Char)] -> [(Char, Set.Set Char)]
    insertBlock a b [] = [(a, Set.singleton b)]
    insertBlock a b ((step, iBlockers):rest)
      | a == step = (step, Set.insert b iBlockers):rest
      | True      = (step, iBlockers):(insertBlock a b rest)

getBlockers :: [(Char, Set.Set Char)] -> Char -> Set.Set Char
getBlockers [] _ = Set.empty
getBlockers ((b, blockers):rest) a
  | a == b = blockers
  | True   = getBlockers rest a

findFreeSteps :: [Char] -> [Set.Set Char] -> [Char]
findFreeSteps _ [] = []
findFreeSteps (a:b) (y:z)
  | Set.null y = a:(findFreeSteps b z)
  | True       = findFreeSteps b z

removeStep :: Char -> [Char] -> [Set.Set Char] -> ([Char], [Set.Set Char]) -> ([Char], [Set.Set Char])
removeStep _ [] _ x = x
removeStep removing (step:steps) (blocker:blockers) (remainingSteps, remainingBlockers)
  | removing == step = removeStep removing steps blockers (remainingSteps, remainingBlockers)
  | True             = removeStep removing steps blockers ((step:remainingSteps), ((Set.delete removing blocker):remainingBlockers))

buildOrder :: [Char] -> [Set.Set Char] -> String
buildOrder [] _ = []
buildOrder steps blockers =
  let freeStep = getLowest (findFreeSteps steps blockers) in
    let (newSteps, newBlocks) = removeStep freeStep steps blockers ([], []) in
      freeStep:(buildOrder newSteps newBlocks)
  
getLowest :: String -> Char
getLowest x = igetLowest x 'Z'
  where
    igetLowest :: String -> Char -> Char
    igetLowest [] z = z
    igetLowest (x:xs) z
      | x < z  = igetLowest xs x
      | x >= z = igetLowest xs z

main :: IO()
main = do
  [fileInput] <- getArgs
  fileContents <- readFile fileInput
  let steps = ['A'..'Z'] in
    let blockers = (makeBlockList (map extractBlockers (lines fileContents)) []) in
      putStrLn (show (buildOrder steps (map (getBlockers blockers) steps)))
