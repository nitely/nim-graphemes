## This module provides support to
## handle unicode extended grapheme clusters,
## as in "user perceived characters".

import unicode

import graphemes/grapheme_break

# Auto generated with github@nitely/regexy
# See ../gen/gen_re.nim for the original regex
const
  dfa = [
    [1'i8, 14, 5, 3, 18, 2, 15, 1, 7, 17, 16, 8, 13, 11, 10, 4],
    [1'i8, -1, -1, 1, -1, 1, -1, 1, -1, -1, -1, -1, -1, -1, -1, -1],
    [1'i8, -1, -1, 1, -1, 1, -1, 1, -1, -1, -1, -1, -1, -1, -1, -1],
    [1'i8, -1, -1, 1, -1, 1, -1, 1, -1, -1, -1, -1, -1, -1, -1, -1],
    [1'i8, -1, -1, 1, -1, 1, -1, 1, -1, -1, -1, -1, -1, -1, -1, -1],
    [1'i8, -1, -1, 1, -1, 5, -1, 6, -1, -1, -1, -1, -1, -1, -1, -1],
    [1'i8, -1, 5, 1, -1, 1, -1, 1, -1, -1, -1, -1, -1, -1, -1, -1],
    [1'i8, -1, -1, 1, -1, 1, -1, 1, -1, -1, -1, -1, -1, -1, 7, -1],
    [1'i8, -1, -1, 1, -1, 1, -1, 1, -1, -1, -1, -1, -1, 8, 9, -1],
    [1'i8, -1, -1, 1, -1, 1, -1, 1, -1, -1, -1, -1, -1, -1, 9, -1],
    [1'i8, -1, -1, 1, -1, 1, -1, 1, -1, -1, -1, -1, -1, -1, 10, -1],
    [1'i8, -1, -1, 1, -1, 1, -1, 1, -1, -1, -1, -1, -1, 11, 12, -1],
    [1'i8, -1, -1, 1, -1, 1, -1, 1, -1, -1, -1, -1, -1, -1, 12, -1],
    [1'i8, -1, -1, 1, -1, 1, -1, 1, 7, -1, -1, 8, 13, 11, -1, -1],
    [1'i8, 1, -1, 1, -1, 1, -1, 1, -1, -1, -1, -1, -1, -1, -1, -1],
    [1'i8, 14, 5, 1, -1, 1, 15, 1, 7, -1, -1, 8, 13, 11, 10, 1],
    [1'i8, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1],
    [1'i8, -1, -1, -1, -1, -1, -1, -1, -1, -1, 16, -1, -1, -1, -1, -1],
    [1'i8, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]
  ]
  dfaBw = [
    [1'i8, 12, 3, 15, 19, 14, 1, 13, 5, 18, 16, 6, 11, 10, 7, 2],
    [1'i8, -1, -1, -1, -1, -1, 1, -1, -1, -1, -1, -1, -1, -1, -1, -1],
    [1'i8, -1, -1, -1, -1, -1, 1, -1, -1, -1, -1, -1, -1, -1, -1, -1],
    [1'i8, -1, -1, -1, -1, -1, 1, 4, -1, -1, -1, -1, -1, -1, -1, -1],
    [-1'i8, -1, 3, -1, -1, 4, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1],
    [1'i8, -1, -1, -1, -1, -1, 1, -1, -1, -1, -1, -1, 5, -1, -1, -1],
    [1'i8, -1, -1, -1, -1, -1, 1, -1, -1, -1, -1, -1, 6, -1, -1, -1],
    [1'i8, -1, -1, -1, -1, -1, 1, -1, 5, -1, -1, 6, -1, 8, 7, -1],
    [1'i8, -1, -1, -1, -1, -1, 1, -1, -1, -1, -1, 6, 9, 8, -1, -1],
    [1'i8, -1, -1, -1, -1, -1, 1, -1, -1, -1, -1, -1, 9, -1, -1, -1],
    [1'i8, -1, -1, -1, -1, -1, 1, -1, -1, -1, -1, 6, 9, 8, -1, -1],
    [1'i8, -1, -1, -1, -1, -1, 1, -1, -1, -1, -1, -1, 11, -1, -1, -1],
    [1'i8, 1, -1, -1, -1, -1, 1, -1, -1, -1, -1, -1, -1, -1, -1, -1],
    [1'i8, 12, 3, 13, -1, 13, 1, 13, 5, -1, -1, 6, 11, 8, 7, 1],
    [1'i8, 12, 3, 13, -1, 13, 1, 13, 5, -1, -1, 6, 11, 8, 7, 1],
    [1'i8, 12, 3, 13, -1, 13, 1, 13, 5, -1, -1, 6, 11, 8, 7, 1],
    [1'i8, -1, -1, -1, -1, -1, -1, -1, -1, 17, -1, -1, -1, -1, -1, -1],
    [1'i8, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1],
    [1'i8, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1],
    [1'i8, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]
  ]

iterator graphemesImpl(s: string): Slice[int] {.inline.} =
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
    yield a ..< b
    a = b
    b = n

iterator graphemes*(s: string): string {.inline.} =
  ## Iterate ``s`` returning graphemes
  for slc in s.graphemesImpl():
    yield s[slc]

proc graphemes*(s: string): seq[string] =
  ## Return a sequence of graphemes from ``s``
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
  ## Iterate ``s`` returning the graphemes in reverse order
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
  ## Return a sequence of graphemes from ``s`` in reverse order
  result = newSeqOfCap[string](s.len)
  for c in graphemesReversed(s):
    result.add(c)

proc graphemeLenAt*(s: string, i: Natural): int =
  ## Return the number of bytes in the
  ## grapheme starting at ``s[i]``
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
  ## Return the number of bytes in the
  ## grapheme ending at ``s[^i]``
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
  for _ in s.graphemesImpl():
    inc result

proc graphemesSubStr*(
  s: string, first: int, last = int.high
): string =
  ## Return the sub-string
  ## starting at the ``first`` grapheme and
  ## ending at the ``last`` grapheme. Return
  ## from ``first`` to the end of the string,
  ## if ``last`` is not provided. Beware this
  ## function always iterates from the start
  ## of the string to get to the ``first`` grapheme.
  if last < first:
    return ""
  var
    i = s.len
    j = s.len-1
    count = 0
  for slc in s.graphemesImpl():
    if count == first:
      i = slc.a
      if last == int.high:
        break
    if count == last:
      j = slc.b
      break
    inc count
  return s[i .. j]
