import sequtils, algorithm

proc winning_score(num_players: int, num_marbles: int): int =
  var
    scores: seq[int] = repeat(0, num_players)
    circle: seq[int] = @[0]

  for marble in 1..<num_marbles:
    discard circle.rotateLeft(2)
    circle.insert(marble, 0)
    echo circle

  echo scores
  return scores.max

when isMainModule:
  let
    num_players: int = 9
    num_marbles: int = 26
    a1: int = winning_score(num_players, num_marbles)

  echo a1
