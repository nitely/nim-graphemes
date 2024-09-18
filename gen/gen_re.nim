import std/strutils

const
  unicodeVersion* = "16.0.0"
  specVersion* = "29"
  specURL* = "http://www.unicode.org/reports/tr29/"

# The regex is constructed from:
# crlf | Control | precore* core postcore*
# Note: [^Control CR LF] is Any
# Links:
# https://www.unicode.org/reports/tr29/tr29-45.html#Table_Combining_Char_Sequences_and_Grapheme_Clusters
# https://www.unicode.org/reports/tr29/tr29-45.html#Regex_Definitions
const pattern =
  """
  (CR LF | CR | LF) | Control
  | Prepend*
  (
    (L* (V+ | LV V* | LVT) T* | L+ | T+)
    | (RI RI)
    | (Extended_Pictographic (Extend* ZWJ Extended_Pictographic)*)
    | (InCB_Consonant ((InCB_Extend | InCB_Linker)* InCB_Linker (InCB_Extend | InCB_Linker)* InCB_Consonant)+)
    | (RI | Any | InCB_Consonant | InCB_Linker | InCB_Extend | Prepend | Extend | ZWJ | SpacingMark)
  )
  (Extend | ZWJ | SpacingMark)*
  """

# This is from unicode 12, crafted by me before it was part of their docs.
# Keep it because it's easier to understand.
# [^Control CR LF]: Any ...
const patternOld {.used.} =
  """
  (
    CR LF
    | (Control | CR | LF)
    | Prepend*
    (
      (L* (V+ | LV V* | LVT) T* | L+ | T+)
      | RI RI
      | Extended_Pictographic (Extend* ZWJ Extended_Pictographic)*
      | (Prepend | Any | RI | Extend | ZWJ | SpacingMark)
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
      | RI RI
      | (Extended_Pictographic ZWJ Extend*)* Extended_Pictographic
      | (Prepend | Any | RI | Extend | ZWJ | SpacingMark)
    )
    Prepend*
  )
  """

# IDs must be in non-overlapping substring order (i.e longest to shortest)
const identifiers* = [
  "__EOF__",  # Reserved for the DFA
  "RI",
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
