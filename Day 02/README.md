# AoC2018 Day 2 - Inventory Management System

## Part 1
Part 1 asked us to find _similar_ inventory IDs. This part though wanted us to generate a _checksum_ for the input list - in particular it wanted a _checksum_ made up of the number of strings with two matching characters multipled by the number of strings with three matching characters

## Part 2
Part 2 asked us to find the two _similar_ strings and provide just the common characters. _Similar_ here meant differed by one character.

## Stats
I completed Part 1 at 03:51:32EST in position 6,052. I don't really expect to do much better than this as the puzzles are released at 5am local time and today was Sunday after staying up late finishing and tidying Day 1. I originally wrote an insertion-sort function to sort each input b ut then realised I didn't need it so that lost me some time. My first draft also managed to forget to build up a list in `incLetter` properly so it would only actually count the first letter. D'Oh!

I completed Part 2 at 04:17:18EST in position 5,292. This is 25 minutes 46 seconds later. This used nothing from the Part 1, being a very different puzzle really. 


I am [@penwing](https://www.twitter.com/penwing) on Twitter and [@penwing@cybre.space](https://cybre.space//@penwing) on Mastodon Federations
I am @penwing:cybre.space on Matrix
I am aoc@penwing.me.uk for queries relating to AoC
