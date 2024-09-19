## This module provides support to
## handle unicode extended grapheme clusters,
## as in "user perceived characters".

import std/unicode
import std/algorithm

import ./graphemes/grapheme_break

# Auto generated with github@nitely/regexy
# See ../gen/gen_re.nim for the original regex
const
  dfa = [
    [-1'i8, 23, 20, 18, 19, 1, 29, 3, 4, 2, 26, 31, 30, 27, 22, 25, 28, 24, 21],
    [0'i8, -1, -1, 1, 1, 1, -1, 1, -1, 1, -1, -1, -1, -1, -1, -1, -1, -1, -1],
    [0'i8, -1, -1, 1, 1, 1, -1, 1, -1, 1, -1, -1, -1, -1, -1, -1, -1, -1, -1],
    [0'i8, -1, -1, 1, 1, 1, -1, 1, -1, 1, -1, -1, -1, -1, -1, -1, -1, -1, -1],
    [0'i8, 8, 5, 1, 1, 1, -1, 1, 4, 1, 15, -1, -1, 16, 7, 11, 17, 10, 1],
    [0'i8, -1, -1, 5, 6, 1, -1, 1, -1, 5, -1, -1, -1, -1, -1, -1, -1, -1, -1],
    [0'i8, -1, 5, 6, 6, 1, -1, 1, -1, 6, -1, -1, -1, -1, -1, -1, -1, -1, -1],
    [0'i8, -1, -1, 1, 1, 1, -1, 1, -1, 1, -1, -1, -1, -1, 1, -1, -1, -1, -1],
    [0'i8, -1, -1, 8, 8, 1, -1, 8, -1, 9, -1, -1, -1, -1, -1, -1, -1, -1, -1],
    [0'i8, 8, -1, 1, 1, 1, -1, 1, -1, 1, -1, -1, -1, -1, -1, -1, -1, -1, -1],
    [0'i8, -1, -1, 1, 1, 1, -1, 1, -1, 1, -1, -1, -1, -1, -1, -1, -1, 10, -1],
    [0'i8, -1, -1, 1, 1, 1, -1, 1, -1, 1, 12, -1, -1, 13, -1, 11, 14, -1, -1],
    [0'i8, -1, -1, 1, 1, 1, -1, 1, -1, 1, -1, -1, -1, -1, -1, -1, -1, 12, -1],
    [0'i8, -1, -1, 1, 1, 1, -1, 1, -1, 1, -1, -1, -1, -1, -1, -1, 13, 12, -1],
    [0'i8, -1, -1, 1, 1, 1, -1, 1, -1, 1, -1, -1, -1, -1, -1, -1, 14, 12, -1],
    [0'i8, -1, -1, 1, 1, 1, -1, 1, -1, 1, -1, -1, -1, -1, -1, -1, -1, 12, -1],
    [0'i8, -1, -1, 1, 1, 1, -1, 1, -1, 1, -1, -1, -1, -1, -1, -1, 13, 12, -1],
    [0'i8, -1, -1, 1, 1, 1, -1, 1, -1, 1, -1, -1, -1, -1, -1, -1, 14, 12, -1],
    [0'i8, -1, -1, 1, 1, 1, -1, 1, -1, 1, -1, -1, -1, -1, -1, -1, -1, -1, -1],
    [0'i8, -1, -1, 1, 1, 1, -1, 1, -1, 1, -1, -1, -1, -1, -1, -1, -1, -1, -1],
    [0'i8, -1, -1, 5, 6, 1, -1, 1, -1, 5, -1, -1, -1, -1, -1, -1, -1, -1, -1],
    [0'i8, -1, -1, 1, 1, 1, -1, 1, -1, 1, -1, -1, -1, -1, -1, -1, -1, -1, -1],
    [0'i8, -1, -1, 1, 1, 1, -1, 1, -1, 1, -1, -1, -1, -1, 1, -1, -1, -1, -1],
    [0'i8, -1, -1, 8, 8, 1, -1, 8, -1, 9, -1, -1, -1, -1, -1, -1, -1, -1, -1],
    [0'i8, -1, -1, 1, 1, 1, -1, 1, -1, 1, -1, -1, -1, -1, -1, -1, -1, 10, -1],
    [0'i8, -1, -1, 1, 1, 1, -1, 1, -1, 1, 12, -1, -1, 13, -1, 11, 14, -1, -1],
    [0'i8, -1, -1, 1, 1, 1, -1, 1, -1, 1, -1, -1, -1, -1, -1, -1, -1, 12, -1],
    [0'i8, -1, -1, 1, 1, 1, -1, 1, -1, 1, -1, -1, -1, -1, -1, -1, 13, 12, -1],
    [0'i8, -1, -1, 1, 1, 1, -1, 1, -1, 1, -1, -1, -1, -1, -1, -1, 14, 12, -1],
    [0'i8, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1],
    [0'i8, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1],
    [0'i8, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, 29, -1, -1, -1, -1, -1, -1]
  ]
  dfaBw = [
    [-1'i8, 27, 24, 22, 23, 1, 33, 20, 21, 19, 30, 35, 34, 31, 26, 29, 32, 28, 25],
    [0'i8, 9, 3, 1, 1, 1, -1, 1, 2, 1, 16, -1, -1, 17, 8, 15, 18, 11, 7],
    [0'i8, -1, -1, -1, -1, -1, -1, -1, 2, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1],
    [0'i8, -1, -1, 6, 4, -1, -1, -1, 2, 5, -1, -1, -1, -1, -1, -1, -1, -1, -1],
    [-1'i8, -1, 3, 4, 4, -1, -1, -1, -1, 4, -1, -1, -1, -1, -1, -1, -1, -1, -1],
    [-1'i8, -1, -1, 5, 4, -1, -1, -1, -1, 5, -1, -1, -1, -1, -1, -1, -1, -1, -1],
    [-1'i8, -1, -1, 5, 4, -1, -1, -1, -1, 5, -1, -1, -1, -1, -1, -1, -1, -1, -1],
    [0'i8, -1, -1, -1, -1, -1, -1, -1, 2, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1],
    [0'i8, -1, -1, -1, -1, -1, -1, -1, 2, -1, -1, -1, -1, -1, 2, -1, -1, -1, -1],
    [0'i8, -1, -1, -1, -1, -1, -1, -1, 2, 10, -1, -1, -1, -1, -1, -1, -1, -1, -1],
    [-1'i8, 9, -1, 10, 10, -1, -1, 10, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1],
    [0'i8, -1, -1, -1, -1, -1, -1, -1, 2, -1, 12, -1, -1, 13, -1, -1, 14, 11, -1],
    [0'i8, -1, -1, -1, -1, -1, -1, -1, 2, -1, -1, -1, -1, -1, -1, 12, -1, -1, -1],
    [0'i8, -1, -1, -1, -1, -1, -1, -1, 2, -1, -1, -1, -1, -1, -1, 12, -1, -1, -1],
    [0'i8, -1, -1, -1, -1, -1, -1, -1, 2, -1, -1, -1, -1, 12, -1, 12, 14, -1, -1],
    [0'i8, -1, -1, -1, -1, -1, -1, -1, 2, -1, -1, -1, -1, -1, -1, 15, -1, -1, -1],
    [0'i8, -1, -1, -1, -1, -1, -1, -1, 2, -1, -1, -1, -1, -1, -1, 12, -1, -1, -1],
    [0'i8, -1, -1, -1, -1, -1, -1, -1, 2, -1, -1, -1, -1, -1, -1, 12, -1, -1, -1],
    [0'i8, -1, -1, -1, -1, -1, -1, -1, 2, -1, -1, -1, -1, 12, -1, 12, 14, -1, -1],
    [0'i8, 9, 3, 1, 1, 1, -1, 1, 2, 1, 12, -1, -1, 12, 8, 15, 14, 11, 2],
    [0'i8, 9, 3, 1, 1, 1, -1, 1, 2, 1, 12, -1, -1, 12, 8, 15, 14, 11, 2],
    [0'i8, -1, -1, -1, -1, -1, -1, -1, 2, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1],
    [0'i8, 9, 3, 1, 1, 1, -1, 1, 2, 1, 12, -1, -1, 12, 8, 15, 14, 11, 2],
    [0'i8, 9, 3, 1, 1, 1, -1, 1, 2, 1, 12, -1, -1, 12, 8, 15, 14, 11, 2],
    [0'i8, -1, -1, 5, 4, -1, -1, -1, 2, 5, -1, -1, -1, -1, -1, -1, -1, -1, -1],
    [0'i8, -1, -1, -1, -1, -1, -1, -1, 2, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1],
    [0'i8, -1, -1, -1, -1, -1, -1, -1, 2, -1, -1, -1, -1, -1, 2, -1, -1, -1, -1],
    [0'i8, -1, -1, -1, -1, -1, -1, -1, 2, 10, -1, -1, -1, -1, -1, -1, -1, -1, -1],
    [0'i8, -1, -1, -1, -1, -1, -1, -1, 2, -1, 12, -1, -1, 12, -1, -1, 14, 11, -1],
    [0'i8, -1, -1, -1, -1, -1, -1, -1, 2, -1, -1, -1, -1, -1, -1, 15, -1, -1, -1],
    [0'i8, -1, -1, -1, -1, -1, -1, -1, 2, -1, -1, -1, -1, -1, -1, 12, -1, -1, -1],
    [0'i8, -1, -1, -1, -1, -1, -1, -1, 2, -1, -1, -1, -1, -1, -1, 12, -1, -1, -1],
    [0'i8, -1, -1, -1, -1, -1, -1, -1, 2, -1, -1, -1, -1, 12, -1, 12, 14, -1, -1],
    [0'i8, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1],
    [0'i8, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, 33, -1, -1, -1, -1, -1, -1, -1],
    [0'i8, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]
  ]

iterator graphemeBounds*(s: string): Slice[int] {.inline, raises: [].} =
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

iterator graphemes*(s: string): string {.inline, raises: [].} =
  ## Iterate ``s`` returning graphemes
  for slc in s.graphemeBounds:
    yield s[slc]

proc graphemes*(s: string): seq[string] {.raises: [].} =
  ## Return the grapheme sequence of ``s``
  result = newSeqOfCap[string](s.len)
  for c in graphemes(s):
    result.add(c)

proc bwRuneAt(s: string, n: var int, r: var Rune) {.raises: [].} =
  ## Take rune ending at ``n`` and
  ## decrece ``n`` by the bytes of the Rune.
  ## Ends when ``n`` reaches ``-1``
  while n > 0 and s[n].ord shr 6 == 0b10:
    dec n
  fastRuneAt(s, n, r, false)
  dec n

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

iterator graphemeBoundsReversed*(s: string): Slice[int] {.inline, raises: [].} =
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

iterator graphemesReversed*(s: string): string {.inline, raises: [].} =
  ## Return graphemes of `s` in reverse order
  for bounds in s.graphemeBoundsReversed:
    yield s[bounds]

proc graphemesReversed*(s: string): seq[string] {.raises: [].} =
  ## Return the grapheme sequence of ``s`` in reverse order
  result = newSeqOfCap[string](s.len)
  for c in graphemesReversed(s):
    result.add(c)

func graphemesReverse*(s: var string) {.raises: [].} =
  ## Reverse graphemes of `s` in-place
  for bounds in s.graphemeBoundsReversed:
    s.reverse(bounds.a, bounds.b)
  s.reverse

proc graphemeLenAt*(s: string, i: Natural): int {.raises: [].} =
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

proc graphemeLenAt*(s: string, i: BackwardsIndex): int {.raises: [].} =
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

proc graphemesCount*(s: string): int {.raises: [].} =
  ## Return the number of graphemes in ``s``
  result = 0
  for _ in s.graphemeBounds:
    inc result

proc graphemesSubStr*(
  s: string, first: int, last = int.high
): string {.raises: [].} =
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

proc graphemesTruncate*(s: var string, limit: Natural, suffix = "") {.raises: [].} =
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

proc graphemesTruncateBytes*(s: var string, limit: Natural, suffix = "") {.raises: [].} =
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
