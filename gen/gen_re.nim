import strutils

const
  unicodeVersion* = "11.0.0"
  specVersion* = "29"
  specURL* = "http://www.unicode.org/reports/tr29/"

# All identifiers must be replaced by single
# characters in order to build the actual regex expression.
# *These regexes were manually crafted* based on the spec!
const pattern =
  "(?:" &
    "CR LF | " &
    "(?:Control | CR | LF) | " &
    "(?:Prepend* " &
      "(?:" &
        "(?:L* V+ T* | L* LV V* T* | L* LVT T* | L+ | T+) | " &
        "(?:Extended_Pictographic (?:Extend* ZWJ Extended_Pictographic)+) | " &
        "Regional_Indicator Regional_Indicator? | " &
        "(?: L | V | T | LV | LVT | Extended_Pictographic | Any )" &  # Anything
      ")? " &
    ")? (?:SpacingMark | Extend | ZWJ)* " &
  ")"

# For backward matching (i.e: reverse iterator, etc)
const patternReversed =
  "(?:" &
    "LF CR | " &
    "(?:Control | CR | LF) | " &
    "(?:SpacingMark | Extend | ZWJ)* (?:" &
      "(?:" &
        "(?:T* V+ L* | T* V* LV L* | T* LVT L* | L+ | T+) | " &
        "(?:(?:Extended_Pictographic ZWJ Extend*)+ Extended_Pictographic) | " &
        "Regional_Indicator Regional_Indicator? | " &
        "(?: L | V | T | LV | LVT | Extended_Pictographic | Any )" &
      ")? " &
    "Prepend*)? " &
  ")"

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

  for i, id in identifiers:
    result = replace(result, id, "" & letters[i])

  result = replace(result, " ")

when isMainModule:
  echo "pattern:"
  echo buildRePattern(pattern)
  echo "patternReversed:"
  echo buildRePattern(patternReversed)
