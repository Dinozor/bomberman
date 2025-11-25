class_name AbilityContext
extends RefCounted

static var _game_manager: GameManager = GameManager

var _owner: Character
var target: Node2D
var position: Vector2i


func _init(owner: Character = null) -> void:
	_owner = owner


func get_owner() -> Character:
	return _owner


func get_level() -> Level:
	return _game_manager.current_level

# func map_to_world(position: Vector2i) -> Vector2:
