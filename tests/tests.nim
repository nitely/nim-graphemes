import unittest, strutils, unicode, tables
import graphemes
from graphemes/private/grapheme_break import graphemeType
from ../gen/gen_grapheme_break import nil

test "Test graphemes break":
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

test "Test generated tables":
  var
    data = gen_grapheme_break.parse("./gen/GraphemeBreakProperty.txt")
    i = 0
  for cp, tcp in data:
    check(graphemeType(cp) == tcp)
    inc i
  echo "$# code-points tested" % [$i]

test "Test graphemeLenAt":
  check(graphemeLenAt("abc", 0) == 1)
  check(graphemeLenAt("abc", 1) == 1)
  check(graphemeLenAt("abc", 2) == 1)
  check(graphemeLenAt("abc", 123) == 0)
  check(graphemeLenAt("u̲", 0) == 3)
  check(graphemeLenAt("u̲n̲", 0) == 3)
  check(graphemeLenAt("u̲n̲", 3) == 3)
  check(len("\u0061\u200D") == 4)
  check(graphemeLenAt("\u0061\u200D", 0) == 4)
  check(len("\u0061\u200D\u200D") == 7)
  check(graphemeLenAt("\u0061\u200D\u200D", 0) == 7)
  check(len("\u0061\u0308") == 3)
  check(len("\u0061\u0308\u0062") == 4)
  check(graphemeLenAt("\u0061\u0308\u0062", 0) == 3)
  check(graphemeLenAt("\u0061\u0308\u0062", 3) == 1)
  check(graphemeLenAt("ю́", 0) == len("ю́"))

test "Test graphemesCount":
  check(graphemesCount("abc") == 3)
  check(graphemesCount("u̲") == 1)
  check(graphemesCount("u̲n̲") == 2)
  check(graphemesCount("\u0061\u200D") == 1)
  check(graphemesCount("\u0061\u200D\u200D") == 1)
  check(graphemesCount("\u0061\u0308\u0062") == 2)
  check(len("ю́".toRunes) == 2)
  check(graphemesCount("ю́") == 1)

# todo: fix!
test "Test emojis":
  # Emoji Version 1.0

  # 3 flags
  check(graphemesCount("🇺🇸🇨🇦🇩🇰") == 3)
  # 1 flag
  check(graphemesCount("🇦🇷") == 1)

  # Emoji Version 2.0

  # 6 families
  #check(graphemesCount("👪👨‍👧‍👧👩‍👩‍👧‍👦👨‍👨‍👦‍👦👨‍👧👩‍👦‍👦") == 6)
  # 1 family of 4
  #check(graphemesCount("👨‍👩‍👧‍👦") == 1)
  # 6 hands with skin tone
  check(graphemesCount("👋👋🏻👋🏼👋🏽👋🏾👋🏿") == 6)
  # 1 hand with skin tone
  check(graphemesCount("👋🏽") == 1)

  # Emoji Version 4.0

  # Man Health Worker
  #check(graphemesCount("👨‍⚕️") == 1)

  # Emoji Version 5.0

  # Man Vampire: Light Skin Tone
  #check(graphemesCount("🧛🏻‍♂️") == 1)

  # Emoji Version 11.0

  # Pirate Flag
  #check(graphemesCount("🏴‍☠️") == 1)
