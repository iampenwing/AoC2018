# AoC2018 Day 3 - Repose Record

Oh god, this puzzle. Eugh! I woke up at six to look at this?!?!??

## Part 0
So before I can even get to the puzzles here, we need to parse a load of unsorted notes to establish when various guards were asleep and awake. Unfortunately, there is a line every day saying which guard is on duty (sometimes they come on a few minutes before the day starts so the timestamp is for the day before...) but then the guard ID isn't referenced with the time stamps for waking and sleeping.

And then there are months. And yes, this f%cking puzzle has some of those early starts be on the end of the month so I've got to track that crap too.

You  might be able to tell, I hate this one.

### Parsing
So, problem one is to parse the inputs. Sorting them is the first step as we need to get guard IDs to appropriately associate with the following sleep status notes. This is a straightforward function (`mySort :: [String] -> [String]`) to carry out an insertion sort.

The inputs look like this (although the Guard ID can be three or four digits in my input):

```
0000000000111111111122222222223333333333
0123456789012345678901234567890123456789
[YYYY-MM-DD HH:MM] Guard #XXX begins shift
[YYYY-MM-DD HH:MM] wakes up
[YYYY-MM-DD HH:MM] falls asleep
```

Different things are important for the Guard details and for the sleep patterns so I split the notes into two lists for processing (`splitNotes [String] -> ([String], [String])`). This is done on whether the note has a 'G' in the 19th position (Guard coming on duty) or not (sleep pattern).

The `setGuards :: [String] -> [(String, String, String, String, String)]` function is about getting the important bits of the guard notes - (Month, Day, Hour, Minute, ID). Largely this is done by selecting the relevant characters, but for the Guard ID, because of it's variable length, I know the start position, so I can `drop` everything prior to it, and I know the length of everything else in the string so I can work out how long the ID is by taking 39 away from the `length` and `take` that many characters.

`fixGuards :: [(String, String, String, String, String)] -> [(Int, Int, String)]` simplifies things. The problem mentioned earlier where some guards start the day before are fixed here to ensure that the guardID is assigned to the right date. Ugly, brute force handling of Months applies here. I also change the month and day into `Int`s.

Yeah, there's a *lot* of work going into this parsing isn't there? Not quite done yet...

`setSleeps :: [String] -> [(Int, Int, Int, Bool)]` on the other hand is parsing the sleep notes to a (month, day, minute, awake state). This is marginally easier than parsing the guards as everything is in the right day. Again, I've trimmed out unnecessary info (i.e. the hour is always 00).

I can then process these inputs so I can have a processed list of each day, which guard is on, and their sleep pattern over the 00:XX hour. `makeDays :: [(Int, Int, String)] -> [(Int, Int, Int, Bool)] -> [(Int, Int, String, [Bool])]` is the function which does this. It recurses down over each day (per the list of Guards), separates out that day's sleep pattern notes and calls `makeDay :: Int -> Int -> String -> [Int] -> (Int, Int, String, [Bool])` (the output is (month, day, guard ID, sleep pattern)). the sub-function `makeHour :: Int -> [Bool]` gives uses today's sleep notes to bvuild up a list of 60 `Bool`s which represent whether the guard is awake (`True`) or asleep (`False`).

## Part 1 ("Strategy 1")
Strategy 1 is to find the guard who has been asleep the most and the most common minute they spent asleep.

So, `sleepyGuards :: [(Int, Int, String, [Bool])] -> [(String, Int)] -> [(String, Int)]` counts how often each guard is asleep across all their shifts. `sleepiestGuard :: [(String, Int)] -> (String, Int) -> String` takes that output and find the highest sleep count and returns the guard ID. This allows us to get all that guard's sleep patterns with `getGuard :: String -> [(Int, Int, String, [Bool])] -> [[Bool]]` which can then be fed to `countSleep :: [[Bool]] -> [Int] -> [Int]`. This gives a list of how many shifts the guard has been asleep in each minute. Then `findHighestPos :: [Int] -> Int -> (Int, Int) -> Int` which can find the most common minute the guard spends asleep.

Then we can multiply them together for the answer required by this absolute ars%h%le of a puzzle.

## Part 2 - "Strategy 2"
Strategy 2 is to find the guard is most consistent with sleep patterns. You can work it out from the code - my enthusiasm for documenting this mess has run out.

## Stats
I completed Part 1 at 18:30:09EST in position 12114. 

I completed Part 2 at 19:14:00EST in position 11738. I am really proud of this - I got it done before midnight local time having had to spend a day at work and then go to book club after work. And did I mention how much I hated this thing - the parsing was hideous. 


I am [@penwing](https://www.twitter.com/penwing) on Twitter and [@penwing@cybre.space](https://cybre.space//@penwing) on Mastodon Federations
I am @penwing:cybre.space on Matrix
I am aoc@penwing.me.uk for queries relating to AoC
