# nim-graphemes

[![Build Status](https://img.shields.io/travis/nitely/nim-graphemes.svg?style=flat-square)](https://travis-ci.org/nitely/nim-graphemes)
[![licence](https://img.shields.io/github/license/nitely/nim-graphemes.svg?style=flat-square)](https://raw.githubusercontent.com/nitely/nim-graphemes/master/LICENSE)

A Nim library for grapheme aware string handling (Unicode tr29).
The splitting is made through a fast DFA.

## Install

```
nimble install graphemes
```

## Compatibility

* Nim 0.19, 0.20, +1.0


## Usage

```nim
import graphemes

# Iterate over graphemes
block:
  let expected = [
    "u̲", "n̲", "d̲", "e̲", "r̲", "l̲", "i̲", "n̲", "e̲", "d̲"]
  var i = 0
  for c in graphemes("u̲n̲d̲e̲r̲l̲i̲n̲e̲d̲"):
    doAssert c == expected[i]
    inc i

assert graphemesCount("u̲n̲d̲e̲r̲l̲i̲n̲e̲d̲") == 10
assert graphemesCount("ю́") == 1
assert graphemesCount("👨‍👩‍👧‍👦") == 1  # Family of 4 emoji

# Get number of bytes the grapheme at index 0 takes
assert graphemeLenAt("u̲n̲d̲e̲r̲", 0) == 3
assert graphemeLenAt("ю́", 0) == 4

# Reverse graphemes
block:
  var s = "🇦🇷🇺🇾🇨🇱"
  s.graphemesReverse
  assert s == "🇨🇱🇺🇾🇦🇷"

# Remove last grapheme
block:
  var s = "u̲n̲d̲e̲r̲l̲i̲n̲e̲d̲"
  s.setLen(s.len - s.graphemeLenAt(^1))
  assert s == "u̲n̲d̲e̲r̲l̲i̲n̲e̲"

# Get sub-string
block:
  # This string contains the following emoji:
  # "flag, family, yawn, vampire, pinch, and diving mask"
  const s = "🇦🇷👨‍👩‍👧‍👦🥱🧛🏻‍♂️🤏🤿"
  assert s.graphemesSubStr(1, 3) == "👨‍👩‍👧‍👦🥱🧛🏻‍♂️"

# Truncate to a limit of graphemes
block:
  var s = "🇦🇷🇺🇾🇨🇱"
  graphemesTruncate(s, 2)
  assert s == "🇦🇷🇺🇾"
block:
  var s = "u̲n̲d̲e̲r̲l̲i̲n̲e̲d̲"
  graphemesTruncate(s, 8, "...")
  assert s == "u̲n̲d̲e̲r̲..."

# Truncate to a limit of bytes preserving the graphemes
block:
  var s = "🇦🇷🇺🇾🇨🇱"
  graphemesTruncateBytes(s, 20)
  assert s == "🇦🇷🇺🇾"
  assert s.len == 16
```
|  
|  
 -> [docs](https://nitely.github.io/nim-graphemes/)

## Tests

```
$ nimble test
```


## License

MIT
