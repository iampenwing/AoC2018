# AoC2018 Day 3 - No matter how you slice it

## Part 1
Part 1 asked us to find how many square inches of fabric were claimed by two or more overlapping ideas for cutting. I initially planned on literally mapping the claims onto an `[[[Int]]]` representing a list of all IDs claiming that square of the cloth. Then ~I decided _screw that_ and instead just kept a list of the relevent co-ordinates. I went through multiple iterations trying to avoid traversing the list of co-ordinates too many times (hence the `makeClaim1` series of functions having 1 appended to their names). 

## Part 2
I guessed the requirement for Part 2 while waiting for Part 1 to compute. Which was handy. Find the only non-overlapping claim.


## Stats
I completed Part 1 late in position 20629.

I completed Part 2 even later in position 21526.

The big problem here was processing time. Each part took somewhere between 7 and 15 hours. My first stabs at Part 2 had small errors that I needed to fix and re-run each time.


I am [@penwing](https://www.twitter.com/penwing) on Twitter and [@penwing@cybre.space](https://cybre.space//@penwing) on Mastodon Federations
I am @penwing:cybre.space on Matrix
I am aoc@penwing.me.uk for queries relating to AoC
