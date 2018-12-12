import sequtils, sugar, strutils, math, tables, algorithm

type Plants = OrderedTable[int, char]

iterator window_pairs[T](s: openArray[T], size: Positive): tuple[a: int, b: seq[T]] =
  var i: int = 0
  while i + size <= len(s):
    yield (i, s[i ..< i+size])
    i += 1

proc display(plants: Plants) =
  echo toSeq(keys(plants)).map(x => x mod 10).join
  echo toSeq(values(plants)).join

proc readRules(filename: string): Table[string, char] =
  result = initTable[string, char](1)
  for line in lines(filename):
    var split_line = line.split(" => " )
    result[split_line[0]] = split_line[1][0]

proc initPlants(input: string): Plants =
  result = initOrderedTable[int, char](1)
  for i, p in pairs(input):
    result[i] = p

proc pad(plants: Plants): Plants =
  let
    first_plant = toSeq(keys(plants)).min
    last_plant = toSeq(keys(plants)).max
  result = initOrderedTable[int, char](1)
  result[first_plant-2] = '.'
  result[first_plant-1] = '.'
  for i, p in plants:
    result[i] = p
  result[last_plant+1] = '.'
  result[last_plant+2] = '.'

# proc trim(plants: Plants): Plants =
#   var
#     first_plant = toSeq(keys(plants)).min
#     last_plant = toSeq(keys(plants)).max
#   for i, p in plants:
#     if p == '#':
#       first_plant = i
#       break

proc evolve(current: Plants, rules: Table[string, char], t: int): Plants =
  var next = initOrderedTable[int, char](1)
  for i, ps in window_pairs(toSeq(values(current)), 5):
    var next_plant: char = '.'
    if ps.join in rules:
      next_plant = rules[ps.join]
    next[i] = next_plant
  return next

proc score(plants: Plants): int =
  for i, p in plants:
    if p == '#': result += i

when isMainModule:
  var rules = readRules("./dat/12_test.txt")
  var plants = initPlants("#..#.#..##......###...###")
  display plants
  plants = evolve(plants.pad, rules, 1)
  display plants
