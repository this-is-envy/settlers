extends RefCounted

class_name GameBoard

var __tiles: Dictionary = {}

static func new_with_tiles(tiles: Array[Hex]) -> GameBoard:
  var gb := GameBoard.new()
  for hex in tiles:
    gb.__tiles[hex.coords._to_string()] = hex
  return gb

func init_for_play() -> void:
  var values: Array = Enums.Terrain.values()
  for k in __tiles.keys():
    __tiles[k].terrain = randi() % values.size()
    print(__tiles[k])

func tiles() -> Array[Hex]:
  return __tiles.values()