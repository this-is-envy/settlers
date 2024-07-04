class_name BoardDisplay
extends Node2D

var _level: LevelTemplate
var _last_focused: TileCoords

func setup(level: LevelTemplate) -> void:
	_level = level
	add_child(_level)

	_level.tile_selected.connect(_tile_selected)
	_level.tile_focus.connect(_tile_hover)

func _tile_selected(c: TileCoords) -> void:
	print('selected: ' + str(c))

func get_selected_tile() -> TileCoords:
	var selected: TileCoords = null
	while selected == null:
		selected = await _level.tile_selected
	return selected

func _tile_hover(c: TileCoords) -> void:
	_last_focused = c

func update(board: GameBoard) -> void:
	_level.reify(board)