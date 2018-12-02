import strutils, sequtils, sugar, math, sets

iterator cycle[T](xs: seq[T]): T =
  while true:
    for x in xs:
      yield x

proc main(): int =
  let read = toSeq(lines("./dat/01.txt")).map(x => parseInt(x))
  var reached = initSet[int]()
  for f in cycle(read):
    result += f
    if reached.containsOrIncl(result):
      return result

echo main()
