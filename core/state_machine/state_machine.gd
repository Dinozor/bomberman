class_name StateMachine
extends Node

@export var default_state: State
var _states: Array[State]
var _active_state: State


func _ready() -> void:
	for child in get_children():
		if child is State:
			_states.push_back(child)

	if not default_state:
		default_state = _states[0]

	_active_state = default_state
	_active_state.enter()


func transition_to(state: State) -> void:
	_active_state.exit()
	_active_state = state
	_active_state.enter()
