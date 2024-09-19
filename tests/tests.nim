import unittest
import strutils
import algorithm
import unicode except strip
import graphemes
from graphemes/grapheme_break import graphemeType
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
        if len(ch2.strip()) == 0:
          continue
        grapheme.add(unicode.toUTF8(unicode.Rune(parseHexInt(ch2.strip()))))
      graphemesFromTest.add(grapheme)
    check(graphemes(join(graphemesFromTest)) == graphemesFromTest)
    inc i
  check i == 1093

test "Test graphemes break in reverse":
  var i = 0
  for line in lines("./tests/GraphemeBreakTest.txt"):
    var text = line.split("#", 1)[0]
    if text.strip.len == 0:
      continue
    var graphemesFromTest = newSeq[string]()
    for ch1 in text.split("÷"):
      if ch1.strip.len == 0:
        continue
      var grapheme = ""
      for ch2 in ch1.split("×"):
        if ch2.strip.len == 0:
          continue
        grapheme.add(unicode.toUTF8(unicode.Rune(parseHexInt(ch2.strip()))))
      graphemesFromTest.add(grapheme)
    check graphemesFromTest.join.graphemesReversed == graphemesFromTest.reversed
    inc i
  check i == 1093

test "Test generated tables":
  var
    data = gen_grapheme_break.buildData()
    i = 0
  for cp, tcp in data:
    check(graphemeType(cp.Rune) == tcp)
    inc i
  check i == 1114112

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

test "Test graphemeLenAt backward index":
  check(graphemeLenAt("", ^1) == 0)
  check(graphemeLenAt("abc", ^1) == 1)
  check(graphemeLenAt("abc", ^2) == 1)
  check(graphemeLenAt("abc", ^3) == 1)
  check(graphemeLenAt("abc", ^123) == 0)
  check(graphemeLenAt("u̲", ^1) == 3)
  check(graphemeLenAt("u̲n̲", ^1) == 3)
  check(graphemeLenAt("u̲n̲", ^4) == 3)
  check(len("\u0061\u200D") == 4)
  check(graphemeLenAt("\u0061\u200D", ^1) == 4)
  check(len("\u0061\u200D\u200D") == 7)
  check(graphemeLenAt("\u0061\u200D\u200D", ^1) == 7)
  check(len("\u0061\u0308") == 3)
  check(len("\u0061\u0308\u0062") == 4)
  check(graphemeLenAt("\u0061\u0308\u0062", ^1) == 1)
  check(graphemeLenAt("\u0061\u0308\u0062", ^2) == 3)
  check(graphemeLenAt("ю́", ^1) == len("ю́"))
  block:
    var s = "u̲n̲d̲e̲r̲l̲i̲n̲e̲d̲"
    s.setLen(s.len - s.graphemeLenAt(^1))
    check s == "u̲n̲d̲e̲r̲l̲i̲n̲e̲"

test "Test graphemesCount":
  check(graphemesCount("abc") == 3)
  check(graphemesCount("u̲") == 1)
  check(graphemesCount("u̲n̲") == 2)
  check(graphemesCount("\u0061\u200D") == 1)
  check(graphemesCount("\u0061\u200D\u200D") == 1)
  check(graphemesCount("\u0061\u0308\u0062") == 2)
  check(len("ю́".toRunes) == 2)
  check(graphemesCount("ю́") == 1)
  check(graphemesCount("\r\L") == 1)

