class_name MoveAction
extends Action

@export var character: Character
@export var _move_left_action_name: StringName = &"move_left"
@export var _move_right_action_name: StringName = &"move_right"


func _ready() -> void:
	if not character and owner is Character:
		character = owner


func _physics_process(_delta: float) -> void:
	var dir: float = Input.get_axis(_move_left_action_name, _move_right_action_name)
	if dir != 0.0:
		if dir > 0.0:
			character.look_right()
		else:
			character.look_left()
	character.set_direction(dir)
