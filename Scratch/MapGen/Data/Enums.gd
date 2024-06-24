extends RefCounted

class_name Enums

enum Terrain {
  DESERT,
  GRASS,
  CONCRETE,
}

static func TerrainName(t: Terrain) -> String:
  match t:
    Terrain.DESERT:
      return 'DESERT'
    Terrain.GRASS:
      return 'GRASS'
    Terrain.CONCRETE:
      return 'CONCRETE'
  return 'UNKNOWN'