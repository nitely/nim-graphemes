import tables
import strutils
import math

from gen_re import identifiers


proc parse*(filePath: string): TableRef[int, int] =
  var data = newTable[int, int]()

  for line in lines(filePath):
    if len(line.strip()) == 0:
      continue
    if line.startswith('#'):
      continue

    var
      ch = line.split(";", 1)[0].strip()
      tp = line.split(";", 1)[1].split("#", 1)[0].strip()
      cpType = identifiers.find(tp)

    assert cpType >= 0

    if ch.contains(".."):
      var chRange = ch.split("..", 1)

      for hx in parseHexInt("0x$#" % chRange[0])..parseHexInt("0x$#" % chRange[1]):
        data[hx] = cpType
    else:
      data[parseHexInt("0x$#" % ch)] = cpType

  return data


const
  typeDefault = identifiers.find("Any")
  maxCP = 0x10FFFF

assert typeDefault >= 0


type Stages = ref object
  stage1: seq[int]
  stage2: seq[seq[int]]


# data is a hashmap of code_point_int, break_type_int
# block size is any power of 2
proc makeTable(data: TableRef[int, int], blockSize: int): Stages =
  let blocksCount = maxCP div blockSize
  var stage1 = newSeq[int](blocksCount)
  var stage2: seq[seq[int]] = @[]
  # max_cp = max(data)[0]

  for i in 0..blocksCount:
    var
      blockOffset = i * blockSize
      typesBlock = newSeq[int](blockSize)

    for j in 0..blockSize - 1:
      try:
        typesBlock[j] = data[blockOffset + j]
      except KeyError:
        typesBlock[j] = typeDefault

    let blockIndex = stage2.find(typesBlock)

    if blockIndex >= 0:
      stage1[i] = blockIndex
    else:
      stage1[i] = len(stage2)
      stage2.add(typesBlock)

  return Stages(stage1: stage1, stage2: stage2)


proc findBestTable(data: TableRef[int, int], block_size: var int): Stages =
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

const graphemeIndexes = [
  $#
]

const graphemeTypes = [
  $#
]

const blockSize = $#

proc graphemeType*(chr: int): int =
  assert chr < 0x110000
  var blockOffset = graphemeIndexes[chr div blockSize]
  return graphemeTypes[blockOffset][chr mod blockSize]
"""

## Run: nim c -d:release --run gen_grapheme_break.nim > ../src/graphemes/private/grapheme_break.nim
when isMainModule:
  var data = parse("./gen/GraphemeBreakProperty.txt")
  var blockSize = 0
  var stages = findBestTable(data, blockSize)

  var stage2: seq[string] = @[]
  for t in stages.stage2:
    stage2.add("[$#]" % [join(t, ", ")])

  var f = open("./src/graphemes/private/grapheme_break.nim", fmWrite)
  try:
    f.write(graphemeBreakTemplate % [
      join(stages.stage1, ",\n  "),
      join(stage2, ",\n  "),
      $blockSize])
  finally:
    close(f)
