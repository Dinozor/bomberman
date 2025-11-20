class_name Player
extends CharacterBody2D

@export var _speed: float = 150.0
@export var _jump_speed: float = 400.0
@export var _jump_sfx: AudioStreamPlayer2D

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
