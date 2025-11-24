class_name JumpAction
extends Action

@export var character: CharacterBody2D
@export var jump_speed: float = 400.0
@export var action_name: StringName = &"jump"
@export var _sfx: AudioStream


func _ready() -> void:
	if not character and owner is CharacterBody2D:
		character = owner


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed(action_name):
		if character.is_on_floor():
			character.velocity.y -= jump_speed
			character.play_sfx(_sfx)
