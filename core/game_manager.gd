# class_name GameManager # autoload
extends Node

signal level_changed(level: Level)
signal level_started(level: Level)

var _current_level: Level


func start(level: Level) -> void:
	set_current_level(level)
	level_started.emit(_current_level)


func get_current_level() -> Level:
	return _current_level


func set_current_level(level: Level) -> void:
	_current_level = level
	level_changed.emit(_current_level)
