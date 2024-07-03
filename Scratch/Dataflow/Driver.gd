extends Node2D

@export var _level_template: PackedScene

@onready var _board_display: BoardDisplay = $BoardDisplay

var _board: GameBoard

func _ready() -> void:
	var level: LevelTemplate = _level_template.instantiate()
	_board_display.setup(level)
	_board = level.generate_board()
	_board.init_for_play()
	level.reify(_board)
