extends Node2D

@export var level_template: PackedScene

var __level: LevelTemplate
var board: GameBoard

func _ready() -> void:
	__level = level_template.instantiate()
	add_child(__level)

func _unhandled_input(event: InputEvent) -> void:
	if !event.is_action_pressed('ui_accept'):
		return

	if board == null:
			board = __level.generate_board()

	board.init_for_play()