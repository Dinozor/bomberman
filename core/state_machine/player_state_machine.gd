class_name PlayerStateMachine
extends Node

@export var _player: Character
@export var _animated_sprite: AnimatedSprite2D
@export var _duck_collider: CollisionShape2D


func _physics_process(_delta: float) -> void:
	if not _duck_collider.disabled:
		_animated_sprite.play(&"duck")
		return
	if _player.is_on_floor():
		if _player.get_direction() == 0.0:
			_animated_sprite.play(&"idle")
		else:
			_animated_sprite.play(&"walk")
	else:
		_animated_sprite.play(&"jump")
