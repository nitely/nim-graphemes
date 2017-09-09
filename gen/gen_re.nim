import strutils

const unicodeVersion* = "10.0.0"
const specVersion* = "29"
const specURL* = "http://www.unicode.org/reports/tr29/"

# All identifiers must be replaced by single
# characters in order to build the actual regex expression
const pattern =
  "(?:" &
  "CR LF | " &
  "(?:Control | CR | LF) | " &
  "(?:Prepend* " &
  "(?:" &
  "(?:L* V+ T* | L* LV V* T* | L* LVT T* | L+ | T+) | " &
  "(?:(?:E_Base | E_Base_GAZ) Extend* E_Modifier | " &
  "ZWJ (?:Glue_After_Zwj | E_Base_GAZ Extend* E_Modifier?)) | " &
  "Regional_Indicator Regional_Indicator? | " &
  "(?: L | V | T | LV | LVT | E_Base | E_Modifier | Glue_After_Zwj | E_Base_GAZ | Any )" &  # Anything
  ")? " &
  ")? " &  # Prepend end
  "(?:SpacingMark | Extend | ZWJ)* " &
  ")"

# IDs must be in non-overlapping substring order (i.e longest to shortest)
const identifiers* = [
  "__EOF__",  # Reserved for the DFA
  "Regional_Indicator",
  "E_Base_GAZ",
  "E_Base",
  "E_Modifier",
  "Glue_After_Zwj",
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
for c in 'a'..'z':
  letters.add(c)

proc buildRePattern*(): string =
  assert len(identifiers) <= len(letters)
  result = pattern

  for i, id in identifiers:
    result = replace(result, id, "" & letters[i])

  result = replace(result, " ")

when isMainModule:
  echo buildRePattern()
