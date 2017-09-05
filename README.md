# nim-graphemes

[![licence](https://img.shields.io/pypi/l/regexy.svg?style=flat-square)](https://raw.githubusercontent.com/nitely/nim-graphemes/master/LICENSE)

A Nim library for grapheme aware string handling (Unicode tr29). The splitting is made through a fast DFA.


## Compatibility

* Nim +0.17.0


## Usage

```nim
import graphemes

for c in graphemes("u̲n̲d̲e̲r̲l̲i̲n̲e̲d̲"):
  echo c

echo len(graphemes("u̲n̲d̲e̲r̲l̲i̲n̲e̲d̲"))
# 10

echo len(graphemes("ю́"))
# 1
```


## Tests

```
$ nimble tests
```


## License

MIT
