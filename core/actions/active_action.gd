class_name ActiveAction
extends Action

@export var action_name: StringName = &"action"
@export var ability: Ability


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed(action_name):
		ability.execute()
