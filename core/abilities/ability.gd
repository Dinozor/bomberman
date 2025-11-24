@abstract class_name Ability
extends Node

@warning_ignore("unused_private_class_variable")
var _game_manager: GameManager
var _level: Level
var _is_enabled: bool = true


func _init() -> void:
	_game_manager = GameManager
	_game_manager.level_changed.connect(_on_level_changed)


func enable() -> void:
	_is_enabled = true
	set_process_unhandled_input(true)
	set_physics_process(true)


func disable() -> void:
	_is_enabled = false
	set_process_unhandled_input(false)
	set_physics_process(false)


func is_enabled() -> bool:
	return _is_enabled


func _on_level_changed(level: Level) -> void:
	_level = level
