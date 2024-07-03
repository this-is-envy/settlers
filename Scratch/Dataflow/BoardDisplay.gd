class_name BoardDisplay
extends Node2D

var _level: LevelTemplate

func setup(level: LevelTemplate) -> void:
	_level = level
	add_child(_level)