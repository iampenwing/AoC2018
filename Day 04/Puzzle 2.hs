-- AdventOfCode Day 3, Puzzle 2
-- No Matter How You Slice It
-- https://adventofcode.com/2018/day/3

-- Alex Lambert (penwing)
-- aoc@penwing.me.uk

import Data.String
import System.Environment

-- A Claim is a list of five Ints, [id, x, y, width, height]. x and y are inches from left edge and inches from top respectively.

mySort :: [String] -> [String]
mySort []     = []
mySort (x:xs) = myInsert x (mySort xs) where
  myInsert i [] = [i]
  myInsert i (y:ys)
    | i <= y = i:(y:ys)
    | True   = y:(myInsert i ys)

-- This gives us string about Guard shifts atarting and notes about sleep/wake status
splitNotes :: [String] -> ([String], [String]) -> ([String], [String])
splitNotes [] notes = notes
splitNotes (x:xs) (guards, statuses) = if ((x!!19) == 'G') then splitNotes xs ((x:guards), statuses) else splitNotes xs (guards, (x:statuses))

setGuards :: [String] -> [(String, String, String, String, String)]
setGuards [] = []
setGuards (x:xs) = (setGuard):(setGuards xs)
  where
    setGuard = (((x!!6):((x!!7):[])),
                 ((x!!9):((x!!10):[])),
                 ((x!!12):((x!!13):[])),
                 ((x!!15):((x!!16):[])),
                 (take ((length x) - 39) (drop 26 x)))
               
fixGuards :: [(String, String, String, String, String)] -> [(Int, Int, String)]
fixGuards [] = []
fixGuards ((month, day, "23", minute, id):xs)
  | (month == "01") && (day == "31")          = (2, 1, id):(fixGuards xs)
  | (month == "02") && (day == "28")          = (3, 1, id):(fixGuards xs)
  | (month == "03") && (day == "31")          = (4, 1, id):(fixGuards xs)
  | (month == "04") && (day == "30")          = (5, 1, id):(fixGuards xs)
  | (month == "05") && (day == "31")          = (6, 1, id):(fixGuards xs)
  | (month == "06") && (day == "30")          = (7, 1, id):(fixGuards xs)
  | (month == "07") && (day == "31")          = (8, 1, id):(fixGuards xs)
  | (month == "08") && (day == "31")          = (9, 1, id):(fixGuards xs)
  | (month == "09") && (day == "30")          = (10, 1, id):(fixGuards xs)
  | (month == "10") && (day == "31")          = (11, 1, id):(fixGuards xs)
  | (month == "11") && (day == "30")          = (12, 1, id):(fixGuards xs)
  | (month == "12") && (day == "31")          = (1, 1, id):(fixGuards xs)
  | True                                      = ((read month)::Int, (((read day)::Int) + 1), id):(fixGuards xs)
fixGuards ((month, day, "00", minute, id):xs) = ((read month)::Int, (read day)::Int, id):(fixGuards xs)

setSleeps :: [String] -> [(Int, Int, Int, Bool)]
setSleeps [] = []
setSleeps (x:xs) = (setSleep):(setSleeps xs)
  where
    setSleep = ((read ((x!!6):((x!!7):[]))::Int),
                (read ((x!!9):((x!!10):[]))::Int),
                (read ((x!!15):((x!!16):[]))::Int),
                (if ((x!!19) == 'f') then False else True))

makeDays :: [(Int, Int, String)] -> [(Int, Int, Int, Bool)] -> [(Int, Int, String, [Bool])]
makeDays [] _ = []
makeDays ((month, day, guard):guards) sleeps = let (today, newSleeps) = splitSleeps month day sleeps ([], []) in (makeDay month day guard today):(makeDays guards newSleeps)

makeDay :: Int -> Int -> String -> [Int] -> (Int, Int, String, [Bool])
makeDay month day guard changes = (month, day, guard, (makeHour 0 True))
      where
        makeHour 60 _ = []
        makeHour n awake
          | (isIn n changes) = (not awake):(makeHour (n + 1) (not awake))
          | True             = awake:(makeHour (n + 1) awake)
          where
            isIn _ [] = False
            isIn m (z:zs)
              | (m == z) = True
              | True     = isIn m zs

splitSleeps :: Int -> Int -> [(Int, Int, Int, Bool)] -> ([Int], [(Int, Int, Int, Bool)]) -> ([Int], [(Int, Int, Int, Bool)])
splitSleeps _ _ [] s = s 
splitSleeps month day ((sMonth, sDay, sMin, sAwake):ss) (sToday, sNew)
  | (sMonth == month) && (sDay == day) = splitSleeps month day ss ((sMin:sToday), sNew)
  | True                               = (sToday, (((sMonth, sDay, sMin, sAwake):ss) ++ sNew))

getGuard :: String -> [(Int, Int, String, [Bool])] -> [[Bool]]
getGuard _ [] = []
getGuard id ((_, _, gID, gSleep):days)
  | id == gID   = gSleep:(getGuard id days)
  | True        = getGuard id days

convertSleep :: [Bool] -> [Int]
convertSleep [] = []
convertSleep (x:xs) = if x then 0:(convertSleep xs) else 1:(convertSleep xs)

sleepyTimes :: [(Int, Int, String, [Bool])] -> [(String, [Int])] -> [(String, [Int])]
sleepyTimes [] a = a
sleepyTimes (day:rest) a = sleepyTimes rest (insertIn day a)
  where
    insertIn :: (Int, Int, String, [Bool]) -> [(String, [Int])] -> [(String, [Int])]
    insertIn (_, _, id, sleep) [] = [(id, (convertSleep sleep))]
    insertIn (m, d, id, sleep) ((cID, c):xs)
      | id == cID = (id, (zipWith (+) (convertSleep sleep) c)):xs
      | True      = (cID, c):(insertIn (m, d, id, sleep) xs)

sleepiestTime :: [(String, [Int])] -> [(String, Int, Int)]
sleepiestTime [] = []
sleepiestTime ((id, sleeps):rest) = (findSleepiestGTime (id, sleeps)):(sleepiestTime rest)
  where
    findSleepiestGTime :: (String, [Int]) -> (String, Int, Int)
    findSleepiestGTime (id, sleep) = findHighestPos id sleep 0 (0, 0)

findHighestPos :: String -> [Int] -> Int -> (Int, Int) -> (String, Int, Int)
findHighestPos id [] _ (pos, val) = (id, pos, val)
findHighestPos id (x:xs) n (pos, val)
  | x > val  = findHighestPos id xs (n+1) (n, x)
  | True     = findHighestPos id xs (n+1) (pos, val)

strategy2 :: [(String, Int, Int)] -> (String, Int, Int) -> Int
strategy2 [] (id, pos, val) = ((read id)::Int) * pos
strategy2 ((id, pos, val):rest) (maxID, maxPos, maxVal) = if (val > maxVal) then (strategy2 rest (id, pos, val)) else (strategy2 rest (maxID, maxPos, maxVal))
  
zeroes :: [Int]
zeroes = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]

main :: IO()
main = do
  [fileInput] <- getArgs
  fileContents <- readFile fileInput
  let (guards, statuses) = splitNotes (mySort (lines fileContents)) ([], []) in
    let newGuards = fixGuards (setGuards guards) in
      let newStatuses = setSleeps statuses in
        let days = makeDays newGuards newStatuses in
-- change below
          let theSleepyTimes = sleepyTimes days [] in
--            putStrLn (show (sleepiestTime (theSleepyTimes)))
            putStrLn (show (strategy2 (sleepiestTime (theSleepyTimes)) ("0", 0, 0)))
