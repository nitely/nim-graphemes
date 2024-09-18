import std/tables
import std/strutils
import std/math

from ./gen_re import identifiers

const
  typeDefault = identifiers.find("Any")
  maxCP = 0x10FFFF

assert typeDefault >= 0

proc parse(filePath: string): seq[int] =
  # This used to be a nim Table but it was painfully slow
  var data = newSeq[int](maxCP + 1)
  for i in 0 .. maxCP:
    data[i] = typeDefault
  for line in lines(filePath):
    if len(line.strip()) == 0:
      continue
    if line.startswith('#'):
      continue
    let lineParts = line.split(";", 1)
    let ch = lineParts[0].strip()
    var tp = lineParts[1].split("#", 1)[0].strip()
    if tp == "Regional_Indicator":
      tp = "RI"
    let cpType = identifiers.find(tp)
    if cpType == -1:
      echo tp
    doAssert cpType >= 0
    if ".." in ch:
      let chRange = ch.split("..", 1)
      for hx in parseHexInt("0x$#" % chRange[0]) .. parseHexInt("0x$#" % chRange[1]):
        assert data[hx] == typeDefault
        data[hx] = cpType
    else:
      let hx = parseHexInt("0x$#" % ch)
      assert data[hx] == typeDefault
      data[hx] = cpType
  return data

proc parseEmoji(filePath: string): seq[int] =
  var data = newSeq[int](maxCP + 1)
  for i in 0 .. maxCP:
    data[i] = typeDefault
  for line in lines(filePath):
    if len(line.strip()) == 0:
      continue
    if line.startswith('#'):
      continue
    let
      lineParts = line.split(";", 1)
      ch = lineParts[0].strip()
      tp = lineParts[1].split("#", 1)[0].strip()
    if tp != "Extended_Pictographic":
      continue
    let cpType = identifiers.find(tp)
    assert cpType >= 0
    if ".." in ch:
      let chRange = ch.split("..", 1)
      for hx in parseHexInt("0x$#" % chRange[0]) .. parseHexInt("0x$#" % chRange[1]):
        data[hx] = cpType
    else:
      data[parseHexInt("0x$#" % ch)] = cpType
  return data

proc parseDcp(filePath: string): seq[int] =
  # parse derived core properties
  var data = newSeq[int](maxCP + 1)
  for i in 0 .. maxCP:
    data[i] = typeDefault
  for line in lines(filePath):
    if len(line.strip()) == 0:
      continue
    if line.startswith('#'):
      continue
    let lineParts = line.split(";")
    let ch = lineParts[0].strip()
    let tp = lineParts[1].strip()
    if tp != "InCB":
      continue
    let tp2 = lineParts[2].split("#", 1)[0].strip()
    let cpType = identifiers.find(tp & "_" & tp2)
    if cpType == -1:
      echo tp
    doAssert cpType >= 0
    if ".." in ch:
      let chRange = ch.split("..", 1)
      for hx in parseHexInt("0x$#" % chRange[0]) .. parseHexInt("0x$#" % chRange[1]):
        assert data[hx] == typeDefault
        data[hx] = cpType
    else:
      let hx = parseHexInt("0x$#" % ch)
      assert data[hx] == typeDefault
      data[hx] = cpType
  return data

proc buildData*(): seq[int] =
  result = parse("./gen/GraphemeBreakProperty.txt")
  let emoji = parseEmoji("./gen/emoji-data.txt")
  for cp, typ in pairs emoji:
    if typ != typeDefault:
      assert result[cp] == typeDefault
      result[cp] = typ
  let incb = parseDcp("./gen/DerivedCoreProperties.txt")
  # this fixes overlaps
  let incbExtend = identifiers.find("InCB_Extend")
  let incbLinker = identifiers.find("InCB_Linker")
  let extend = identifiers.find("Extend")
  let zwj = identifiers.find("ZWJ")
  assert incbExtend >= 0 and incbLinker >= 0 and extend >= 0
  for cp, typ in pairs incb:
    if typ == incbExtend:
      if result[cp] != zwj:
        doAssert result[cp] == extend, $cp
        result[cp] = typ
    elif typ == incbLinker:
      doAssert result[cp] == extend, $cp
      result[cp] = typ
    elif typ != typeDefault:
      doAssert result[cp] == typeDefault
      result[cp] = typ

type Stages = ref object
  stage1: seq[int]
  stage2: seq[seq[int]]

# data is a seq of code_point_int (index) -> break_type_int
# block size is any power of 2
proc makeTable(data: seq[int], blockSize: int): Stages =
  let blocksCount = (maxCP + 1) div blockSize
  var stage1 = newSeq[int](blocksCount)
  var stage2: seq[seq[int]] = @[]

  for i in 0 ..< blocksCount:
    var
      blockOffset = i * blockSize
      typesBlock = newSeq[int](blockSize)

    for j in 0 ..< blockSize:
      typesBlock[j] = data[blockOffset + j]

    let blockIndex = stage2.find(typesBlock)

    if blockIndex >= 0:
      stage1[i] = blockIndex
    else:
      stage1[i] = len(stage2)
      stage2.add(typesBlock)

  return Stages(stage1: stage1, stage2: stage2)


proc findBestTable(data: seq[int], block_size: var int): Stages =
  var best = -1
  var i = 1
  var stages = Stages(stage1: @[], stage2: @[])

  while true:
    let stagesTmp = makeTable(data, 2 ^ i)
    let total = len(stagesTmp.stage1) + len(stagesTmp.stage2) * (2 ^ i)
    # echo $total

    if total > best and best >= 0:
      break

    best = total
    i += 1
    stages = stagesTmp

  block_size = 2 ^ (i - 1)
  return stages


const graphemeBreakTemplate = """## Two-level table
## This is auto-generated. Do not modify it

import unicode

const graphemeIndexes = [
  $#
]

const graphemeTypes = [
  $#
]

const blockSize = $#

proc genAsciiTypes(): array[128, int8] =
  assert blockSize <= 128
  const blockOffset = 0
  const types = graphemeTypes[blockOffset]
  for i in 0 .. result.len-1:
    result[i] = types[i]

const asciiTypes = genAsciiTypes()

proc graphemeType*(r: Rune): int {.inline.} =
  assert r.int <= 0x10FFFF
  if r.int < 128:
    return asciiTypes[r.int]
  let blockOffset = graphemeIndexes[r.int32 div blockSize].int
  return graphemeTypes[blockOffset][r.int32 mod blockSize].int
"""


when isMainModule:
  let data = buildData()
  var blockSize = 0
  let stages = findBestTable(data, blockSize)

  var stage2 = newSeq[string](len(stages.stage2))
  for i, t in stages.stage2:
    stage2[i] = "[$#]" % [join(t, "'i8, ")]

  var f = open("./src/graphemes/grapheme_break.nim", fmWrite)
  try:
    f.write(graphemeBreakTemplate % [
      join(stages.stage1, "'u8,\n  "),
      join(stage2, ",\n  "),
      $blockSize])
  finally:
    close(f)
