import sequtils, strutils, sugar, os, math

type Tree = object
  children: seq[Tree]
  metadata: seq[int]

proc read(filename: string): seq[int] =
  filename.readFile.strip.split(" ").map(x => parseInt(x))

func build(data: seq[int]): (Tree, seq[int]) =
  var
    num_children = data[0]
    num_metadata = data[1]
    new_data = data[2..^1]
    child: Tree
    children: seq[Tree] = @[]
    metadata: seq[int] = @[]

  for _ in 0..<num_children:
    (child, new_data) = build(new_data)
    children &= child

  metadata = new_data[0..<num_metadata]
  new_data = new_data[num_metadata..^1]

  return (Tree(children: children, metadata: metadata), new_data)

func sum(tree: Tree): int =
  tree.metadata.sum + tree.children.map(child => sum(child)).sum

iterator value(tree: Tree): int =
  if tree.children.len == 0:
    yield tree.metadata.sum
  else:
    for i in tree.metadata:
      if (i-1) in 0..<tree.children.len:
        yield value(tree.children[i-1])

when isMainModule:
  var (tree, _) = paramStr(1).read.build
  echo tree.sum

