# Package

version       = "0.1.0"
author        = "Esteban Castro Borsani (@nitely)"
description   = "Grapheme aware string handling (Unicode tr29)"
license       = "MIT"
srcDir = "src"
skipDirs = @["tests"]

# Dependencies

requires "nim >= 0.17.0"

task tests, "Test":
  exec "nim c -r tests/tests"
  rmFile "tests/tests"
