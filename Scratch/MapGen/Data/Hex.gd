extends RefCounted

class_name Hex

## TODO: add unique id per tile... maybe. Would require id->coords mapping etc
# var id: int
var coords: TileCoords
var terrain: Enums.Terrain

func map_coords() -> Vector2:
  return coords.xy

func _to_string() -> String:
  return "Hex(axial: (%d, %d) / even-r: %s): %s" % [
    coords.q, coords.r, str(coords.xy), Enums.TerrainName(terrain)]

static func FromTile(map_coords: Vector2, t: Enums.Terrain) -> Hex:
  var h := Hex.new()
  h.coords = TileCoords.FromXYVector(map_coords)
  h.terrain = t
  return h