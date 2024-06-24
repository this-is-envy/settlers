extends Node2D

class_name LevelTemplate

const PLAYABLE_LAYER = 1

@onready var __tilemap = $TileMap

func generate_board() -> GameBoard:
	var coords = __tilemap.get_used_cells(PLAYABLE_LAYER)

	var hexes: Array[Hex] = []
	for c in coords:
		var h := Hex.FromTile(c, Utils.atlas_to_terrain(__tilemap.get_cell_atlas_coords(PLAYABLE_LAYER, c)))
		hexes.append(h)

	return GameBoard.new_with_tiles(hexes)