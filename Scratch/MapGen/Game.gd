extends Node2D

@export var level_template: PackedScene

var __level: LevelTemplate
var board: GameBoard

func _ready() -> void:
	__reset()
	__generate_board()

# 1. removes previous level
# 2. unsets the gameboard state associated with it
# 3. instantiates + adds a new level template
func __reset() -> void:
	if __level != null:
		remove_child(__level)
		__level.queue_free()
		board = null

	__level = level_template.instantiate()
	add_child(__level)

func __generate_board() -> void:
	if board == null:
			board = __level.generate_board()

	board.init_for_play()
	__level.reify(board)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed('ui_accept'):
		__reset()
		__generate_board()