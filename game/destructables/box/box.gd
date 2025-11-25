class_name Box
extends StaticBody2D

@export var objects_to_spawn: Array[PackedScene]
var _game_manager: GameManager
var _level: Level


func _ready() -> void:
	_game_manager = GameManager
	_level = _game_manager.get_current_level()
	_game_manager.level_changed.connect(_on_level_changed)


func destroy() -> void:
	if objects_to_spawn.is_empty():
		return
	var to_spawn: PackedScene = objects_to_spawn.pick_random()
	if to_spawn:
		var object: Node2D = to_spawn.instantiate()
		_level.object_holder.add_child(object)
	queue_free()


func _on_level_changed(level: Level) -> void:
	_level = level
