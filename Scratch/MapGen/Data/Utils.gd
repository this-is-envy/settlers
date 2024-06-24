extends RefCounted

class_name Utils

const TERRAIN_TO_ATLAS = {
  Enums.Terrain.DESERT: Vector2(2, 3),
  Enums.Terrain.GRASS: Vector2(5, 1),
  Enums.Terrain.CONCRETE: Vector2(0, 12),
}

const ATLAS_TO_TERRAIN = {
  "2,3": Enums.Terrain.DESERT,
  "5,1": Enums.Terrain.GRASS,
  "0,12": Enums.Terrain.CONCRETE,
}

static func terrain_to_atlas(ter: Enums.Terrain) -> Vector2:
  return TERRAIN_TO_ATLAS[ter]

static func atlas_to_terrain(coords: Vector2) -> Enums.Terrain:
  var key: String = "%d,%d" % [coords[0], coords[1]]
  return ATLAS_TO_TERRAIN[key]