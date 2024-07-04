class_name GameBoard
extends RefCounted

# TileCoords (as String) -> Hex
var _tiles: Dictionary = {}

var _rng: RandomNumberGenerator

func _init() -> void:
  _rng = RandomNumberGenerator.new()

static func new_with_tiles(hex_arry: Array[Hex]) -> GameBoard:
  var gb := GameBoard.new()
  for hex in hex_arry:
    gb._tiles[hex.coords._to_string()] = hex
  return gb

func init_for_play() -> void:
  var values: Array = Enums.Terrain.values()
  var value_sz := values.size() - 1
  for k: String in _tiles.keys():
    if _tiles[k].terrain == Enums.Terrain.ALLOCATE:
      _tiles[k].terrain = _rng.randi_range(1, value_sz)

func tiles() -> Array[Hex]:
  var a: Array[Hex] = []
  a.assign(_tiles.values())
  return a

func get_tile(coords: TileCoords) -> Hex:
  var key := coords.to_string()
  if _tiles.has(key):
    return _tiles[key]
  else:
    return null