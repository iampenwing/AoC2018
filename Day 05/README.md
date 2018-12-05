# AoC2018 Day 5 - Alchemical Reduction

## Part 1
This puzzle is about "reducing polymers" representated by a long string of letters. Adjecent letters can be removed from to overall string *if* they are the lower case and upper case versions of the same letter; so ,`Aa` and `aA` would both be removed but `aa` and `AA` can't, nor can `aB`. 

Part 1 asks for the length that my input string will eventually be reduced to.

I enjoyed the naming of my functions here. I just saw the reduction process as chomping and I have a silly sense of humour about it.

`polymerChomp :: String -> String` takes a string input and does a single pass over it to try and reduce the polymers.

`keepChomping :: String -> String` keps on running `polymerChomp` until there are no further reductions. I could improve efficiency by passing the length of the previous `String` around to avoid running `length` on it so many times. 

## Part 2
Part 2 asks me to find the shortest length I can from my input if I were to remove one polymer from it completely before starting the polymer reduction.

for this part I needed to add a functrion (`polymerReductions :: String -> [String]`) which would run `keepChomping` over each adjusted polymer list with an individual polymer pair removed by `removePolymer :: String -> Char -> String`.

## Stats
I completed Part 1 at 01:29:41EST in position 3419. This was about 6:30 local time. Only took me about twenty-twenty five minutes (after waking at 6am).

I completed Part 2 at 01:44:12EST in position 3110. This was about 6:45 local time). This only took an extra 15 minutes to complete. I'm really quite proud of this, when the write up warned about the length og the input I was really worried about the number of times I'd be recursing along the various polymer chains.


I am [@penwing](https://www.twitter.com/penwing) on Twitter and [@penwing@cybre.space](https://cybre.space//@penwing) on Mastodon Federations
I am @penwing:cybre.space on Matrix
I am aoc@penwing.me.uk for queries relating to AoC
