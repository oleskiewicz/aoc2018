## Day 5
import os, strutils, sequtils, sugar, deques

func `=~=`(a: char, b: char): bool =
  ## Compares if two characters are "foldable"
  a != b and a.toLowerAscii == b.toLowerAscii

func `===`(a: char, b: char): bool =
  ## Compares if two characters are case-insensitively the same
  a == b or a == b.toLowerAscii or a == b.toUpperAscii

func split(s: string): seq[char] =
  ## Split string without a separator.  Is this not in stdlib?
  toSeq(s.items)

func fold_len(polymer: seq[char]): int =
  ## Create a queue and append to it if character is not foldable,
  var
    c: char
    folded = initDeque[char]()
  folded.addFirst('.')
  for p in polymer:
    c = folded.peekLast
    if p =~= c:
      discard folded.popLast
    else:
      folded.addLast(p)
  discard folded.popFirst
  return folded.len

func folded_shortest(polymer: seq[char]): int =
  ## Find shortest possible fold
  polymer
    .deduplicate
    .filter(x => x.isLowerAscii)
    .map(c => polymer.filter(x => not (x === c)).fold_len)
    .min

import unittest
check:
  'a' =~= 'A'
  'A' =~= 'a'
  not ('a' =~= 'a')
  not ('a' =~= 'b')
  'a' === 'A'
  'a' === 'a'
  'A' === 'A'
  "dabAcCaCBAcCcaDA".split.fold_len == 10
  "dabAcCaCBAcCcaDA".split.folded_shortest == 4

when isMainModule:
  let polymer: seq[char] = paramStr(1).readFile.strip.split

  # part 1
  echo polymer.fold_len

  # part 2
  echo polymer.folded_shortest

