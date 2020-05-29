## This module provides support to
## handle unicode extended grapheme clusters,
## as in "user perceived characters".

import unicode
import algorithm

import graphemes/grapheme_break

# Auto generated with github@nitely/regexy
# See ../gen/gen_re.nim for the original regex
const
  dfa = [
    [-1'i8, 4, 17, 1, 25, 3, 6, 2, 20, 24, 23, 21, 19, 22, 18, 5],
    [0'i8, -1, -1, 1, -1, 1, -1, 1, -1, -1, -1, -1, -1, -1, -1, -1],
    [0'i8, -1, -1, 1, -1, 1, -1, 1, -1, -1, -1, -1, -1, -1, -1, -1],
    [0'i8, -1, -1, 1, -1, 1, -1, 1, -1, -1, -1, -1, -1, -1, -1, -1],
    [0'i8, 1, -1, 1, -1, 1, -1, 1, -1, -1, -1, -1, -1, -1, -1, -1],
    [0'i8, -1, -1, 1, -1, 1, -1, 1, -1, -1, -1, -1, -1, -1, -1, -1],
    [0'i8, 4, 7, 1, -1, 1, 6, 1, 14, -1, -1, 15, 10, 16, 9, 1],
    [0'i8, -1, -1, 1, -1, 7, -1, 8, -1, -1, -1, -1, -1, -1, -1, -1],
    [0'i8, -1, 7, 1, -1, 1, -1, 1, -1, -1, -1, -1, -1, -1, -1, -1],
    [0'i8, -1, -1, 1, -1, 1, -1, 1, -1, -1, -1, -1, -1, -1, 9, -1],
    [0'i8, -1, -1, 1, -1, 1, -1, 1, 11, -1, -1, 12, 10, 13, -1, -1],
    [0'i8, -1, -1, 1, -1, 1, -1, 1, -1, -1, -1, -1, -1, -1, 11, -1],
    [0'i8, -1, -1, 1, -1, 1, -1, 1, -1, -1, -1, -1, -1, 12, 11, -1],
    [0'i8, -1, -1, 1, -1, 1, -1, 1, -1, -1, -1, -1, -1, 13, 11, -1],
    [0'i8, -1, -1, 1, -1, 1, -1, 1, -1, -1, -1, -1, -1, -1, 11, -1],
    [0'i8, -1, -1, 1, -1, 1, -1, 1, -1, -1, -1, -1, -1, 12, 11, -1],
    [0'i8, -1, -1, 1, -1, 1, -1, 1, -1, -1, -1, -1, -1, 13, 11, -1],
    [0'i8, -1, -1, 1, -1, 7, -1, 8, -1, -1, -1, -1, -1, -1, -1, -1],
    [0'i8, -1, -1, 1, -1, 1, -1, 1, -1, -1, -1, -1, -1, -1, 9, -1],
    [0'i8, -1, -1, 1, -1, 1, -1, 1, 11, -1, -1, 12, 10, 13, -1, -1],
    [0'i8, -1, -1, 1, -1, 1, -1, 1, -1, -1, -1, -1, -1, -1, 11, -1],
    [0'i8, -1, -1, 1, -1, 1, -1, 1, -1, -1, -1, -1, -1, 12, 11, -1],
    [0'i8, -1, -1, 1, -1, 1, -1, 1, -1, -1, -1, -1, -1, 13, 11, -1],
    [0'i8, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1],
    [0'i8, -1, -1, -1, -1, -1, -1, -1, -1, -1, 23, -1, -1, -1, -1, -1],
    [0'i8, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]
  ]
  dfaBw = [
    [-1'i8, 17, 20, 1, 29, 16, 19, 15, 23, 28, 26, 24, 22, 25, 21, 18],
    [0'i8, 3, 5, 1, -1, 1, 2, 1, 12, -1, -1, 13, 11, 14, 7, 4],
    [0'i8, -1, -1, -1, -1, -1, 2, -1, -1, -1, -1, -1, -1, -1, -1, -1],
    [0'i8, 2, -1, -1, -1, -1, 2, -1, -1, -1, -1, -1, -1, -1, -1, -1],
    [0'i8, -1, -1, -1, -1, -1, 2, -1, -1, -1, -1, -1, -1, -1, -1, -1],
    [0'i8, -1, -1, -1, -1, -1, 2, 6, -1, -1, -1, -1, -1, -1, -1, -1],
    [-1'i8, -1, 5, -1, -1, 6, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1],
    [0'i8, -1, -1, -1, -1, -1, 2, -1, 8, -1, -1, 9, -1, 10, 7, -1],
    [0'i8, -1, -1, -1, -1, -1, 2, -1, -1, -1, -1, -1, 8, -1, -1, -1],
    [0'i8, -1, -1, -1, -1, -1, 2, -1, -1, -1, -1, -1, 8, -1, -1, -1],
    [0'i8, -1, -1, -1, -1, -1, 2, -1, -1, -1, -1, 8, 8, 10, -1, -1],
    [0'i8, -1, -1, -1, -1, -1, 2, -1, -1, -1, -1, -1, 11, -1, -1, -1],
    [0'i8, -1, -1, -1, -1, -1, 2, -1, -1, -1, -1, -1, 8, -1, -1, -1],
    [0'i8, -1, -1, -1, -1, -1, 2, -1, -1, -1, -1, -1, 8, -1, -1, -1],
    [0'i8, -1, -1, -1, -1, -1, 2, -1, -1, -1, -1, 8, 8, 10, -1, -1],
    [0'i8, 3, 5, 1, -1, 1, 2, 1, 8, -1, -1, 8, 11, 10, 7, 2],
    [0'i8, 3, 5, 1, -1, 1, 2, 1, 8, -1, -1, 8, 11, 10, 7, 2],
    [0'i8, 2, -1, -1, -1, -1, 2, -1, -1, -1, -1, -1, -1, -1, -1, -1],
    [0'i8, -1, -1, -1, -1, -1, 2, -1, -1, -1, -1, -1, -1, -1, -1, -1],
    [0'i8, -1, -1, -1, -1, -1, 2, -1, -1, -1, -1, -1, -1, -1, -1, -1],
    [0'i8, -1, -1, -1, -1, -1, 2, 6, -1, -1, -1, -1, -1, -1, -1, -1],
    [0'i8, -1, -1, -1, -1, -1, 2, -1, 8, -1, -1, 8, -1, 10, 7, -1],
    [0'i8, -1, -1, -1, -1, -1, 2, -1, -1, -1, -1, -1, 11, -1, -1, -1],
    [0'i8, -1, -1, -1, -1, -1, 2, -1, -1, -1, -1, -1, 8, -1, -1, -1],
    [0'i8, -1, -1, -1, -1, -1, 2, -1, -1, -1, -1, -1, 8, -1, -1, -1],
    [0'i8, -1, -1, -1, -1, -1, 2, -1, -1, -1, -1, 8, 8, 10, -1, -1],
    [0'i8, -1, -1, -1, -1, -1, -1, -1, -1, 27, -1, -1, -1, -1, -1, -1],
    [0'i8, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1],
    [0'i8, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1],
    [0'i8, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]
  ]

iterator graphemeBounds*(s: string): Slice[int] {.inline.} =
  ## Return grapheme boundaries in `s`.
  ## Boundaries are inclusive
  var
    r: Rune
    state, a, b, n = 0
  while n < s.len or a < b:
    while n < s.len:
      fastRuneAt(s, n, r, true)
      let
        t = graphemeType(r)
        next = dfa[state][t]
      if next == -1:
        doAssert dfa[state][0] == 0
        state = dfa[0][t]
        break
      b = n
      state = next
    doAssert b > a
    yield a ..< b
    a = b
    b = n

iterator graphemes*(s: string): string {.inline.} =
  ## Iterate ``s`` returning graphemes
  for slc in s.graphemeBounds:
    yield s[slc]

proc graphemes*(s: string): seq[string] =
  ## Return the grapheme sequence of ``s``
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

template breakRi(): untyped {.dirty.} =
  ## Needed when going backwards only.
  ## Break a Regional Indicator (RI)
  ## if there's an even number of
  ## following RI.
  ## We need to do this ad-hoc, 'cause
  ## the DFA doesn't support assertions.
  ## Regex: (?:RI (?<=(?:RI RI)+))
  doAssert t == riType
  doAssert dfaBw[state][0] == 0
  ri = 0
  while n >= 0:
    bwRuneAt(s, n, r)
    if graphemeType(r) != riType:
      break
    inc ri
  n = nn
  if ri > 0 and ri mod 2 == 0:
    doAssert n >= 0
    bwRuneAt(s, n, r)
    break

iterator graphemeBoundsReversed*(s: string): Slice[int] {.inline.} =
  ## Return grapheme boundaries of `s` in reverse order.
  ## Boundaries are inclusive
  var
    state, t, nxt, ri = 0
    r: Rune
    a, b, n, nn = s.len-1
  while n >= 0 or a < b:
    while n >= 0:
      if dfaBw[state][0] == 0:  # safe break
        nn = n
      if t == riType:
        breakRi()
      bwRuneAt(s, n, r)
      t = graphemeType(r)
      nxt = dfaBw[state][t]
      if nxt == -1:
        break
      a = n
      state = nxt
    # dead end, backtrack to safe break
    if dfaBw[state][0] == -1 and n != nn:
      a = nn
      n = nn
      bwRuneAt(s, n, r)
      t = graphemeType(r)
    state = dfaBw[0][t]
    doAssert a < b
    yield a+1 .. b
    b = a
    a = n

iterator graphemesReversed*(s: string): string {.inline.} =
  ## Return graphemes of `s` in reverse order
  for bounds in s.graphemeBoundsReversed:
    yield s[bounds]

proc graphemesReversed*(s: string): seq[string] =
  ## Return the grapheme sequence of ``s`` in reverse order
  result = newSeqOfCap[string](s.len)
  for c in graphemesReversed(s):
    result.add(c)

func graphemesReverse*(s: var string) {.inline.} =
  ## Reverse graphemes of `s` in-place
  for bounds in s.graphemeBoundsReversed:
    s.reverse(bounds.a, bounds.b)
  s.reverse

proc graphemeLenAt*(s: string, i: Natural): int =
  ## Return the number of bytes in the
  ## grapheme starting at ``s[i]``, where ``i`` is position in bytes,
  ## not graphemes, and doesn't respect grapheme boundaries
  result = i
  var
    r: Rune
    n = i
    state, nxt = 0
  while n < len(s):
    fastRuneAt(s, n, r, true)
    nxt = dfa[state][graphemeType(r)]
    if nxt == -1: break
    state = nxt
    result = n
  dec(result, i)

proc graphemeLenAt*(s: string, i: BackwardsIndex): int =
  ## Return the number of bytes in the
  ## grapheme ending at ``s[^i]``, where ``i`` is position in bytes,
  ## not graphemes, and doesn't respect grapheme boundaries
  doAssert i.int > 0
  result = len(s) - i.int
  var
    r: Rune
    n, nn = result
    state, t, nxt, ri = 0
  while n >= 0:
    if dfaBw[state][0] == 0:  # safe break
      nn = n
    if t == riType:
      breakRi()
    bwRuneAt(s, n, r)
    t = graphemeType(r)
    nxt = dfaBw[state][t]
    if nxt == -1: break
    state = nxt
    result = n
  if dfaBw[state][0] == -1:
    result = nn
  result = len(s) - i.int - result

proc graphemesCount*(s: string): int =
  ## Return the number of graphemes in ``s``
  result = 0
  for _ in s.graphemeBounds:
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
  for slc in s.graphemeBounds:
    if count == first:
      i = slc.a
      if last == int.high:
        break
    if count == last:
      j = slc.b
      break
    inc count
  return s[i .. j]

proc graphemesTruncate*(s: var string, limit: Natural, suffix = "") =
  ## Truncate a string to a given limit of graphems.
  ## This is a no-op if the string graphemes are
  ## lesser than/equal to the limit.
  ## The result is empty if there is not enough room for
  ## at least one grapheme + the suffix.
  ## The result is never larger than the limit.
  ## Beware arbitrary truncation may generate text
  ## or a word with an unintended meaning.
  runnableExamples:
    var s = "u̲n̲d̲e̲r̲l̲i̲n̲e̲d̲"
    graphemesTruncate(s, 8, "...")
    doAssert s == "u̲n̲d̲e̲r̲..."
  let size = max(0, limit - suffix.graphemesCount)
  var cut = 0
  var i = 0
  for bounds in s.graphemeBounds:
    if i > limit:
      break
    if i < size:
      cut = bounds.b+1
    inc i
  if i <= limit:
    return
  s.setLen cut
  if cut > 0:
    s.add suffix

proc graphemesTruncateBytes*(s: var string, limit: Natural, suffix = "") =
  ## Truncate a string to a given limit of bytes.
  ## This is a no-op if the string lenght is
  ## lesser than/equal to the limit.
  ## The result is empty if there is not enough room for
  ## at least one grapheme + the suffix.
  ## The result is never larger than the limit.
  ## Beware arbitrary truncation may generate text
  ## or a word with an unintended meaning.
  runnableExamples:
    var s = "u̲n̲d̲e̲r̲l̲i̲n̲e̲d̲"
    graphemesTruncateBytes(s, 20, "...")
    doAssert s == "u̲n̲d̲e̲r̲..."
    doAssert s.len == 18
  if s.len <= limit:
    return
  let size = max(0, limit - suffix.len)
  var cut = 0
  for bounds in s.graphemeBounds:
    if bounds.b+1 > size:
      break
    cut = bounds.b+1
  s.setLen cut
  if cut > 0:
    s.add suffix
