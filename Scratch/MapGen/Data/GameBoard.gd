extends RefCounted

class_name GameBoard

var __tiles: Dictionary = {}

var __rng

func _init() -> void:
  __rng = RandomNumberGenerator.new()

static func new_with_tiles(hex_arry: Array[Hex]) -> GameBoard:
  var gb := GameBoard.new()
  for hex in hex_arry:
    gb.__tiles[hex.coords._to_string()] = hex
  return gb

func init_for_play() -> void:
  var values: Array = Enums.Terrain.values()
  var value_sz := values.size() - 1
  for k in __tiles.keys():
    if __tiles[k].terrain == Enums.Terrain.ALLOCATE:
      __tiles[k].terrain = __rng.randi_range(1, value_sz)

func tiles() -> Array[Hex]:
  var a: Array[Hex] = []
  a.assign(__tiles.values())
  return a