test "Test emojis":
  # Emoji Version 1.0

  # 3 flags
  check(graphemesCount("🇺🇸🇨🇦🇩🇰") == 3)
  # 1 flag
  check(graphemesCount("🇦🇷") == 1)

  # Emoji Version 2.0

  # 6 families
  check(graphemesCount("👪👨‍👧‍👧👩‍👩‍👧‍👦👨‍👨‍👦‍👦👨‍👧👩‍👦‍👦") == 6)
  # 1 family of 4
  check(graphemesCount("👨‍👩‍👧‍👦") == 1)
  # 6 hands with skin tone
  check(graphemesCount("👋👋🏻👋🏼👋🏽👋🏾👋🏿") == 6)
  # 1 hand with skin tone
  check(graphemesCount("👋🏽") == 1)

  # Emoji Version 3.0

  # Keycap Digit Nine
  check(graphemesCount("9️⃣") == 1)

  # Emoji Version 4.0

  # Man Health Worker
  check(graphemesCount("👨‍⚕️") == 1)

  # Emoji Version 5.0

  # Man Vampire: Light Skin Tone
  check(graphemesCount("🧛🏻‍♂️") == 1)

  # Emoji Version 11.0

  # Pirate Flag
  check(graphemesCount("🏴‍☠️") == 1)

  # Pride Flag (4 runes)
  check(graphemesCount("🏳️‍🌈") == 1)

  # Unicode 13
  check graphemesCount("🥸") == 1
  # Family + skin tone
  check graphemesCount("👨🏽‍👩🏽‍👧🏽‍👦🏽") == 1
  # 6 families with skin tone
  check graphemesCount("👨🏻‍👩🏻‍👧🏻‍👦🏻👨🏼‍👩🏼‍👧🏼‍👦🏼👨🏽‍👩🏽‍👧🏽‍👦🏽👨🏾‍👩🏾‍👧🏾‍👦🏾👨🏿‍👩🏿‍👧🏿‍👦🏿") == 5

test "Test grapheme iterator":
  let expected = [
    "u̲", "n̲", "d̲", "e̲", "r̲", "l̲", "i̲", "n̲", "e̲", "d̲"]
  var i = 0
  for c in graphemes("u̲n̲d̲e̲r̲l̲i̲n̲e̲d̲"):
    check c == expected[i]
    inc i

test "Test all code points":
  for i in 0 .. 0x10FFFF:
    discard graphemes(Rune(i).toUTF8)

test "Test graphemes sub string":
  check "".graphemesSubStr(0, 10) == ""
  check "".graphemesSubStr(0, -1) == ""
  check "abc".graphemesSubStr(0, 10) == "abc"
  check "abc".graphemesSubStr(0, -1) == ""
  check "abc".graphemesSubStr(10) == ""
  check "abc".graphemesSubStr(10, 100) == ""
  check "abc".graphemesSubStr(10, 1) == ""
  block:
    const s = "abcd"
    check s.graphemesSubStr(0, 0) == "a"
    check s.graphemesSubStr(3, 3) == "d"
    check s.graphemesSubStr(0) == s
    check s.graphemesSubStr(1) == "bcd"
    check s.graphemesSubStr(1, 2) == "bc"
  block:
    # flag, family, yawn, vampire, pinch, diving mask
    const s = "🇦🇷👨‍👩‍👧‍👦🥱🧛🏻‍♂️🤏🤿"
    check s.graphemesSubStr(0, 0) == "🇦🇷"
    check s.graphemesSubStr(1, 1) == "👨‍👩‍👧‍👦"
    check s.graphemesSubStr(2, 2) == "🥱"
    check s.graphemesSubStr(3, 3) == "🧛🏻‍♂️"
    check s.graphemesSubStr(4, 4) == "🤏"
    check s.graphemesSubStr(5, 5) == "🤿"
    check s.graphemesSubStr(0) == s
    check s.graphemesSubStr(1) == "👨‍👩‍👧‍👦🥱🧛🏻‍♂️🤏🤿"
    check s.graphemesSubStr(1, 3) == "👨‍👩‍👧‍👦🥱🧛🏻‍♂️"
    check s.graphemesSubStr(2, 3) == "🥱🧛🏻‍♂️"

