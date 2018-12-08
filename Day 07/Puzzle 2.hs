-- AdventOfCode Day 7, Puzzle 2
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

baseTime :: Int
baseTime = 60

offset :: Int
offset = (fromEnum 'A')

maxWorkers :: Int
maxWorkers = 5

getLowest :: String -> Char
getLowest x = igetLowest x 'Z'
  where
    igetLowest :: String -> Char -> Char
    igetLowest [] z = z
    igetLowest (x:xs) z
      | x < z  = igetLowest xs x
      | x >= z = igetLowest xs z

doWork :: Int -> [(Char, Int)] -> [Char] -> [Set.Set Char] -> Int
doWork t [] [] _ = (t - 1)
doWork t work steps blocks =
  let (newWork, finished) = finishWork work ([],[]) in
    let (newSteps, newBlocks) = updateFinishedWork finished steps blocks in
      let freeSteps = findFreeSteps newSteps newBlocks in
        let newNewWork = allocateWork (mySort freeSteps []) newWork in
          doWork (t+1) newNewWork newSteps newBlocks

mySort :: [Char] -> [Char] -> [Char]
mySort [] s = s
mySort (x:xs) [] = mySort xs [x]
mySort (x:xs) (s:ss)
  | x <= s = mySort xs (x:(s:ss))
  | True   = s:(mySort (x:xs) ss)

allocateWork :: [Char] -> [(Char, Int)] -> [(Char, Int)]
allocateWork [] w = w
allocateWork (x:xs) w
  | length w == maxWorkers = w
  | isAllocated x w        = allocateWork xs w
  | True                   = allocateWork xs ((x, (((fromEnum x) - offset) + baseTime)):w)
  where
    isAllocated :: Char -> [(Char, Int)] -> Bool
    isAllocated _ [] = False
    isAllocated x ((doingw, _):ys)
      | x == doingw = True
      | True        = isAllocated x ys


finishWork :: [(Char, Int)] -> ([(Char, Int)], [Char]) -> ([(Char, Int)], [Char])
finishWork [] (accWork, accFin) = (accWork, (reverse accFin))
finishWork ((w, t):work) (accWork, accFin)
  | t == 0 = finishWork work (accWork, w:accFin)
  | True   = finishWork work (((w, (t-1)):accWork), accFin)

updateFinishedWork :: [Char] -> [Char] -> [Set.Set Char] -> ([Char], [Set.Set Char])
updateFinishedWork [] steps blocks = (steps, blocks)
updateFinishedWork (f:fs) steps blocks =
  let (newSteps, newBlocks) = removeStep f steps blocks ([], []) in
    updateFinishedWork fs newSteps newBlocks

main :: IO()
main = do
  [fileInput] <- getArgs
  fileContents <- readFile fileInput
  let steps = ['A'..'Z'] in
    let blockers = (makeBlockList (map extractBlockers (lines fileContents)) []) in
      putStrLn (show (doWork 0 [] steps (map (getBlockers blockers) steps)))
