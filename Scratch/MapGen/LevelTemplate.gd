extends Node2D

class_name LevelTemplate

const PLAYABLE_LAYER = 1
const TILEMAP_SOURCE = 0

@onready var __tilemap = $TileMap

func generate_board() -> GameBoard:
	var coords = __tilemap.get_used_cells(PLAYABLE_LAYER)

	var hexes: Array[Hex] = []
	for c in coords:
		var h := Hex.FromTile(c, Utils.atlas_to_terrain(__tilemap.get_cell_atlas_coords(PLAYABLE_LAYER, c)))
		hexes.append(h)

	return GameBoard.new_with_tiles(hexes)

func reify(gb: GameBoard) -> void:
	for h: Hex in gb.tiles():
		var xy := h.coords.xy
		__tilemap.set_cell(PLAYABLE_LAYER, xy, TILEMAP_SOURCE, Utils.terrain_to_atlas(h.terrain))