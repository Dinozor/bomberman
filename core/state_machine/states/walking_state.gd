class_name WalkingState
extends State

@export var _player: Player
@export var _animated_sprite: AnimatedSprite2D
@export var _idle_state: State
@export var _jump_state: State

var _state_machine: StateMachine


func _ready() -> void:
	var parent: Node = get_parent()
	assert(parent is StateMachine, "Must be child of StateMachine")
	_state_machine = parent
	set_process_unhandled_input(false)
	set_physics_process(false)


func _physics_process(_delta: float) -> void:
	if Input.is_action_pressed(&"move_left"):
		_player.execute_left_ability()
	if Input.is_action_pressed(&"move_right"):
		_player.execute_right_ability()


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_released(&"move_left") and not Input.is_action_pressed(&"move_right"):
		_state_machine.transition_to(_idle_state)
		return

	if event.is_action_released(&"move_right") and not Input.is_action_pressed(&"move_left"):
		_state_machine.transition_to(_idle_state)
		return
	if event.is_action_pressed(&"jump"):
		_state_machine.transition_to(_jump_state)


func enter() -> void:
	_animated_sprite.play(&"walk")
	set_process_unhandled_input(true)
	set_physics_process(true)


func exit() -> void:
	set_process_unhandled_input(false)
	set_physics_process(false)
