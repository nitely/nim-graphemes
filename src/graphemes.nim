## This module provides support to
## handle unicode grapheme clusters

import unicode

from graphemes/private/grapheme_break import graphemeType

# Auto generated with github@nitely/regexy
# See ../gen/gen_re.nim for the original regex
const DFA = [
  [1, 21, 10, 13, 12, 11, 8, 25, 7, 22, 1, 14, 24, 23, 15, 20, 18, 17, 9],
  [1, -1, 5, -1, -1, 6, 4, -1, 3, -1, 2, -1, -1, -1, -1, -1, -1, -1, -1],
  [1, -1, -1, -1, -1, -1, 2, -1, 2, -1, 2, -1, -1, -1, -1, -1, -1, -1, -1],
  [1, -1, -1, -1, -1, -1, 2, -1, 2, -1, 2, -1, -1, -1, -1, -1, -1, -1, -1],
  [1, -1, -1, -1, -1, -1, 2, -1, 2, -1, 2, -1, -1, -1, -1, -1, -1, -1, -1],
  [1, -1, -1, -1, 2, -1, 2, -1, 5, -1, 2, -1, -1, -1, -1, -1, -1, -1, -1],
  [1, -1, -1, -1, -1, -1, 2, -1, 2, -1, 2, -1, -1, -1, -1, -1, -1, -1, -1],
  [1, -1, -1, -1, -1, -1, 2, -1, 2, -1, 2, -1, -1, -1, -1, -1, -1, -1, -1],
  [1, -1, -1, -1, -1, -1, 2, -1, 2, -1, 2, -1, -1, -1, -1, -1, -1, -1, -1],
  [1, -1, -1, -1, -1, -1, 2, -1, 2, -1, 2, -1, -1, -1, -1, -1, -1, -1, -1],
  [1, -1, -1, -1, 2, -1, 2, -1, 10, -1, 2, -1, -1, -1, -1, -1, -1, -1, -1],
  [1, -1, -1, -1, -1, -1, 2, -1, 2, -1, 2, -1, -1, -1, -1, -1, -1, -1, -1],
  [1, -1, -1, -1, -1, -1, 2, -1, 2, -1, 2, -1, -1, -1, -1, -1, -1, -1, -1],
  [1, -1, -1, -1, 2, -1, 2, -1, 10, -1, 2, -1, -1, -1, -1, -1, -1, -1, -1],
  [1, -1, -1, -1, -1, -1, 2, -1, 2, -1, 2, -1, -1, -1, -1, -1, -1, 14, -1],
  [1, -1, -1, -1, -1, -1, 2, -1, 2, -1, 2, -1, -1, -1, -1, -1, 15, 16, -1],
  [1, -1, -1, -1, -1, -1, 2, -1, 2, -1, 2, -1, -1, -1, -1, -1, -1, 16, -1],
  [1, -1, -1, -1, -1, -1, 2, -1, 2, -1, 2, -1, -1, -1, -1, -1, -1, 17, -1],
  [1, -1, -1, -1, -1, -1, 2, -1, 2, -1, 2, -1, -1, -1, -1, -1, 18, 19, -1],
  [1, -1, -1, -1, -1, -1, 2, -1, 2, -1, 2, -1, -1, -1, -1, -1, -1, 19, -1],
  [1, -1, -1, -1, -1, -1, 2, -1, 2, -1, 2, 14, -1, -1, 15, 20, 18, -1, -1],
  [1, 2, -1, -1, -1, -1, 2, -1, 2, -1, 2, -1, -1, -1, -1, -1, -1, -1, -1],
  [1, 21, 10, 10, 2, 2, 2, -1, 2, 22, 1, 14, -1, -1, 15, 20, 18, 17, 2],
  [1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1],
  [1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, 23, -1, -1, -1, -1, -1],
  [1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]
]

iterator graphemes*(text: string): string {.inline.} =
  ## Iterates over any grapheme (i.e user perceived character)
  ## of the string text returning graphemes
  var
    currState = DFA[0]
    cp: Rune
    a = 0
    b = 0
    n = 0

  while n < text.len:
    fastRuneAt(text, n, cp, true)
    let
      cpType = graphemeType(int(cp))
      nStateIdx = currState[cpType]

    if nStateIdx != -1:
      b = n
      currState = DFA[nStateIdx]
      continue
    # else break grapheme

    if b > a:
      yield text[a ..< b]
      a = b

    b = n
    assert DFA[0][cpType] >= 0
    currState = DFA[DFA[0][cpType]]

  if b > a:
    yield text[a ..< b]

proc graphemes*(text: string): seq[string] =
  ## Return a sequence containing the graphemes in text
  result = newSeqOfCap[string](text.len)
  for c in graphemes(text):
    result.add(c)
