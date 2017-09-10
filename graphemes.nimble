# Package

version       = "0.1.3"
author        = "Esteban Castro Borsani (@nitely)"
description   = "Grapheme aware string handling (Unicode tr29)"
license       = "MIT"
srcDir = "src"

skipDirs = @["tests", "gen"]

# Dependencies

requires "nim >= 0.17.0"

task tests, "Test":
  exec "nim c -r tests/tests"

task gen_re, "Gen regex":
  exec "nim c -r -d:release gen/gen_re"

task gen_tables, "Gen break tables":
  exec "nim c -r -d:release gen/gen_grapheme_break"
