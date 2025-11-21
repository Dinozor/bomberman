class_name Player
extends CharacterBody2D

@export var _speed: float = 150.0
@export var _jump_speed: float = 400.0
@export var _jump_sfx: AudioStreamPlayer2D

@export var _ability: Ability
@export var _spawn_point: Node2D

var _gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity", 980.0)


func _physics_process(delta: float) -> void:
	velocity.y += _gravity * delta
	velocity.x = Input.get_axis(&"move_left", &"move_right") * _speed

	move_and_slide()


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed(&"jump"):
		if is_on_floor():
			velocity.y -= _jump_speed
			_jump_sfx.play()

	if _ability and event.is_action_pressed(&"action"):
		_ability.execute(self, get_spawn_point())


func get_spawn_point() -> Vector2:
	return _spawn_point.global_position
