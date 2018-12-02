# AoC2018 Day 1 - Chronal Calibration

## Part 1
Part 1 asked us to add all the values in the input file. Simple enough except that the "+XX" lines didn't want to nicely convert to `Int` so I needed to create a helper function to work around that.

## Part 2
Part 2 asked to keep adding the input list until we found a duplicate total in the accumulated score. Initially I duplicated the input file multiple time until I had enough, but that gave a **large** input file so I eventually settled on this preferred solution with recursion.

## Stats
I completed Part 1 at 17:26:29EST in position 21,618. I forgot the things had started again until well into the evening (after Strictly Come Dancing) so this is why it is so late. However, it did take me a while as I lost time trying to remember enough `sed` to convert the input to a Haskell List before deciding to do it all in Haskell and try and get a grip on IO.

I completed Part 2 at 18:09:31EST in position 17,569. This was an extra 43 minutes 02 seconds. My initial solution didn't iterate the frequncy list so I needed to manually build a repeating input file as described above - this took a few attempts (but was the solution I put in to get the star). I then added things to do the iteration _in house_ as the input file was 207MB (I don't actually know how much of it I needed).  

I am [@penwing](https://www.twitter.com/penwing) on Twitter and [@penwing@cybre.space](https://cybre.space//@penwing) on Mastodon Federations
I am @penwing:cybre.space on Matrix
I am aoc@penwing.me.uk for queries relating to AoC