test "Test reverse graphemes in-place":
  block:
    var s = "abc"
    s.graphemesReverse
    check s == "cba"
  block:
    var s = "🇦🇷"
    s.graphemesReverse
    check s == "🇦🇷"
  block:
    var s = "🇦🇷🇦🇷"
    s.graphemesReverse
    check s == "🇦🇷🇦🇷"
  block:
    var s = "🇦🇷🇺🇾🇨🇱"
    s.graphemesReverse
    check s == "🇨🇱🇺🇾🇦🇷"
  block:
    var s = "🇦🇷👨‍👩‍👧‍👦🥱🧛🏻‍♂️🤏🤿"
    s.graphemesReverse
    check s == "🤿🤏🧛🏻‍♂️🥱👨‍👩‍👧‍👦🇦🇷"
  block:
    var s = "u̲n̲d̲e̲r̲l̲i̲n̲e̲d̲"
    s.graphemesReverse
    check s == "d̲e̲n̲i̲l̲r̲e̲d̲n̲u̲"

test "graphemesTruncate":
  block:
    var s = "u̲n̲d̲e̲r̲l̲i̲n̲e̲d̲"
    graphemesTruncate(s, 8, "...")
    check s == "u̲n̲d̲e̲r̲..."
  block:
    var s = "u̲n̲d̲e̲r̲l̲i̲n̲e̲d̲"
    graphemesTruncate(s, 8, "n̲e̲d̲")
    check s == "u̲n̲d̲e̲r̲n̲e̲d̲"
  block:
    var s = "u̲n̲d̲e̲r̲l̲i̲n̲e̲d̲"
    graphemesTruncate(s, 10, "...")
    check s == "u̲n̲d̲e̲r̲l̲i̲n̲e̲d̲"
    graphemesTruncate(s, 9, "...")
    check s == "u̲n̲d̲e̲r̲l̲..."
  block:
    var s = "u̲n̲d̲e̲r̲l̲i̲n̲e̲d̲"
    graphemesTruncate(s, 20)
    check s == "u̲n̲d̲e̲r̲l̲i̲n̲e̲d̲"
    graphemesTruncate(s, 10)
    check s == "u̲n̲d̲e̲r̲l̲i̲n̲e̲d̲"
    graphemesTruncate(s, 9)
    check s == "u̲n̲d̲e̲r̲l̲i̲n̲e̲"
    graphemesTruncate(s, 5)
    check s == "u̲n̲d̲e̲r̲"
    graphemesTruncate(s, 0)
    check s == ""
    graphemesTruncate(s, 0, "...")
    check s == ""
  block:
    var s = "🇦🇷🇺🇾🇨🇱"
    graphemesTruncate(s, 2)
    check s == "🇦🇷🇺🇾"

test "graphemesTruncateBytes":
  block:
    var s = "u̲n̲d̲e̲r̲l̲i̲n̲e̲d̲"
    graphemesTruncateBytes(s, 20, "...")
    check s == "u̲n̲d̲e̲r̲..."
    check s.len == 18
  block:
    var s = "u̲n̲d̲e̲r̲l̲i̲n̲e̲d̲"
    graphemesTruncateBytes(s, 20)
    check s == "u̲n̲d̲e̲r̲l̲"
    check s.len == 18
  block:
    var s = "u̲n̲"
    graphemesTruncateBytes(s, s.len)
    check s == "u̲n̲"
    graphemesTruncateBytes(s, s.len-1)
    check s == "u̲"
    graphemesTruncateBytes(s, s.len-1)
    check s == ""
  block:
    var s = ""
    graphemesTruncateBytes(s, 20, "...")
    check s == ""
  block:
    var s = "abc"
    graphemesTruncateBytes(s, 20, "...")
    check s == "abc"
    graphemesTruncateBytes(s, 3, "...")
    check s == "abc"
    graphemesTruncateBytes(s, 3)
    check s == "abc"
    graphemesTruncateBytes(s, 2)
    check s == "ab"
    graphemesTruncateBytes(s, 2, "...")
    check s == "ab"
    graphemesTruncateBytes(s, 1, "...")
    check s == ""
  block:
    var s = "🇦🇷🇺🇾🇨🇱"
    graphemesTruncateBytes(s, 20)
    check s == "🇦🇷🇺🇾"
    check s.len == 16
