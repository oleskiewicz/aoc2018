import strutils, sequtils, sugar, math

toSeq(lines("./dat/01.txt"))
  .map(x => parseInt(x))
  .sum
  .echo
