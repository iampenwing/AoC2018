# AoC2018 Day 1 - Chronal Calibration

## Part 1
Part 1 asked us to add all the values in the input file. Simple enough except that the "+XX" lines didn't want to nicelyt convert to `Int` so I needed to create a helper function to work around that.

## Part 2
Part 2 asked to keep adding the input list until we found a duplicate total in the accumulated score. Initially I duplicated the input file multiple time until I had enough, but that gave a **large** input file so I eventually settled on this preferred solution with recursion.

I am @penwing on Twitter and @penwing@cybre.space on Mastodon Federations
I am @penwing:cybre.space on Matrix
I am aoc@penwing.me.uk for queries relating to AoC
