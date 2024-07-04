class_name LevelTemplate
extends Node2D

const PLAYABLE_LAYER = 1
const TILEMAP_SOURCE = 0

@onready var _tilemap: TileMap = $TileMap

signal tile_focus(coords: TileCoords)
signal tile_selected(coords: TileCoords)

func generate_board() -> GameBoard:
	var coords := _tilemap.get_used_cells(PLAYABLE_LAYER)

	var hexes: Array[Hex] = []
	for c in coords:
		var h := Hex.FromTile(c, Utils.atlas_to_terrain(_tilemap.get_cell_atlas_coords(PLAYABLE_LAYER, c)))
		hexes.append(h)

	return GameBoard.new_with_tiles(hexes)

func reify(gb: GameBoard) -> void:
	for h: Hex in gb.tiles():
		var xy := h.coords.xy
		_tilemap.set_cell(PLAYABLE_LAYER, xy, TILEMAP_SOURCE, Utils.terrain_to_atlas(h.terrain))

func _unhandled_input(event: InputEvent) -> void:
	if !(event is InputEventMouse):
		return

	var local_xy: Vector2 = _tilemap.get_local_mouse_position()
	var map_coords: Vector2 = _tilemap.local_to_map(local_xy)

	var td :=_tilemap.get_cell_tile_data(PLAYABLE_LAYER, map_coords)
	if td == null:
		tile_focus.emit(null)
		return

	var tile_coords := TileCoords.FromXYVector(map_coords)
	if event is InputEventMouseMotion:
		tile_focus.emit(tile_coords)
	if event is InputEventMouseButton:
		if event.is_pressed() && event.button_index == MOUSE_BUTTON_LEFT:
			tile_selected.emit(tile_coords)
			# TODO: maybe?
			# get_viewport().set_input_as_handled()