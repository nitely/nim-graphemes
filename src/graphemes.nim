from unicode import nil
from algorithm import binarySearch

from grapheme_break import GraphemeBreakPoints, GraphemeBreakTypes

# Auto generated with github@nitely/regexy
# See ../gen/gen_re.nim for the original regex
var DFA = [
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

const GBAnyType = 18

iterator graphemes*(text: string): string =
  var curr_state = DFA[0]
  var captured = ""

  for cp in unicode.runes(text):
    var cp_index = binarySearch(GraphemeBreakPoints, int(cp))
    var cp_type = if cp_index >= 0: GraphemeBreakTypes[cp_index] else: GBAnyType

    if curr_state[cp_type] >= 0:
        captured.add(unicode.toUTF8(cp))
        curr_state = DFA[curr_state[cp_type]]
        continue
    # else break grapheme

    if len(captured) > 0:
        yield captured
        captured = ""

    if DFA[0][cp_type] >= 0:
        captured.add(unicode.toUTF8(cp))
        curr_state = DFA[DFA[0][cp_type]]
        continue

    yield unicode.toUTF8(cp)
    curr_state = DFA[0]

  if len(captured) > 0:
      yield captured

proc graphemes*(text: string): seq[string] =
  result = @[]
  for c in graphemes(text):
    result.add(c)
