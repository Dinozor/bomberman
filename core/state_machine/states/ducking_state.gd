class_name DuckingState
extends State

@export var _animated_sprite: AnimatedSprite2D
@export var _duck_collider: CollisionShape2D
@export var _stand_collider: CollisionShape2D
@export var _idle_state: State
var _state_machine: StateMachine


func _ready() -> void:
	var parent: Node = get_parent()
	assert(parent is StateMachine, "Must be child of StateMachine")
	_state_machine = parent
	set_process_unhandled_input(false)


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_released(&"duck"):
		_state_machine.transition_to(_idle_state)


func enter() -> void:
	set_process_unhandled_input(true)
	_animated_sprite.play(&"duck")
	_stand_collider.disabled = true
	_duck_collider.disabled = false


func exit() -> void:
	_stand_collider.disabled = false
	_duck_collider.disabled = true
	set_process_unhandled_input(false)
