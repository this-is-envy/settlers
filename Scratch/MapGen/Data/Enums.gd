extends RefCounted

class_name Enums

enum Terrain {
  # by convention the allocation tile is 0 so we can trivially avoid
  # it during generation
  ALLOCATE,
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
    Terrain.ALLOCATE:
      return 'ALLOCATE'
  return 'UNKNOWN'