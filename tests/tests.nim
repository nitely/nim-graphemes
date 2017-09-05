import unittest, strutils, unicode
import graphemes

test "Graphemes test file":
  var i = 0

  for line in lines("./tests/GraphemeBreakTest.txt"):
    var text = line.split("#", 1)[0]

    if len(text.strip()) == 0:
      continue

    var graphemesFromTest: seq[string] = @[]

    for ch1 in text.split("÷"):
      if len(ch1.strip()) == 0:
        continue

      var grapheme = ""

      for ch2 in ch1.split("×"):
        if len(ch2.strip()) > 0:
          grapheme.add(unicode.toUTF8(unicode.Rune(parseHexInt(ch2.strip()))))

      graphemesFromTest.add(grapheme)

    check(graphemes(join(graphemesFromTest)) == graphemesFromTest)
    inc i

  echo "$# grapehemes tested" % [$i]
