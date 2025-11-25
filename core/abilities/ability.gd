@abstract class_name Ability
extends Node

@warning_ignore("unused_private_class_variable")
var _game_manager: GameManager
var _level: Level


func _init() -> void:
	_game_manager = GameManager
	_level = _game_manager.get_current_level()
	_game_manager.level_changed.connect(_on_level_changed)


@abstract func execute(
	_target_position: Vector2 = Vector2.ZERO,
	character: Character = null,
	# _target_object: Node2D = null,
) -> void


func _on_level_changed(level: Level) -> void:
	_level = level
