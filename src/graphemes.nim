## This module provides support to
## handle unicode grapheme clusters

import unicode

from graphemes/private/grapheme_break import graphemeType

# Auto generated with github@nitely/regexy
# See ../gen/gen_re.nim for the original regex
const
  dfa = [
    [1'i8, 21, 10, 13, 12, 11, 8, 25, 7, 22, 1, 14, 24, 23, 15, 20, 18, 17, 9],
    [1'i8, -1, 5, -1, -1, 6, 4, -1, 3, -1, 2, -1, -1, -1, -1, -1, -1, -1, -1],
    [1'i8, -1, -1, -1, -1, -1, 2, -1, 2, -1, 2, -1, -1, -1, -1, -1, -1, -1, -1],
    [1'i8, -1, -1, -1, -1, -1, 2, -1, 2, -1, 2, -1, -1, -1, -1, -1, -1, -1, -1],
    [1'i8, -1, -1, -1, -1, -1, 2, -1, 2, -1, 2, -1, -1, -1, -1, -1, -1, -1, -1],
    [1'i8, -1, -1, -1, 2, -1, 2, -1, 5, -1, 2, -1, -1, -1, -1, -1, -1, -1, -1],
    [1'i8, -1, -1, -1, -1, -1, 2, -1, 2, -1, 2, -1, -1, -1, -1, -1, -1, -1, -1],
    [1'i8, -1, -1, -1, -1, -1, 2, -1, 2, -1, 2, -1, -1, -1, -1, -1, -1, -1, -1],
    [1'i8, -1, -1, -1, -1, -1, 2, -1, 2, -1, 2, -1, -1, -1, -1, -1, -1, -1, -1],
    [1'i8, -1, -1, -1, -1, -1, 2, -1, 2, -1, 2, -1, -1, -1, -1, -1, -1, -1, -1],
    [1'i8, -1, -1, -1, 2, -1, 2, -1, 10, -1, 2, -1, -1, -1, -1, -1, -1, -1, -1],
    [1'i8, -1, -1, -1, -1, -1, 2, -1, 2, -1, 2, -1, -1, -1, -1, -1, -1, -1, -1],
    [1'i8, -1, -1, -1, -1, -1, 2, -1, 2, -1, 2, -1, -1, -1, -1, -1, -1, -1, -1],
    [1'i8, -1, -1, -1, 2, -1, 2, -1, 10, -1, 2, -1, -1, -1, -1, -1, -1, -1, -1],
    [1'i8, -1, -1, -1, -1, -1, 2, -1, 2, -1, 2, -1, -1, -1, -1, -1, -1, 14, -1],
    [1'i8, -1, -1, -1, -1, -1, 2, -1, 2, -1, 2, -1, -1, -1, -1, -1, 15, 16, -1],
    [1'i8, -1, -1, -1, -1, -1, 2, -1, 2, -1, 2, -1, -1, -1, -1, -1, -1, 16, -1],
    [1'i8, -1, -1, -1, -1, -1, 2, -1, 2, -1, 2, -1, -1, -1, -1, -1, -1, 17, -1],
    [1'i8, -1, -1, -1, -1, -1, 2, -1, 2, -1, 2, -1, -1, -1, -1, -1, 18, 19, -1],
    [1'i8, -1, -1, -1, -1, -1, 2, -1, 2, -1, 2, -1, -1, -1, -1, -1, -1, 19, -1],
    [1'i8, -1, -1, -1, -1, -1, 2, -1, 2, -1, 2, 14, -1, -1, 15, 20, 18, -1, -1],
    [1'i8, 2, -1, -1, -1, -1, 2, -1, 2, -1, 2, -1, -1, -1, -1, -1, -1, -1, -1],
    [1'i8, 21, 10, 10, 2, 2, 2, -1, 2, 22, 1, 14, -1, -1, 15, 20, 18, 17, 2],
    [1'i8, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1],
    [1'i8, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, 23, -1, -1, -1, -1, -1],
    [1'i8, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]
  ]
  dfaBw = [
    [1'i8, 16, 3, 8, 5, 4, 19, 23, 17, 1, 18, 9, 22, 20, 10, 15, 14, 11, 2],
    [1'i8, -1, -1, -1, -1, -1, -1, -1, -1, 1, -1, -1, -1, -1, -1, -1, -1, -1, -1],
    [1'i8, -1, -1, -1, -1, -1, -1, -1, -1, 1, -1, -1, -1, -1, -1, -1, -1, -1, -1],
    [1'i8, -1, -1, -1, -1, -1, -1, -1, -1, 1, 1, -1, -1, -1, -1, -1, -1, -1, -1],
    [1'i8, -1, -1, -1, -1, -1, -1, -1, -1, 1, 1, -1, -1, -1, -1, -1, -1, -1, -1],
    [1'i8, -1, 6, 1, -1, -1, -1, -1, 7, 1, -1, -1, -1, -1, -1, -1, -1, -1, -1],
    [1'i8, -1, -1, -1, -1, -1, -1, -1, -1, 1, 1, -1, -1, -1, -1, -1, -1, -1, -1],
    [-1'i8, -1, 6, 1, -1, -1, -1, -1, 7, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1],
    [1'i8, -1, -1, -1, -1, -1, -1, -1, -1, 1, -1, -1, -1, -1, -1, -1, -1, -1, -1],
    [1'i8, -1, -1, -1, -1, -1, -1, -1, -1, 1, -1, -1, -1, -1, -1, 9, -1, -1, -1],
    [1'i8, -1, -1, -1, -1, -1, -1, -1, -1, 1, -1, -1, -1, -1, -1, 10, -1, -1, -1],
    [1'i8, -1, -1, -1, -1, -1, -1, -1, -1, 1, -1, 9, -1, -1, 10, -1, 12, 11, -1],
    [1'i8, -1, -1, -1, -1, -1, -1, -1, -1, 1, -1, -1, -1, -1, 10, 13, 12, -1, -1],
    [1'i8, -1, -1, -1, -1, -1, -1, -1, -1, 1, -1, -1, -1, -1, -1, 13, -1, -1, -1],
    [1'i8, -1, -1, -1, -1, -1, -1, -1, -1, 1, -1, -1, -1, -1, 10, 13, 12, -1, -1],
    [1'i8, -1, -1, -1, -1, -1, -1, -1, -1, 1, -1, -1, -1, -1, -1, 15, -1, -1, -1],
    [1'i8, 1, -1, -1, -1, -1, -1, -1, -1, 1, -1, -1, -1, -1, -1, -1, -1, -1, -1],
    [1'i8, 16, 3, 1, 5, 3, 17, -1, 17, 1, 17, 9, -1, -1, 10, 15, 12, 11, 1],
    [1'i8, 16, 3, 1, 5, 3, 17, -1, 17, 1, 17, 9, -1, -1, 10, 15, 12, 11, 1],
    [1'i8, 16, 3, 1, 5, 3, 17, -1, 17, 1, 17, 9, -1, -1, 10, 15, 12, 11, 1],
    [1'i8, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, 21, -1, -1, -1, -1, -1, -1],
    [1'i8, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1],
    [1'i8, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1],
    [1'i8, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]
  ]

iterator graphemes*(s: string): string {.inline.} =
  ## Iterates over any grapheme (i.e user perceived character)
  ## of the string text returning graphemes
  var
    state = dfa[0]
    r: Rune
    a, b, n = 0
  while n < s.len or a < b:
    while n < s.len:
      fastRuneAt(s, n, r, true)
      let
        t = graphemeType(r)
        nxt = state[t]
      if nxt == -1:
        assert state[0] == 1
        state = dfa[dfa[0][t]]
        break
      b = n
      state = dfa[nxt]
    assert b > a
    yield s[a ..< b]
    a = b
    b = n

proc graphemes*(s: string): seq[string] =
  ## Return a sequence containing the graphemes in text
  result = newSeqOfCap[string](s.len)
  for c in graphemes(s):
    result.add(c)

proc bwRuneAt(s: string, n: var int, r: var Rune) =
  ## Take rune ending at ``n`` and
  ## decrece ``n`` by the bytes of the Rune.
  ## Ends when ``n`` reaches ``-1``
  while n > 0 and s[n].ord shr 6 == 0b10:
    dec n
  fastRuneAt(s, n, r, false)
  dec n

const riType = 1

template breakRi() {.dirty.} =
  ## Needed when going backwards only.
  ## Break a Regional Indicator (RI)
  ## if there's an even number of
  ## following RI.
  ## We need to do this ad-hoc, 'cause
  ## the DFA doesn't support assertions.
  ## Regex: (?:RI (?<=(?:RI RI)+))
  assert t == riType
  assert state[0] == 1
  ri = 0
  while n >= 0:
    bwRuneAt(s, n, r)
    if graphemeType(r) != riType:
      break
    inc ri
  n = nn
  if ri > 0 and ri mod 2 == 0:
    assert n >= 0
    bwRuneAt(s, n, r)
    break

iterator graphemesReversed*(s: string): string {.inline.} =
  ## Iterates in reverse order
  ## over any grapheme (i.e user perceived character)
  ## of the string text returning graphemes
  var
    state = dfaBw[0]
    t, nxt, ri = 0
    r: Rune
    a, b, n, nn = s.len-1
  while n >= 0 or a < b:
    while n >= 0:
      if state[0] == 1:  # safe break
        nn = n
      if t == riType:
        breakRi()
      bwRuneAt(s, n, r)
      t = graphemeType(r)
      nxt = state[t]
      if nxt == -1:
        break
      a = n
      state = dfaBw[nxt]
    # dead end, backtrack to safe break
    if state[0] == -1 and n != nn:
      a = nn
      n = nn
      bwRuneAt(s, n, r)
      t = graphemeType(r)
    state = dfaBw[dfaBw[0][t]]
    assert a < b
    yield s[a+1 .. b]
    b = a
    a = n

proc graphemesReversed*(s: string): seq[string] =
  ## Return a sequence containing the graphemes in text
  result = newSeqOfCap[string](s.len)
  for c in graphemesReversed(s):
    result.add(c)

proc graphemeLenAt*(s: string, i: Natural): int =
  ## Return the number of bytes the
  ## grapheme starting at ``s[i]`` takes
  result = i
  var
    state = dfa[0]
    r: Rune
    n = i
    nxt = 0
  while n < len(s):
    fastRuneAt(s, n, r, true)
    nxt = state[graphemeType(r)]
    if nxt == -1: break
    state = dfa[nxt]
    result = n
  dec(result, i)

proc graphemeLenAt*(s: string, i: BackwardsIndex): int =
  ## Return the number of bytes the
  ## grapheme ending at ``s[^i]`` takes
  assert i.int > 0
  result = len(s) - i.int
  var
    state = dfaBw[0]
    r: Rune
    n, nn = result
    t, nxt, ri = 0
  while n >= 0:
    if state[0] == 1:  # safe break
      nn = n
    if t == riType:
      breakRi()
    bwRuneAt(s, n, r)
    t = graphemeType(r)
    nxt = state[t]
    if nxt == -1: break
    state = dfaBw[nxt]
    result = n
  if state[0] == -1:
    result = nn
  result = len(s) - i.int - result

proc graphemesCount*(s: string): int =
  ## Return the number of graphemes in ``s``
  result = 0
  var n = 0
  while n < len(s):
    inc(n, graphemeLenAt(s, n))
    inc result
