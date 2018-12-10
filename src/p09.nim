import os, strutils, sequtils

func winning_score(num_players: int, max_marble: int): int =
  var
    scores: seq[int] = repeat(0, num_players)
    circle: seq[int] = @[0]
    current: int = 0

  for marble in 1..max_marble:
    if marble mod 23 != 0:
      current = (current + 2) mod circle.len
      circle.insert(@[marble], current)
    else:
      current = ((current - 7 + circle.len) mod (circle.len))
      scores[marble mod num_players] += marble + circle[current]
      circle.delete(current, current)

  scores.max

when isMainModule:
  let
    num_players: int = paramStr(1).parseInt
    max_marble: int = paramStr(2).parseInt
    a1: int = winning_score(num_players, max_marble)

  echo a1
