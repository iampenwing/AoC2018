-- AdventOfCode Day 1, Puzzle 2
-- Chronal Calibration
-- https://adventofcode.com/2018/day/1
-- Adds/subtracts all numbers in an input (looping the input) until finds a duplicate total.

-- Alex Lambert (penwing)
-- aoc@penwing.me.uk

-- import File
import Data.String
import System.Environment

myReadInt :: [Char] -> Int
myReadInt ('+':xs) = read xs :: Int
myReadInt x        = read x :: Int

isIn :: Int -> [Int] -> Bool
isIn _ []     = False
isIn x (y:ys)
  | x == y    = True
  | True      = isIn x ys

runFreq :: Int -> [Int] -> [Int] -> (Bool, Int, [Int])
runFreq s [] freqList            = (False, s, freqList)
runFreq s (x:xs) freqList = let newFreq = s + x in
                              if (isIn newFreq freqList)
                                 then (True, newFreq, freqList)
                                 else runFreq newFreq xs (newFreq:freqList)

runFreqs :: String -> Int -> [Int] -> IO ()
runFreqs fileContents n fList = let (found, value, freqList) = runFreq n (map myReadInt (lines fileContents)) fList in
    if found
       then putStrLn (show value)
       else runFreqs fileContents value freqList

main :: IO()
main = do
  [fileInput] <- getArgs
  fileContents <- readFile fileInput
  runFreqs fileContents 0 []
    
