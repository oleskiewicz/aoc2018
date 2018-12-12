import sequtils, sugar, strutils, math, tables, algorithm, strformat, sets

iterator window_pairs(s: string, size: Positive): tuple[a: int, b: string] =
  var i: int = 0
  while i + size <= len(s):
    yield (i, s[i ..< i+size].join)
    i += 1

proc split(s: string): seq[char] =
  for c in s: result &= c

proc readRules(filename: string): Table[string, char] =
  result = initTable[string, char](1)
  for line in lines(filename):
    var split_line = line.split(" => " )
    if split_line[1] == "#":
      result[split_line[0]] = split_line[1][0]

proc evolve(plants: string, first_plant: int, rules: Table[string, char], t: int): tuple[a: string, b: int] =
   result = (repeat('.', len(plants)).join, first_plant)
   for i, ps in window_pairs(plants.pad, 5):
     #echo &"{i:03}: {ps}"
     if ps.join in rules:
       result[0][i] = rules[ps.join]
     else:
       result[0][i] = '.'

when isMainModule:
  var
    rules = readRules("./dat/12_test.txt")
    plants = "#..#.#..##......###...###"
    pots = initSet[int]()
  
  for i, p in plants:
    if p == '#':
      pots.incl(i)

  #echo plants
  #(plants, i) = evolve(plants, 0, rules, 1)
  #echo plants
  #(plants, i) = evolve(plants, 0, rules, 1)
  #echo plants
