extends Node2D

@export var _level_template: PackedScene

@onready var _board_display: BoardDisplay = $BoardDisplay
@onready var _menu: CanvasLayer = $HUD/Menu
@onready var _game_ui: CanvasLayer = $HUD/GameUI

var _rules : GameRules

var _board: GameBoard
var _cur_state: Enums.GameState = Enums.GameState.Menu

func _on_start_game() -> void:
	set_state(Enums.GameState.Play)

func _on_quit_game() -> void:
	set_state(Enums.GameState.Quit)

func _init_board() -> void:
	var level: LevelTemplate = _level_template.instantiate()
	_board_display.setup(level)
	_board = level.generate_board()
	_board.init_for_play()
	level.reify(_board)

func set_state(new_state: Enums.GameState) -> void:
	if _cur_state == Enums.GameState.Menu:
		if new_state == Enums.GameState.Quit:
			get_tree().quit()
		if new_state == Enums.GameState.Play:
			_hide_menu()
			_start_game()

func _hide_menu() -> void:
	_menu.visible = false

func _start_game() -> void:
	_init_board()
	_game_ui.visible = true
	_rules = GameRules.new(_game_ui, _board_display, _board)