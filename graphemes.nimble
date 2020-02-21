# Package

version = "0.7.0"
author = "Esteban Castro Borsani (@nitely)"
description = "Grapheme aware string handling (Unicode tr29)"
license = "MIT"
srcDir = "src"

skipDirs = @["tests", "gen"]

# Dependencies

requires "nim >= 0.19.0"

task test, "Test":
  exec "nim c -r tests/tests"

task gen_re, "Gen regex":
  exec "nim c -r gen/gen_re"

task gen_tables, "Gen break tables":
  exec "nim c -r gen/gen_grapheme_break"

task docs, "Docs":
  exec "nim doc2 -o:./docs/index.html ./src/graphemes.nim"
