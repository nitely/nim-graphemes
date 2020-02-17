import strutils

const
  unicodeVersion* = "12.1.0"
  specVersion* = "29"
  specURL* = "http://www.unicode.org/reports/tr29/"

# From http://www.unicode.org/reports/tr29/#Table_Combining_Char_Sequences_and_Grapheme_Clusters
# [^Control CR LF]: Any ...
const pattern =
  """
  (
    CR LF
    | (Control | CR | LF)
    | Prepend*
    (
      (L* (V+ | LV V* | LVT) T* | L+ | T+)
      | Regional_Indicator Regional_Indicator
      | Extended_Pictographic (Extend* ZWJ Extended_Pictographic)*
      | (Prepend | Any | Regional_Indicator | Extend | ZWJ | SpacingMark)
    )
    (Extend | ZWJ | SpacingMark)*
  )
  """

# For backward matching (i.e: reverse iterator, etc)
const patternReversed =
  """
  (
    LF CR
    | (Control | CR | LF)
    | (Extend | ZWJ | SpacingMark)*
    (
      (T* (V+ | V* LV | LVT) L* | L+ | T+)
      | Regional_Indicator Regional_Indicator
      | (Extended_Pictographic ZWJ Extend*)* Extended_Pictographic
      | (Prepend | Any | Regional_Indicator | Extend | ZWJ | SpacingMark)
    )
    Prepend*
  )
  """

# IDs must be in non-overlapping substring order (i.e longest to shortest)
const identifiers* = [
  "__EOF__",  # Reserved for the DFA
  "Regional_Indicator",
  #"E_Base_GAZ",
  #"E_Base",
  #"E_Modifier",
  #"Glue_After_Zwj",
  "Extended_Pictographic",
  "SpacingMark",
  "Control",
  "Extend",
  "Prepend",
  "ZWJ",
  "LVT",
  "CR",
  "LF",
  "LV",
  "L",
  "V",
  "T",
  "Any"]

var letters* = ""
for c in 'a' .. 'z':
  letters.add(c)

proc buildRePattern*(p: string): string =
  assert len(identifiers) <= len(letters)
  result = p
  result = replace(result, "(", "(?:")
  for i, id in identifiers:
    result = replace(result, id, "" & letters[i])
  result = replace(result, " ")
  result = replace(result, "\p")
  result = replace(result, "\n")

when isMainModule:
  echo "pattern:"
  echo buildRePattern(pattern)
  echo "patternReversed:"
  echo buildRePattern(patternReversed)
