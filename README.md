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

* Nim +0.18.0


## Usage

```nim
import graphemes

for c in graphemes("u̲n̲d̲e̲r̲l̲i̲n̲e̲d̲"):
  echo c

assert graphemesCount("u̲n̲d̲e̲r̲l̲i̲n̲e̲d̲") == 10
assert graphemesCount("ю́") == 1
assert graphemesCount("👨‍👩‍👧‍👦") == 1

# Get number of bytes the grapheme at index 0 takes
assert graphemeLenAt("u̲n̲d̲e̲r̲", 0) == 2
assert graphemeLenAt("ю́", 0) == 4

block:
  var s = "u̲n̲d̲e̲r̲l̲i̲n̲e̲d̲"
  s.setLen(s.len - s.graphemeLenAt(^1))
  assert s == "u̲n̲d̲e̲r̲l̲i̲n̲e̲"
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
