class_name IdleState
extends State

@export var _animated_sprite: AnimatedSprite2D
@export var _duck_state: State
var _state_machine: StateMachine


func _ready() -> void:
	var parent: Node = get_parent()
	assert(parent is StateMachine, "Must be child of StateMachine")
	_state_machine = parent
	set_process_unhandled_input(false)


func enter() -> void:
	set_process_unhandled_input(true)
	_animated_sprite.play(&"idle")


func exit() -> void:
	set_process_unhandled_input(false)


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed(&"duck"):
		_state_machine.transition_to(_duck_state)
