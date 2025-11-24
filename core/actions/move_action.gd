class_name MoveAction
extends Action

@export var character: Player
@export var acceleration: float = 150.0
@export var max_speed: float = 300.0
@export var _move_left_action_name: StringName = &"move_left"
@export var _move_right_action_name: StringName = &"move_right"


func _ready() -> void:
	if not character and owner is Player:
		character = owner


func _physics_process(delta: float) -> void:
	if Input.is_action_pressed(_move_right_action_name):
		_walk_right(delta)
	if Input.is_action_pressed(_move_left_action_name):
		_walk_left(delta)


func _walk_right(delta: float) -> void:
	character.look_right()
	if character.velocity.x >= max_speed:
		return

	# if character.is_on_floor():
	var new_velocity_x: float = character.velocity.x + acceleration * delta
	character.velocity.x = min(max_speed, new_velocity_x)


func _walk_left(delta: float) -> void:
	character.look_left()
	if character.velocity.x <= -max_speed:
		return

	# if character.is_on_floor():
	var new_velocity_x: float = character.velocity.x - acceleration * delta
	character.velocity.x = max(-max_speed, new_velocity_x)
