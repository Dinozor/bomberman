class_name DuckAction
extends Action

@export var character: CharacterBody2D
@export var _action_name: StringName = &"duck"
@export var _duck_speed_modifier: float = 2.0
@export var _duck_collider: CollisionShape2D
@export var _stand_collider: CollisionShape2D


func _ready() -> void:
	if not character and owner is Character:
		character = owner
	_stand_collider.disabled = false
	_duck_collider.disabled = true


func _physics_process(delta: float) -> void:
	if not _duck_collider.disabled:
		character.velocity.x -= character.velocity.x * _duck_speed_modifier * delta


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed(_action_name):
		_stand_collider.disabled = true
		_duck_collider.disabled = false
	if event.is_action_released(_action_name):
		_stand_collider.disabled = false
		_duck_collider.disabled = true
